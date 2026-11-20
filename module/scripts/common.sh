#!/system/bin/sh
# ======================================================================
#  VD INSTALLER  ::  frictionless root sideload installer
#  Install sideload APKs as root (single/batch/split), no friction: KernelSU/APatch/Magisk WebUI.
#
#  Copyright (C) 2026  VD171
#  SPDX-License-Identifier: AGPL-3.0-or-later
#
#  Free software under the GNU AGPL v3 or later. NETWORK COPYLEFT: run a
#  modified version, even as a service, and you MUST offer its source.
#
#  Site           : https://vd171.ru
#  Site           : https://vd.priv8.ru
#  Source         : https://github.com/VD171/VD-Installer
#  GitHub         : @VD171 https://github.com/VD171
#  XDA-Developers : @VD171 https://xdaforums.com/m/vd171.4699873/
#  XDA thread     : https://xdaforums.com/t/VD-Installer.4809504/
#  Telegram       : @VD_Priv8 https://t.me/VD_Priv8
#  Channel        : @Priv8_VD https://t.me/Priv8_VD
#  Discord        : @VD.Priv8 https://discord.com/users/1296831918989639721
#  E-mail         : vd.priv8@pm.me
# ======================================================================

# Shared library sourced by helper.sh (WebUI contract) and worker.sh (heavy install engine).
# Single source of truth for the common helpers so the two never drift.

STATE=/data/adb/vdinstaller
LOGS="$STATE/logs"
STAGING="$STATE/staging"
CONFIG="$STATE/config.json"

# --- resolve ABI and bundled-binary PATH --------------------------------
abi="$(getprop ro.product.cpu.abi)"
case "$abi" in
  arm64-v8a)   BINABI=arm64-v8a   ;;
  armeabi-v7a) BINABI=armeabi-v7a ;;
  x86_64)      BINABI=x86_64      ;;
  x86)         BINABI=x86         ;;
  *)           BINABI=arm64-v8a   ;;
esac
BIN="$MODDIR/bin/$BINABI"
export PATH="$BIN:$PATH"
export LD_LIBRARY_PATH="$BIN/lib:${LD_LIBRARY_PATH:-}"
JQ="$BIN/jq"

mkdir -p "$LOGS" "$STAGING" 2>/dev/null

# pm/dumpsys are app_process based: run them with a CLEAN env, or the bundled Termux libs on
# LD_LIBRARY_PATH shadow ART's and binder marshalling fails on some ROMs. These wrappers shadow
# the bare calls; bundled binaries keep LD_LIBRARY_PATH via their full $BIN path.
pm()      { /system/bin/env -u LD_LIBRARY_PATH -u LD_PRELOAD PATH=/system/bin:/system_ext/bin:/vendor/bin:/product/bin /system/bin/pm "$@"; }
dumpsys() { /system/bin/env -u LD_LIBRARY_PATH -u LD_PRELOAD PATH=/system/bin:/system_ext/bin:/vendor/bin:/product/bin /system/bin/dumpsys "$@"; }
cmd()     { /system/bin/env -u LD_LIBRARY_PATH -u LD_PRELOAD PATH=/system/bin:/system_ext/bin:/vendor/bin:/product/bin /system/bin/cmd "$@"; }

# Every write-path shell enters init's mount namespace, matching the manager's own view.
# The `--` ends toybox nsenter's option parsing so the command after it is verbatim.
if command -v nsenter >/dev/null 2>&1; then exec_ns() { nsenter --mount=/proc/1/ns/mnt -- "$@"; }
else exec_ns() { "$@"; }; fi
fw() { exec_ns /system/bin/env -u LD_LIBRARY_PATH -u LD_PRELOAD PATH=/system/bin:/system_ext/bin:/vendor/bin:/product/bin "$@"; }

