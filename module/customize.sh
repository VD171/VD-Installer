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

SKIPUNZIP=0
STATE_DIR=/data/adb/vdinstaller

ui_print ""
ui_print "  VD INSTALLER: frictionless root sideload installer"
ui_print "  https://github.com/VD171/VD-Installer"
ui_print ""

# --- environment guards -------------------------------------------------
if [ "$BOOTMODE" != "true" ]; then
  ui_print "! Install from KernelSU / APatch / Magisk manager (not recovery)."
  abort   "! Aborting."
fi

API="$(getprop ro.build.version.sdk)"
if [ "$API" -lt 26 ]; then
  ui_print "! Android 8.0 (API 26) or newer is required (found API $API)."
  abort   "! Aborting."
fi

case "$ARCH" in
  arm64) ABIDIR=arm64-v8a ;;
  arm)   ABIDIR=armeabi-v7a ;;
  x86)   ABIDIR=x86 ;;
  x64)   ABIDIR=x86_64 ;;
  *) ui_print "! Unsupported architecture: $ARCH" ; abort "! Aborting." ;;
esac
ui_print "- Architecture: $ARCH ($ABIDIR)"

# --- keep only this device's ABI (bundled jq + ABX converters) ----------
if [ -d "$MODPATH/bin" ]; then
  for d in "$MODPATH"/bin/*/; do
    [ -d "$d" ] || continue
    [ "$(basename "$d")" = "$ABIDIR" ] || rm -rf "$d"
  done
  ui_print "- Keeping binaries for $ABIDIR only"
fi

# --- VDLU verifier: keep only this device's ed25519-mini ABI ------------
if [ -d "$MODPATH/vdlu/verify" ]; then
  for d in "$MODPATH"/vdlu/verify/*/; do
    [ -d "$d" ] || continue
    [ "$(basename "$d")" = "$ABIDIR" ] || rm -rf "$d"
  done
fi

# --- integrity: flash-time .sha256 gate (STANDARDS 8; ABORT on mismatch) ---
# Vendored byte-identical from VD-ModuleKit/tooling/sha256-gate.sh (guarded by vendor-parity.sh).
# Runs after the per-ABI pruning, so it checks the files that stay, and aborts the flash if any
# shipped file does not match its .sha256 companion. Skips safely without `sha256sum -c`.
. "$MODPATH/.vd/sha256-gate.sh"

# --- seed persistent state (only if absent) -----------------------------
STATE_SUBDIRS="logs staging"
if [ ! -f "$STATE_DIR/config.json" ]; then
  ui_print "- Seeding default configuration"
  mkdir -p "$STATE_DIR"
  for _d in $STATE_SUBDIRS; do mkdir -p "$STATE_DIR/$_d"; done
  cat > "$STATE_DIR/config.json" <<'EOF'
{
  "format_version": 1,
  "spoof_installer": true,
  "spoof_installer_pkg": "com.android.vending",
  "deep_spoof": true,
  "verifier_mode": "restore",
  "devverif_mode": "restore",
  "grant_all_perms": false,
  "allow_downgrade": true,
  "allow_test": true,
  "bypass_low_target_sdk": true,
  "target_user": 0,
  "language": "auto"
}
EOF
  chmod 600 "$STATE_DIR/config.json"
else
  ui_print "- Keeping existing configuration"
  for _d in $STATE_SUBDIRS; do mkdir -p "$STATE_DIR/$_d"; done
fi
chmod 700 "$STATE_DIR"
for _d in $STATE_SUBDIRS; do chmod 700 "$STATE_DIR/$_d" 2>/dev/null; done

# --- seed the VDLU flashless-updater config (only if absent) ------------
if [ ! -f "$STATE_DIR/vdlu/config" ] && [ -f "$MODPATH/vdlu/config.default" ]; then
  ui_print "- Seeding update engine (VDLU) configuration"
  mkdir -p "$STATE_DIR/vdlu"
  cp -f "$MODPATH/vdlu/config.default" "$STATE_DIR/vdlu/config"
  chmod 600 "$STATE_DIR/vdlu/config"
fi

# --- permissions --------------------------------------------------------
ui_print "- Setting permissions"
set_perm_recursive "$MODPATH" 0 0 0755 0644
[ -d "$MODPATH/bin" ] && set_perm_recursive "$MODPATH/bin" 0 0 0755 0755
set_perm "$MODPATH/scripts/helper.sh" 0 0 0755
set_perm "$MODPATH/scripts/worker.sh" 0 0 0755
set_perm "$MODPATH/service.sh" 0 0 0755
[ -f "$MODPATH/uninstall.sh" ] && set_perm "$MODPATH/uninstall.sh" 0 0 0755
[ -f "$MODPATH/vdlu/update.sh" ] && set_perm "$MODPATH/vdlu/update.sh" 0 0 0755
[ -f "$MODPATH/vdlu/vdlu-verify" ] && set_perm "$MODPATH/vdlu/vdlu-verify" 0 0 0755
[ -d "$MODPATH/vdlu/verify" ] && set_perm_recursive "$MODPATH/vdlu/verify" 0 0 0755 0755

# --- ready without a reboot --------------------------------------------
# Self-contained (WebUI + helper + bundled binaries under the module dir): no magic mount,
# Zygisk or sepolicy. Managers stage modules under modules_update/ and only activate on reboot;
# since we have nothing to mount, copy ourselves into the active modules/ dir so the WebUI works NOW.
MID="${MODID:-vdinstaller}"
ACTIVE="/data/adb/modules/$MID"
if [ "$BOOTMODE" = "true" ] && [ "$MODPATH" != "$ACTIVE" ]; then
  ui_print "- Activating without reboot"
  mkdir -p "$ACTIVE"
  cp -afT "$MODPATH" "$ACTIVE" 2>/dev/null || cp -af "$MODPATH"/. "$ACTIVE"/ 2>/dev/null
  chmod 0755 "$ACTIVE"/*.sh "$ACTIVE"/scripts/*.sh "$ACTIVE"/bin/*/* 2>/dev/null
  chmod 0755 "$ACTIVE"/vdlu/update.sh "$ACTIVE"/vdlu/vdlu-verify "$ACTIVE"/vdlu/verify/*/* 2>/dev/null
  setsid sh -c "sleep 4; rm -f '$ACTIVE/update' '$ACTIVE/remove' '$ACTIVE/disable'" >/dev/null 2>&1 &
fi

ui_print ""
ui_print "- Ready to use NOW, no reboot needed."
ui_print "  Open the VDInstaller WebUI from your root manager to install APKs."
ui_print ""
