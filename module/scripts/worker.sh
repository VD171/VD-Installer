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

# Heavy install engine. Runs detached (setsid from helper.sh), writes progress to
# $LOGS/progress-$OPID.json and a final done:true result there. POSIX sh, no bashisms.

MODDIR=${0%/*}; MODDIR=${MODDIR%/scripts}
. "$MODDIR/scripts/common.sh"

VERB="$1"; OPID="$2"; ARGS_B64="$3"
case "$OPID" in ''|*[!A-Za-z0-9._-]*) OPID="op-$$-$(date +%s)" ;; esac
ARGS="$(printf '%s' "$ARGS_B64" | base64 -d 2>/dev/null)"
[ -n "$ARGS" ] || ARGS='{}'

# move the worker's own pgid to the cgroup root so the app-freezer / phantom-killer cannot
# freeze a detached install when the manager goes to cache (same escape as VD-Backup).
echo $$ > /sys/fs/cgroup/cgroup.procs 2>/dev/null || true

set_prog() { # <percent> <phase> <item> <done-bool>
  printf '{"opid":"%s","percent":%s,"phase":"%s","item":"%s","done":%s}\n' \
    "$OPID" "$1" "$(jstr "$2")" "$(jstr "$3")" "$4" > "$LOGS/progress-$OPID.json" 2>/dev/null
}
finish_prog() { # <ok-bool> <percent> <phase> <extra-json>
  printf '{"opid":"%s","percent":%s,"phase":"%s","ok":%s,"done":true%s}\n' \
    "$OPID" "$2" "$(jstr "$3")" "$1" "${4:+,$4}" > "$LOGS/progress-$OPID.json" 2>/dev/null
}

# --- per-op override, else config.json ----------------------------------
arg_or_cfg() { _v="$(jget "$ARGS" "$1")"; case "$_v" in ""|null) cfg "$1" ;; *) printf '%s' "$_v" ;; esac; }

# --- pm install flags (toggles) -----------------------------------------
pm_install_flags() {
  _f="-r"
  [ "$(arg_or_cfg .allow_test)" = true ] && _f="$_f -t"
  [ "$(arg_or_cfg .allow_downgrade)" = true ] && _f="$_f -d"
  [ "$(arg_or_cfg .grant_all_perms)" = true ] && _f="$_f -g"
  if [ "$(arg_or_cfg .bypass_low_target_sdk)" = true ]; then
    fw pm install-create --help 2>&1 | grep -q 'bypass-low-target-sdk-block' && _f="$_f --bypass-low-target-sdk-block"
  fi
  printf '%s' "$_f"
}
user_flag() { _u="$(arg_or_cfg .target_user)"; case "$_u" in ''|null|*[!0-9]*) _u=0 ;; esac; printf -- '--user %s' "$_u"; }
# Install-source: present the source as the Play Store (installerPackageName) at install time via
# install-create -i. pm set-installer is rejected for uid 0, so it must be the session installer.
installer_flag() {
  _sp="$(arg_or_cfg .spoof_installer)"; case "$_sp" in true|false) ;; *) _sp=true ;; esac
  [ "$_sp" = true ] || return 0
  _ip="$(arg_or_cfg .spoof_installer_pkg)"; { [ -z "$_ip" ] || [ "$_ip" = null ]; } && _ip=com.android.vending
  printf -- '-i %s' "$_ip"
}

# --- Play Protect package verifier: 3-mode toggle -----------------------
# restore (default): turn off around the install, restore the EXACT prior state (delete when it was
# absent: a 0/1 where there was none is itself a stealth tell). always_on / always_off: force and
# persist. Canonical knobs: verifier_verify_adb_installs + package_verifier_user_consent (NOT
# package_verifier_enable, which the fleet health check reads as a fidelity signal).
V_OLD=""; C_OLD=""; VMODE=""; V_SAVED=""
verifier_apply() {
  VMODE="$(arg_or_cfg .verifier_mode)"; case "$VMODE" in always_on|always_off|restore) ;; *) VMODE=restore ;; esac
  V_OLD="$(fw settings get global verifier_verify_adb_installs 2>/dev/null)"
  C_OLD="$(fw settings get global package_verifier_user_consent 2>/dev/null)"
  V_SAVED=1
  case "$VMODE" in
    restore|always_off) fw settings put global verifier_verify_adb_installs 0 2>/dev/null; fw settings put global package_verifier_user_consent -1 2>/dev/null ;;
    always_on)          fw settings put global verifier_verify_adb_installs 1 2>/dev/null; fw settings put global package_verifier_user_consent 1 2>/dev/null ;;
  esac
  audit "verifier mode=$VMODE prior adb=$V_OLD consent=$C_OLD"
}
verifier_finish() {
  [ -n "$V_SAVED" ] || return 0
  case "$VMODE" in
    restore)
      case "$V_OLD" in ""|null) fw settings delete global verifier_verify_adb_installs 2>/dev/null ;; *) fw settings put global verifier_verify_adb_installs "$V_OLD" 2>/dev/null ;; esac
      case "$C_OLD" in ""|null) fw settings delete global package_verifier_user_consent 2>/dev/null ;; *) fw settings put global package_verifier_user_consent "$C_OLD" 2>/dev/null ;; esac ;;
    always_on)  fw settings put global verifier_verify_adb_installs 1 2>/dev/null; fw settings put global package_verifier_user_consent 1 2>/dev/null ;;
    always_off) fw settings put global verifier_verify_adb_installs 0 2>/dev/null; fw settings put global package_verifier_user_consent -1 2>/dev/null ;;
  esac
  V_SAVED=""
}

# --- Android Developer Verification (2026) ------------------------------
# HONEST: the enforcement is a separate "Android Developer Verifier" service, NOT Play Protect, and
# has no confirmed clean on-device knob. Crucially, a root `pm install` IS the ADB-equivalent path
# that the policy exempts, so this module already sidesteps it for free. devverif stays best-effort:
# it applies a knob only if a real one is ever wired here, and always audits the reality. Never fake
# a toggle that does nothing. (TODO: research/plug a real device_config knob if one surfaces.)
devverif_apply() {
  DVMODE="$(arg_or_cfg .devverif_mode)"; case "$DVMODE" in always_on|always_off|restore) ;; *) DVMODE=restore ;; esac
  audit "devverif mode=$DVMODE (root pm install is ADB-exempt from Developer Verification; no separate knob applied)"
}
devverif_finish() { :; }

# --- install-source deep spoof (initiatingPackageName via packages.xml) -
# pm cannot forge initiatingPackageName (only installerPackageName via -i), so a fully Play-looking
# source needs editing /data/system/packages.xml. ABX-aware via xml_edit; applies after the next
# reboot (PM caches packages.xml). Any failure leaves the live file untouched.
deep_spoof_installer() {   # <pkg> <installer-pkg>
  _p="$1"; _ip="$2"; _f=/data/system/packages.xml
  [ -f "$_f" ] || { audit "deep-spoof no packages.xml $_p"; return 1; }
  _dse() {
    grep -q "<package name=\"$_p\" " "$1" || return 1
    sed "/<package name=\"$_p\" /{s/ installInitiator=\"[^\"]*\"/ installInitiator=\"$_ip\"/; s/ packageSource=\"[^\"]*\"/ packageSource=\"0\"/;}" "$1" > "$2" 2>/dev/null
  }
  _dsv() {
    grep "<package name=\"$_p\" " "$1" | grep -q "installInitiator=\"$_ip\"" \
      && grep "<package name=\"$_p\" " "$1" | grep -q 'packageSource="0"'
  }
  if xml_edit "$_f" _dse '<package name=' _dsv "$STATE/pkgxml_backups"; then
    audit "deep-spoof $_p installInitiator=$_ip packageSource=0 backup=$XMLEDIT_BAK (applies after reboot)"; return 0
  fi
  audit "deep-spoof skipped/failed, live untouched $_p"; return 1
}
verify_install_source() {   # <pkg>; audit-only readback
  _ivs="$(dumpsys package "$1" 2>/dev/null)"
  _inst="$(printf '%s' "$_ivs" | sed -n 's/.*installerPackageName=\([^ ,}]*\).*/\1/p' | head -1)"
  _init="$(printf '%s' "$_ivs" | sed -n 's/.*[iI]nitiatingPackageName=\([^ ,}]*\).*/\1/p' | head -1)"
  audit "install-source $1 installer=${_inst:-none} initiating=${_init:-none}"
}

