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

# WebUI contract: `helper.sh <verb> <base64(JSON args)>` -> exactly one JSON line on stdout.
# Short verbs run inline; long ones (install/uninstall) detach a worker and return an opid the
# UI polls with `progress`. POSIX sh, no bashisms.

MODDIR=${0%/*}; MODDIR=${MODDIR%/scripts}
. "$MODDIR/scripts/common.sh"

VERB="$1"; ARGS_B64="$2"
ARGS="$(printf '%s' "$ARGS_B64" | base64 -d 2>/dev/null)"; [ -n "$ARGS" ] || ARGS='{}'

# --- detach a long operation (survives WebUI close) ---------------------
detach() {               # <opid> <worker-verb> <b64args>
  _o="$1"; _w="$2"; _a="$3"
  case "$_o" in ''|*[!A-Za-z0-9._-]*) return 1 ;; esac
  printf '{"opid":"%s","percent":0,"phase":"starting","done":false}\n' "$_o" > "$LOGS/progress-$_o.json"
  setsid nohup "$MODDIR/scripts/worker.sh" "$_w" "$_o" "$_a" >"$LOGS/$_o.out" 2>&1 </dev/null &
  echo "$!" > "$LOGS/$_o.pid"
}
log_prune() { find "$LOGS" -maxdepth 1 -type f \( -name 'progress-*.json' -o -name '*.out' -o -name '*.pid' \) -mtime +2 -delete 2>/dev/null; }

case "$VERB" in
  version)
    ok "\"version\":\"$(jstr "$(sed -n 's/^version=//p' "$MODDIR/module.prop")")\",\"versionCode\":\"$(jstr "$(sed -n 's/^versionCode=//p' "$MODDIR/module.prop")")\"" ;;

  config-get)
    [ -s "$CONFIG" ] && cat "$CONFIG" || ok '"config":null' ;;
  config-set)
    _tmp="$STAGING/cfg.$$.json"
    if "$JQ" --argjson a "$ARGS" '. + $a' "$CONFIG" > "$_tmp" 2>/dev/null && [ -s "$_tmp" ]; then
      mv -f "$_tmp" "$CONFIG"; chmod 600 "$CONFIG" 2>/dev/null; ok '"saved":true'
    else rm -f "$_tmp"; err ERR_CONFIG "invalid configuration"; fi ;;

  scan)
    _dir="$(jget "$ARGS" '.dir')"; [ -d "$_dir" ] || { err ERR_DIR "folder not found"; exit 0; }
    _items=""
    for _f in "$_dir"/*; do
      [ -f "$_f" ] || continue
      case "$_f" in
        *.apk|*.APK) _t=apk ;;
        *.xapk|*.XAPK|*.apkm|*.APKM|*.apks|*.APKS|*.zip|*.ZIP) _t=archive ;;
        *) continue ;;
      esac
      _sz="$(stat -c %s "$_f" 2>/dev/null)"
      _items="${_items:+$_items,}$(printf '{"name":"%s","type":"%s","size":%s}' "$(jstr "$(basename "$_f")")" "$_t" "${_sz:-0}")"
    done
    ok "\"dir\":\"$(jstr "$_dir")\",\"items\":[$_items]" ;;

  browse)
    _dir="$(jget "$ARGS" '.dir')"; case "$_dir" in ''|null) _dir=/sdcard ;; esac
    [ -d "$_dir" ] || _dir=/sdcard; [ -d "$_dir" ] || _dir=/
    _dir="$(cd "$_dir" 2>/dev/null && pwd)"; [ -n "$_dir" ] || _dir=/
    case "$_dir" in /) _parent=/ ;; *) _parent="$(dirname "$_dir")" ;; esac
    _ents=""
    for _e in "$_dir"/*; do
      [ -e "$_e" ] || continue
      _bn="$(basename "$_e")"
      if [ -d "$_e" ]; then _et=dir; _es=0
      else
        case "$_e" in
          *.apk|*.APK) _et=apk ;;
          *.xapk|*.XAPK|*.apkm|*.APKM|*.apks|*.APKS|*.zip|*.ZIP) _et=archive ;;
          *) continue ;;
        esac
        _es="$(stat -c %s "$_e" 2>/dev/null)"
      fi
      _ents="${_ents:+$_ents,}$(printf '{"name":"%s","type":"%s","size":%s}' "$(jstr "$_bn")" "$_et" "${_es:-0}")"
    done
    ok "\"dir\":\"$(jstr "$_dir")\",\"parent\":\"$(jstr "$_parent")\",\"entries\":[$_ents]" ;;

  install)
    case "$(jget "$ARGS" '.mode')" in
      single)   _w=install-single ;;
      batch)    _w=install-batch ;;
      archive)  _w=install-archive ;;
      splitdir) _w=install-splitdir ;;
      *) err ERR_MODE "unknown install mode"; exit 0 ;;
    esac
    _o="$(new_opid)"; detach "$_o" "$_w" "$ARGS_B64" && ok "\"opid\":\"$_o\"" || err ERR_DETACH "failed to start installer" ;;

  uninstall)
    _o="$(new_opid)"; detach "$_o" uninstall "$ARGS_B64" && ok "\"opid\":\"$_o\"" || err ERR_DETACH "failed to start" ;;
  restore-source)
    _o="$(new_opid)"; detach "$_o" restore-source "$ARGS_B64" && ok "\"opid\":\"$_o\"" || err ERR_DETACH "failed to start" ;;
  history)
    _hn="$(jget "$ARGS" '.n')"; case "$_hn" in ''|*[!0-9]*) _hn=50 ;; esac
    _he="$(tail -n "$_hn" "$LOGS/audit.jsonl" 2>/dev/null | tr '\n' ',' | sed 's/,*$//')"
    ok "\"entries\":[$_he]" ;;

  progress)
    _o="$(printf '%s' "$ARGS_B64" | base64 -d 2>/dev/null)"
    case "$_o" in ''|*[!A-Za-z0-9._-]*) err ERR_BAD_OPID "invalid opid"; exit 0 ;; esac
    _f="$LOGS/progress-$_o.json"; [ -s "$_f" ] && cat "$_f" || ok "\"opid\":\"$(jstr "$_o")\",\"percent\":0,\"phase\":\"starting\"" ;;
  cancel)
    _o="$(printf '%s' "$ARGS_B64" | base64 -d 2>/dev/null)"
    case "$_o" in ''|*[!A-Za-z0-9._-]*) err ERR_BAD_OPID "invalid opid"; exit 0 ;; esac
    _p="$(cat "$LOGS/$_o.pid" 2>/dev/null)"; case "$_p" in ''|*[!0-9]*) ;; *) kill -TERM -"$_p" 2>/dev/null; kill -TERM "$_p" 2>/dev/null ;; esac
    ok "\"cancelled\":\"$(jstr "$_o")\"" ;;

  verifier-status)
    ok "\"verifier_verify_adb_installs\":\"$(jstr "$(fw settings get global verifier_verify_adb_installs 2>/dev/null)")\",\"package_verifier_user_consent\":\"$(jstr "$(fw settings get global package_verifier_user_consent 2>/dev/null)")\",\"package_verifier_enable\":\"$(jstr "$(fw settings get global package_verifier_enable 2>/dev/null)")\"" ;;

  list-users)
    _u="$(pm list users 2>/dev/null | sed -n 's/.*UserInfo{\([0-9][0-9]*\):\([^:]*\):.*/{"id":\1,"name":"\2"}/p' | tr '\n' ',' | sed 's/,$//')"
    ok "\"users\":[$_u]" ;;

  hma-hint)
    ok '"recommend":true' ;;

  sanitize)
    log_prune; ok '"ok":true' ;;

  *)
    err ERR_VERB "unknown verb: $(jstr "$VERB")" ;;
esac
