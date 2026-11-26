#!/usr/bin/env python3
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
#
#  WebUI screenshot harness. Renders the real module/webroot WebUI in a
#  headless Chrome under a mocked `ksu.exec` bridge that answers every
#  helper.sh verb with fictional, privacy-safe fixtures (NEVER real device
#  data), then captures the documented screens in each of the 22 languages
#  (dark theme, 412x915 @ 3x, with a COPG-style device frame). Output:
#  docs/screenshots/<lang>/.
#
#  Why this lives in the repo:
#   - every label, the mode names, the toggles and the RTL mirroring come
#     from the live webroot + lang/*.json, so a UI or string change is
#     reflected on the next run with no edit here;
#   - the shown version is read from module/module.prop, so a release bump
#     needs no change here either;
#   - fixtures are declared once in FIXTURES below; add a verb there when the
#     UI starts calling a new one.
#
#  Usage:
#     python3 tools/screenshots/shoot.py            # all 22 languages
#     python3 tools/screenshots/shoot.py pt en ar   # only the given codes
#  Requires: python3-playwright + a system Google Chrome/Chromium.
# ======================================================================

import json
import os
import socketserver
import sys
import threading
from http.server import SimpleHTTPRequestHandler

from playwright.sync_api import sync_playwright

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
WEBROOT = os.path.join(ROOT, "module", "webroot")
OUTDIR = os.path.join(ROOT, "docs", "screenshots")
LANGS = ["ar", "cs", "de", "en", "es", "fa", "fr", "hi", "id", "it", "ja",
         "ko", "nl", "pl", "pt", "ru", "sv", "th", "tr", "uk", "vi", "zh"]
# (tab to switch to, output basename)
SCREENS = [
    ("install", "install"),
    ("options", "options"),
    ("updates", "updates"),
    ("about", "about"),
]
VIEWPORT = {"width": 412, "height": 915}
SCALE = 3


def module_version():
    name, code = "v1.0", "0"
    try:
        with open(os.path.join(ROOT, "module", "module.prop"), encoding="utf-8") as f:
            for line in f:
                if line.startswith("version="):
                    name = line.split("=", 1)[1].strip()
                elif line.startswith("versionCode="):
                    code = line.split("=", 1)[1].strip()
    except OSError:
        pass
    return name, code


def ts(day, hh, mm):
    return "2026-11-%02dT%02d:%02d:00Z" % (day, hh, mm)


def build_fixtures(version, code):
    # Fictional, privacy-safe installer state. Sample paths and well-known
    # FOSS package names only; NEVER derived from a real device.
    config = {
        "spoof_installer": True,
        "spoof_installer_pkg": "com.android.vending",
        "deep_spoof": True,
        "grant_all_perms": False,
        "allow_test": True,
        "bypass_low_target_sdk": True,
        "target_user": 0,
        "verifier_mode": "restore",
        "devverif_mode": "restore",
    }
    return {
        "config": config,
        "version": {"ok": True, "version": version, "versionCode": code},
        "install": {"ok": True, "opid": "op-demo"},
        "restore-source": {"ok": True, "opid": "op-restore"},
        "progress": {"done": True, "percent": 100, "phase": "done",
                     "result": {"ok": True, "package": "org.mozilla.firefox"}},
        "cancel": {"ok": True},
        "config-set": {"ok": True},
        "browse": {"ok": True, "dir": "/sdcard/Download", "parent": "/sdcard",
                   "entries": [
                       {"name": "apks", "type": "dir"},
                       {"name": "Firefox-141.0.apk", "type": "file"},
                       {"name": "NewPipe-0.27.5.apk", "type": "file"},
                       {"name": "Organic-Maps.xapk", "type": "file"},
                   ]},
        "history": {"ok": True, "entries": [
            {"ts": ts(24, 9, 12), "msg": "installed org.mozilla.firefox (141.0) - source spoofed to com.android.vending"},
            {"ts": ts(24, 9, 10), "msg": "verifier: restored to as-found after install"},
            {"ts": ts(23, 21, 40), "msg": "batch: installed 6 of 6 APKs from /sdcard/Download/apks"},
            {"ts": ts(23, 18, 5), "msg": "installed app.organicmaps (split archive, 4 splits) - 1 session"},
            {"ts": ts(22, 14, 30), "msg": "restored original install-source for org.fdroid.fdroid"},
        ]},
    }


MOCK_JS = r"""
(function () {
  window.__VDI_FIX = %s;
  window.__VDI_LANG = "%s";
  window.ksu = {
    exec: function (cmd, opts, cbName) {
      var s = "";
      var m = /helper\.sh\s+([a-z-]+)/.exec(String(cmd));
      if (m) {
        var verb = m[1], fix = window.__VDI_FIX, out;
        if (verb === "config-get") {
          out = {}; var src = fix["config"] || {};
          for (var k in src) out[k] = src[k];
          out.language = window.__VDI_LANG;
        } else if (Object.prototype.hasOwnProperty.call(fix, verb)) {
          out = fix[verb];
        } else {
          out = { ok: true };
        }
        s = JSON.stringify(out);
      }
      // non-helper commands (VDLU: cat journal.json / config) -> empty stdout,
      // which keeps the Updates panel idle (no network check, no stuck banner).
      setTimeout(function () {
        try { if (typeof window[cbName] === "function") window[cbName](0, s, ""); } catch (e) {}
      }, 0);
    }
  };
})();
"""