# --- package detection (fresh installs) ---------------------------------
PKGS_BEFORE="$STAGING/pkgs.before.$OPID"
snap_before() { pm list packages 2>/dev/null | sed 's/^package://' | sort > "$PKGS_BEFORE"; }
detect_pkg() { _a="$STAGING/pkgs.after.$OPID"; pm list packages 2>/dev/null | sed 's/^package://' | sort > "$_a"
  grep -vxF -f "$PKGS_BEFORE" "$_a" 2>/dev/null | head -1; rm -f "$_a"; }

# --- the session install of one app (base + optional splits) ------------
INSTALL_MSG=""
install_apks() {   # <apk...>  installs as ONE package; 0 = Success
  INSTALL_MSG=""
  SESSION="$(fw pm install-create $(pm_install_flags) $(installer_flag) $(user_flag) 2>/dev/null | sed -n 's/.*\[\([0-9]*\)\].*/\1/p')"
  [ -n "$SESSION" ] || { INSTALL_MSG="install-create failed"; return 1; }
  _n=0
  for _apk in "$@"; do
    [ -f "$_apk" ] || continue
    if ! fw pm install-write "$SESSION" "s$_n" "$_apk" >/dev/null 2>&1; then
      INSTALL_MSG="install-write failed: $(basename "$_apk")"; fw pm install-abandon "$SESSION" >/dev/null 2>&1; return 1
    fi
    _n=$((_n+1))
  done
  [ "$_n" -gt 0 ] || { INSTALL_MSG="no apk to write"; fw pm install-abandon "$SESSION" >/dev/null 2>&1; return 1; }
  CMT="$(fw pm install-commit "$SESSION" 2>&1)"
  case "$CMT" in *Success*) return 0 ;; *) INSTALL_MSG="$(printf '%s' "$CMT" | tr '\n' ' ' | sed 's/  */ /g')"; return 1 ;; esac
}
# install one app + post-install source handling + audit. echoes a result object (no braces).
install_one() {   # <apk...>
  snap_before
  if install_apks "$@"; then
    _pkg="$(detect_pkg)"
    if [ -n "$_pkg" ]; then
      if [ "$(arg_or_cfg .deep_spoof)" = true ] && [ "$(arg_or_cfg .spoof_installer)" != false ]; then
        _dip="$(arg_or_cfg .spoof_installer_pkg)"; { [ -z "$_dip" ] || [ "$_dip" = null ]; } && _dip=com.android.vending
        deep_spoof_installer "$_pkg" "$_dip"
      fi
      verify_install_source "$_pkg"
    fi
    printf '{"ok":true,"package":"%s","apks":%s}' "$(jstr "${_pkg:-unknown}")" "$#"
    return 0
  fi
  printf '{"ok":false,"message":"%s"}' "$(jstr "$INSTALL_MSG")"
  return 1
}