# --- JSON + logging helpers ---------------------------------------------
jstr() { printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\t/\\t/g'; }
ok()   { printf '{"ok":true,%s}\n'  "$1"; }
err()  { printf '{"ok":false,"code":"%s","message":"%s"}\n' "$1" "$(jstr "$2")"; }
jget() { printf '%s' "$1" | "$JQ" -r "$2" 2>/dev/null; }
cfg()  { "$JQ" -r "$1 // empty" "$CONFIG" 2>/dev/null; }
new_opid() { printf 'op-%s-%s' "$(date +%s)" "$$"; }
audit() { printf '{"ts":"%s","msg":"%s"}\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$(jstr "$1")" >> "$LOGS/audit.jsonl" 2>/dev/null; }

# --- ABX-aware system-XML editing (SSAID, packages.xml, netpolicy ...) ---
# HARD house rule: EVERY Android XML the module touches is checked for ABX (ABX\0 magic) and
# decoded before edit / re-encoded after. Primary = the device's AOSP abx2xml/xml2abx
# (app_process wrappers, so clear LD_LIBRARY_PATH or Termux libs shadow ART's libz); fallback =
# the bundled standalone converter (bin/<abi>, no app_process) for pre-A12 / where app_process fails.
is_abx() { [ "$(head -c3 "$1" 2>/dev/null)" = ABX ]; }
abx_to_xml() {
  if [ -x /system/bin/abx2xml ] && LD_LIBRARY_PATH= /system/bin/abx2xml "$1" "$2" 2>/dev/null && [ -s "$2" ]; then return 0; fi
  [ -x "$BIN/abx2xml" ] && "$BIN/abx2xml" "$1" "$2" 2>/dev/null && [ -s "$2" ]; }
xml_to_abx() {
  if [ -x /system/bin/xml2abx ] && LD_LIBRARY_PATH= /system/bin/xml2abx "$1" "$2" 2>/dev/null && [ -s "$2" ]; then return 0; fi
  [ -x "$BIN/xml2abx" ] && "$BIN/xml2abx" "$1" "$2" 2>/dev/null && [ -s "$2" ]; }
# Centralised ABX-aware in-place edit: decode -> <editor> on plaintext (<in> <out>) -> re-encode ->
# round-trip decode and assert <count-pat> count is unchanged (catches a lossy encode) -> optional
# <verify> on the re-decoded result -> backup live under <bakdir> -> atomic swap preserving
# owner/mode/SELinux. The live file is NEVER touched unless every step passed. Sets XMLEDIT_BAK.
xml_edit() {  # <file> <editor> <count-pat> <verify> <bakdir>
  _xf="$1"; _xe="$2"; _xcp="$3"; _xvf="$4"; _xbd="$5"; XMLEDIT_BAK=""
  [ -f "$_xf" ] || return 1
  _xabx=no; is_abx "$_xf" && _xabx=yes
  if [ "$_xabx" = yes ]; then { [ -x /system/bin/abx2xml ] && [ -x /system/bin/xml2abx ]; } || { [ -x "$BIN/abx2xml" ] && [ -x "$BIN/xml2abx" ]; } || return 1; fi
  _xi="$STAGING/xe.$OPID.in"; _xo="$STAGING/xe.$OPID.out"; _xn="$STAGING/xe.$OPID.enc"; _xc="$STAGING/xe.$OPID.chk"
  rm -f "$_xi" "$_xo" "$_xn" "$_xc"
  if [ "$_xabx" = yes ]; then abx_to_xml "$_xf" "$_xi" || { rm -f "$_xi"; return 1; }
  else cp "$_xf" "$_xi" || return 1; fi
  [ -s "$_xi" ] || { rm -f "$_xi"; return 1; }
  "$_xe" "$_xi" "$_xo" || { rm -f "$_xi" "$_xo"; return 1; }
  [ -s "$_xo" ] || { rm -f "$_xi" "$_xo"; return 1; }
  _xcb="$(grep -c "$_xcp" "$_xo" 2>/dev/null)"
  if [ "$_xabx" = yes ]; then xml_to_abx "$_xo" "$_xn" || { rm -f "$_xi" "$_xo" "$_xn"; return 1; }
  else cp "$_xo" "$_xn" || { rm -f "$_xi" "$_xo" "$_xn"; return 1; }; fi
  if [ "$_xabx" = yes ]; then abx_to_xml "$_xn" "$_xc" || { rm -f "$_xi" "$_xo" "$_xn" "$_xc"; return 1; }
  else cp "$_xn" "$_xc" || { rm -f "$_xi" "$_xo" "$_xn" "$_xc"; return 1; }; fi
  _xca="$(grep -c "$_xcp" "$_xc" 2>/dev/null)"
  [ "$_xcb" = "$_xca" ] || { rm -f "$_xi" "$_xo" "$_xn" "$_xc"; return 1; }
  if [ -n "$_xvf" ]; then "$_xvf" "$_xc" || { rm -f "$_xi" "$_xo" "$_xn" "$_xc"; return 1; }; fi
  if [ -n "$_xbd" ]; then
    mkdir -p "$_xbd"; chmod 700 "$_xbd" 2>/dev/null
    XMLEDIT_BAK="$_xbd/$(basename "$_xf")_$(date -u +%Y%m%dT%H%M%SZ)_$OPID.bak"
    cp "$_xf" "$XMLEDIT_BAK" 2>/dev/null || { XMLEDIT_BAK=""; rm -f "$_xi" "$_xo" "$_xn" "$_xc"; return 1; }
  fi
  _xown="$(stat -c '%u:%g' "$_xf" 2>/dev/null)"; _xmode="$(stat -c '%a' "$_xf" 2>/dev/null)"
  _xtmp="$(dirname "$_xf")/.xe.$OPID"
  cp "$_xn" "$_xtmp" 2>/dev/null || { rm -f "$_xi" "$_xo" "$_xn" "$_xc" "$_xtmp"; return 1; }
  case "$_xown" in *[0-9]:*[0-9]) chown "$_xown" "$_xtmp" 2>/dev/null ;; esac
  [ -n "$_xmode" ] && chmod "$_xmode" "$_xtmp" 2>/dev/null
  mv -f "$_xtmp" "$_xf" 2>/dev/null || { rm -f "$_xi" "$_xo" "$_xn" "$_xc" "$_xtmp"; return 1; }
  restorecon "$_xf" 2>/dev/null
  rm -f "$_xi" "$_xo" "$_xn" "$_xc"
  return 0
}