CHROME_JS = r"""
(function () {
  if (document.getElementById("__vdi_chrome")) return;
  var NS = "http://www.w3.org/2000/svg";
  var st = document.createElement("style");
  st.id = "__vdi_chrome";
  st.textContent =
    "html,body{background:#15171a;}" +
    "body{padding-top:30px;padding-bottom:42px;}" +
    "#__vdi_sb{position:fixed;top:0;left:0;right:0;height:30px;z-index:9999;" +
    "background:#0b0d10;color:#eef0f3;display:flex;align-items:center;" +
    "justify-content:space-between;padding:0 16px;" +
    "font:600 13px -apple-system,system-ui,'Segoe UI',Roboto,sans-serif;}" +
    "#__vdi_sb .r{display:flex;align-items:center;gap:8px;}" +
    "#__vdi_nav{position:fixed;bottom:0;left:0;right:0;height:42px;z-index:9999;" +
    "background:#0b0d10;display:flex;align-items:center;justify-content:center;gap:72px;}" +
    "#__vdi_nav svg{opacity:.85;}" +
    "header{top:30px !important;}nav{top:94px !important;}";
  document.head.appendChild(st);

  function svg(w, h, body) {
    return '<svg xmlns="' + NS + '" width="' + w + '" height="' + h +
      '" viewBox="0 0 ' + w + ' ' + h + '" fill="#eef0f3">' + body + '</svg>';
  }
  var signal = svg(18, 12,
    '<rect x="0" y="8" width="3" height="4" rx="1"/>' +
    '<rect x="5" y="5" width="3" height="7" rx="1"/>' +
    '<rect x="10" y="2" width="3" height="10" rx="1"/>' +
    '<rect x="15" y="0" width="3" height="12" rx="1" fill="#eef0f3" opacity="0.4"/>');
  var wifi = svg(16, 12,
    '<path d="M8 11.2a1.3 1.3 0 100-2.6 1.3 1.3 0 000 2.6z"/>' +
    '<path d="M3.4 5.6A6.8 6.8 0 018 4a6.8 6.8 0 014.6 1.6l-1.3 1.4A4.9 4.9 0 008 5.9a4.9 4.9 0 00-3.3 1.1z"/>' +
    '<path d="M1 3A10 10 0 018 0a10 10 0 017 3L13.6 4.4A8 8 0 008 2.1 8 8 0 002.4 4.4z"/>');
  var batt = svg(24, 12,
    '<rect x="0.5" y="0.5" width="20" height="11" rx="2.5" fill="none" stroke="#eef0f3" stroke-opacity="0.6"/>' +
    '<rect x="2.5" y="2.5" width="14" height="7" rx="1"/>' +
    '<rect x="21.5" y="4" width="2" height="4" rx="1"/>');

  var sb = document.createElement("div");
  sb.id = "__vdi_sb";
  sb.innerHTML = '<div class="l">20:26</div><div class="r">' + signal + wifi + batt + "</div>";
  document.body.appendChild(sb);

  var back = svg(18, 18, '<path d="M12 3L5 9l7 6z"/>');
  var home = svg(16, 16, '<circle cx="8" cy="8" r="7" fill="none" stroke="#eef0f3" stroke-width="1.6"/>');
  var recents = svg(14, 14, '<rect x="1" y="1" width="12" height="12" rx="2" fill="none" stroke="#eef0f3" stroke-width="1.6"/>');
  var nv = document.createElement("div");
  nv.id = "__vdi_nav";
  nv.innerHTML = back + home + recents;
  document.body.appendChild(nv);
})
"""


def serve(directory):
    handler = lambda *a, **k: SimpleHTTPRequestHandler(*a, directory=directory, **k)
    httpd = socketserver.ThreadingTCPServer(("127.0.0.1", 0), handler)
    httpd.daemon_threads = True
    threading.Thread(target=httpd.serve_forever, daemon=True).start()
    return httpd, httpd.server_address[1]


def main(argv):
    langs = [a for a in argv[1:] if a in LANGS] or LANGS
    version, code = module_version()
    fixtures = build_fixtures(version, code)
    fix_json = json.dumps(fixtures, ensure_ascii=False)
    httpd, port = serve(WEBROOT)
    base = "http://127.0.0.1:%d/index.html" % port
    total = 0
    with sync_playwright() as pw:
        browser = pw.chromium.launch(channel="chrome", headless=True,
                                     args=["--force-color-profile=srgb"])
        try:
            for lang in langs:
                ctx = browser.new_context(viewport=VIEWPORT, device_scale_factor=SCALE,
                                          locale=lang, color_scheme="dark")
                page = ctx.new_page()
                page.add_init_script(MOCK_JS % (fix_json, lang))
                page.goto(base, wait_until="networkidle")
                page.wait_for_timeout(600)   # let boot() + i18n fetch settle
                page.evaluate(CHROME_JS)
                outlang = os.path.join(OUTDIR, lang)
                os.makedirs(outlang, exist_ok=True)
                for tab, name in SCREENS:
                    page.evaluate(
                        "(t) => { var b = document.querySelector('nav button[data-tab=\"' + t + '\"]');"
                        " if (b) b.click(); }", tab)
                    page.wait_for_timeout(450)
                    page.evaluate("() => { window.scrollTo(0, 0); }")
                    page.wait_for_timeout(120)
                    out = os.path.join(outlang, "%s-dark.png" % name)
                    page.screenshot(path=out)
                    total += 1
                ctx.close()
                print("  %s: %d screens" % (lang, len(SCREENS)))
        finally:
            browser.close()
    httpd.shutdown()
    print("done: %d PNGs (%d langs) at version %s (%s) -> %s" %
          (total, len(langs), version, code, OUTDIR))


if __name__ == "__main__":
    main(sys.argv)