# --- archive (xapk/apkm/apks/zip) ---------------------------------------
extract_archive() {   # <archive> <destdir>
  command -v unzip >/dev/null 2>&1 || { INSTALL_MSG="no unzip on device"; return 1; }
  mkdir -p "$2"; unzip -o -q "$1" -d "$2" >/dev/null 2>&1 || { INSTALL_MSG="extract failed"; return 1; }
}
collect_apks() { find "$1" -type f -name '*.apk' 2>/dev/null | sort; }
place_obb() {   # <extractdir> <pkg> ; best-effort xapk OBB placement
  [ -n "$2" ] || return 0
  _src="$(find "$1" -type d -path '*Android/obb' 2>/dev/null | head -1)"
  [ -n "$_src" ] && [ -d "$_src/$2" ] || return 0
  _dst=/sdcard/Android/obb/"$2"; mkdir -p "$_dst" 2>/dev/null
  cp -f "$_src/$2"/*.obb "$_dst"/ 2>/dev/null && audit "obb placed for $2"
}

# --- the five worker verbs ----------------------------------------------
do_single() {
  _p="$(jget "$ARGS" '.path')"; [ -f "$_p" ] || { finish_prog false 100 done '"error":"ERR_PATH","message":"apk not found"'; return; }
  verifier_apply; devverif_apply
  set_prog 30 installing "$(basename "$_p")" false
  _r="$(install_one "$_p")"
  verifier_finish; devverif_finish
  case "$_r" in *'"ok":true'*) finish_prog true 100 done "\"result\":$_r" ;; *) finish_prog false 100 done "\"result\":$_r" ;; esac
}
do_splitset() {   # splitdir OR archive-extracted dir: all apks = ONE app
  _dir="$1"
  _apks="$(collect_apks "$_dir")"; [ -n "$_apks" ] || { finish_prog false 100 done '"error":"ERR_NO_APK","message":"no .apk found"'; return; }
  verifier_apply; devverif_apply
  set_prog 40 installing "split set" false
  # shellcheck disable=SC2086
  set -- $_apks; _r="$(install_one "$@")"
  verifier_finish; devverif_finish
  _pkg="$(printf '%s' "$_r" | sed -n 's/.*"package":"\([^"]*\)".*/\1/p')"
  [ -n "$OBB_DIR" ] && [ -n "$_pkg" ] && place_obb "$OBB_DIR" "$_pkg"
  case "$_r" in *'"ok":true'*) finish_prog true 100 done "\"result\":$_r" ;; *) finish_prog false 100 done "\"result\":$_r" ;; esac
}
do_archive() {
  _ar="$(jget "$ARGS" '.path')"; [ -f "$_ar" ] || { finish_prog false 100 done '"error":"ERR_PATH","message":"archive not found"'; return; }
  _ex="$STAGING/ar.$OPID"; rm -rf "$_ex"
  set_prog 15 extracting "$(basename "$_ar")" false
  extract_archive "$_ar" "$_ex" || { finish_prog false 100 done "\"error\":\"ERR_EXTRACT\",\"message\":\"$(jstr "$INSTALL_MSG")\""; rm -rf "$_ex"; return; }
  OBB_DIR="$_ex"; do_splitset "$_ex"; OBB_DIR=""
  rm -rf "$_ex"
}
do_splitdir() {
  _dir="$(jget "$ARGS" '.dir')"; [ -d "$_dir" ] || { finish_prog false 100 done '"error":"ERR_DIR","message":"folder not found"'; return; }
  OBB_DIR=""; do_splitset "$_dir"
}
do_batch() {   # a folder of INDEPENDENT apks: one install per apk
  _dir="$(jget "$ARGS" '.dir')"; [ -d "$_dir" ] || { finish_prog false 100 done '"error":"ERR_DIR","message":"folder not found"'; return; }
  _list="$STAGING/batch.$OPID"; find "$_dir" -maxdepth 1 -type f -name '*.apk' 2>/dev/null | sort > "$_list"
  _total="$(wc -l < "$_list")"; [ "$_total" -gt 0 ] || { finish_prog false 100 done '"error":"ERR_NO_APK","message":"no .apk in folder"'; rm -f "$_list"; return; }
  verifier_apply; devverif_apply
  _ok=0; _n=0; _results=""
  while IFS= read -r _apk; do
    _n=$((_n+1)); set_prog $(( _n * 100 / (_total + 1) )) installing "$(basename "$_apk")" false
    _r="$(install_one "$_apk")"; case "$_r" in *'"ok":true'*) _ok=$((_ok+1)) ;; esac
    _results="${_results:+$_results,}$_r"
  done < "$_list"
  verifier_finish; devverif_finish; rm -f "$_list"
  finish_prog $([ "$_ok" -eq "$_total" ] && echo true || echo false) 100 done \
    "\"installed\":$_ok,\"total\":$_total,\"results\":[$_results]"
}
do_uninstall() {
  _pkg="$(jget "$ARGS" '.pkg')"; case "$_pkg" in ''|*[!A-Za-z0-9._]*) finish_prog false 100 done '"error":"ERR_PKG","message":"invalid package"'; return ;; esac
  _keep="$(jget "$ARGS" '.keep_data')"; _kf=""; [ "$_keep" = true ] && _kf="-k"
  set_prog 50 uninstalling "$_pkg" false
  _o="$(fw pm uninstall $_kf $(user_flag) "$_pkg" 2>&1)"
  audit "uninstall $_pkg keep_data=${_keep:-false} -> $_o"
  case "$_o" in *Success*) finish_prog true 100 done "\"package\":\"$(jstr "$_pkg")\"" ;; *) finish_prog false 100 done "\"error\":\"ERR_UNINSTALL\",\"message\":\"$(jstr "$_o")\"" ;; esac
}

rm -f "$PKGS_BEFORE" 2>/dev/null
OBB_DIR=""
case "$VERB" in
  install-single)   do_single ;;
  install-batch)    do_batch ;;
  install-archive)  do_archive ;;
  install-splitdir) do_splitdir ;;
  uninstall)        do_uninstall ;;
  *) finish_prog false 100 done '"error":"ERR_VERB","message":"unknown worker verb"' ;;
esac
rm -f "$PKGS_BEFORE" 2>/dev/null
exit 0
