/*
 * ======================================================================
 *  VD INSTALLER  ::  frictionless root sideload installer
 *  Install sideload APKs as root (single/batch/split), no friction: KernelSU/APatch/Magisk WebUI.
 *
 *  Copyright (C) 2026  VD171
 *  SPDX-License-Identifier: AGPL-3.0-or-later
 *
 *  Free software under the GNU AGPL v3 or later. NETWORK COPYLEFT: run a
 *  modified version, even as a service, and you MUST offer its source.
 *
 *  Site           : https://vd171.ru
 *  Site           : https://vd.priv8.ru
 *  Source         : https://github.com/VD171/VD-Installer
 *  GitHub         : @VD171 https://github.com/VD171
 *  XDA-Developers : @VD171 https://xdaforums.com/m/vd171.4699873/
 *  XDA thread     : https://xdaforums.com/t/VD-Installer.4809504/
 *  Telegram       : @VD_Priv8 https://t.me/VD_Priv8
 *  Channel        : @Priv8_VD https://t.me/Priv8_VD
 *  Discord        : @VD.Priv8 https://discord.com/users/1296831918989639721
 *  E-mail         : vd.priv8@pm.me
 * ======================================================================
 */
(function () {
  "use strict";
  var MOD = "/data/adb/modules/vdinstaller";
  var HELPER = "sh " + MOD + "/scripts/helper.sh";
  var T = window.I18N.t;

  function shq(s) { return "'" + String(s).replace(/'/g, "'\\''") + "'"; }
  function b64(s) { return btoa(unescape(encodeURIComponent(String(s)))); }
  function $(id) { return document.getElementById(id); }

  function execCommand(cmd) {
    return new Promise(function (resolve, reject) {
      try {
        var cb = "__vdi_cb_" + Math.random().toString(36).slice(2);
        window[cb] = function (errno, stdout, stderr) {
          delete window[cb];
          resolve({ errno: errno, stdout: stdout || "", stderr: stderr || "" });
        };
        if (window.ksu && typeof ksu.exec === "function") ksu.exec(cmd, "{}", cb);
        else reject(new Error("ksu.exec unavailable"));
      } catch (e) { reject(e); }
    });
  }
  function parse(r) { try { return JSON.parse(String(r.stdout).trim()); } catch (e) { return { ok: false, code: "ERR_PARSE", message: (r.stderr || r.stdout || "no response") }; } }
  function api(verb, args) { return execCommand(HELPER + " " + verb + " " + b64(JSON.stringify(args || {}))).then(parse); }
  function apiRaw(verb, raw) { return execCommand(HELPER + " " + verb + " " + b64(String(raw))).then(parse); }

  // --- VDLU updater bridge ----------------------------------------------
  var VDLU_STATE_DIR = "/data/adb/vdinstaller/vdlu";
  var _vdluReady = false, _vdluPanelMounted = false;
  function currentUiLang() { return document.documentElement.getAttribute("lang") || "en"; }
  function vdluExec(cmd) {
    return execCommand(cmd).then(function (r) {
      if (r.errno === 0) return r.stdout;
      throw new Error(r.stderr || r.stdout || ("rc=" + r.errno));
    });
  }
  function loadVdluI18n(lang) {
    return new Promise(function (resolve) {
      if (!lang || lang === "en") return resolve(null);
      var file = (lang === "pt") ? "pt-BR" : lang;
      var g = "VDLU_I18N_" + file.toUpperCase().replace(/-/g, "_");
      if (typeof window[g] !== "undefined") return resolve(window[g]);
      var s = document.createElement("script");
      s.src = "vdlu-i18n/" + file + ".js";
      s.onload = function () { resolve((typeof window[g] !== "undefined") ? window[g] : null); };
      s.onerror = function () { resolve(null); };
      document.head.appendChild(s);
    });
  }
  function initVdlu() {
    if (_vdluReady || !window.VDLU) return;
    _vdluReady = true;
    loadVdluI18n(currentUiLang()).then(function (dict) {
      var opts = { exec: vdluExec, moduleDir: MOD, vdluDir: VDLU_STATE_DIR, modid: "vdinstaller", module: "VDInstaller" };
      if (dict) opts.i18n = dict;
      VDLU.init(opts);
      VDLU.onWebUIOpen().catch(function () {});
    });
  }
  function openUpdatesPanel() {
    if (!window.VDLU) return;
    initVdlu();
    if (!_vdluPanelMounted) { _vdluPanelMounted = true; VDLU.mountUpdatesPanel("vdlu-updates"); }
  }

  // --- tabs -------------------------------------------------------------
  document.querySelectorAll("nav button").forEach(function (b) {
    b.addEventListener("click", function () {
      document.querySelectorAll("nav button").forEach(function (x) { x.classList.remove("active"); });
      document.querySelectorAll(".tab").forEach(function (x) { x.classList.remove("active"); });
      b.classList.add("active");
      var tab = b.getAttribute("data-tab");
      $("tab-" + tab).classList.add("active");
      if (tab === "updates") openUpdatesPanel();
      if (tab === "about") loadActivity();
    });
  });

  // --- mode selection ---------------------------------------------------
  var mode = "single";
  function isFolderMode(m) { return m === "batch" || m === "splitdir"; }
  function selectMode(m) {
    mode = m;
    document.querySelectorAll(".mode").forEach(function (e) { e.classList.toggle("sel", e.getAttribute("data-mode") === m); });
    $("path-label").textContent = T(isFolderMode(m) ? "lbl_path_folder" : "lbl_path_file");
    $("path").setAttribute("placeholder", T(isFolderMode(m) ? "ph_path_folder" : "ph_path_file"));
  }
  document.querySelectorAll(".mode").forEach(function (e) {
    e.addEventListener("click", function () { selectMode(e.getAttribute("data-mode")); });
  });

  // --- scan -------------------------------------------------------------
  function dirOf(p) { p = String(p || "").replace(/\/+$/, ""); var i = p.lastIndexOf("/"); return i > 0 ? p.slice(0, i) : "/"; }
  var browseDir = "/sdcard", browseParent = "/";
  function openBrowse() {
    $("browse-usefolder").classList.toggle("hidden", !isFolderMode(mode));
    $("browse-title").textContent = T(isFolderMode(mode) ? "browse_title_folder" : "browse_title_file");
    var p = $("path").value.trim();
    loadBrowse(p ? (isFolderMode(mode) ? p : dirOf(p)) : "/sdcard");
    $("browse-modal").classList.remove("hidden");
  }
  function closeBrowse() { $("browse-modal").classList.add("hidden"); }
  function loadBrowse(dir) {
    api("browse", { dir: dir }).then(function (r) {
      if (!r.ok) { if (dir !== "/sdcard") loadBrowse("/sdcard"); return; }
      browseDir = r.dir; browseParent = r.parent || "/";
      $("browse-path").textContent = r.dir;
      var list = $("browse-list"); list.innerHTML = "";
      var ents = (r.entries || []).slice().sort(function (a, b) {
        if ((a.type === "dir") !== (b.type === "dir")) return a.type === "dir" ? -1 : 1;
        return a.name < b.name ? -1 : (a.name > b.name ? 1 : 0);
      });
      if (!ents.length) {
        var em = document.createElement("div"); em.className = "browse-row muted"; em.textContent = T("browse_empty"); list.appendChild(em);
      }
      ents.forEach(function (e) {
        var row = document.createElement("div"); row.className = "browse-row";
        row.textContent = (e.type === "dir" ? "📁 " : "📄 ") + e.name;
        row.addEventListener("click", function () {
          if (e.type === "dir") loadBrowse(browseDir.replace(/\/+$/, "") + "/" + e.name);
          else if (!isFolderMode(mode)) { $("path").value = browseDir.replace(/\/+$/, "") + "/" + e.name; closeBrowse(); }
        });
        list.appendChild(row);
      });
      $("browse-up").disabled = (r.dir === "/");
    });
  }
  $("browse-btn").addEventListener("click", openBrowse);
  $("browse-close").addEventListener("click", closeBrowse);
  $("browse-modal").addEventListener("click", function (e) { if (e.target === $("browse-modal")) closeBrowse(); });
  $("browse-up").addEventListener("click", function () { loadBrowse(browseParent); });
  $("browse-usefolder").addEventListener("click", function () { $("path").value = browseDir; closeBrowse(); });

  // --- install + progress ----------------------------------------------
  var timer = null, curOpid = null;
  function setBusy(on) { $("install-btn").disabled = on; $("progress-card").classList.toggle("hidden", !on && !curOpid); }
  function logLine(s) { var l = $("log"); l.textContent += (l.textContent ? "\n" : "") + s; l.scrollTop = l.scrollHeight; }
  function phaseText(p) { var k = "phase_" + (p || "starting"); var s = T(k); return s === k ? (p || "") : s; }

  function finishInstall(p) {
    clearTimeout(timer); timer = null; curOpid = null;
    $("bar").style.width = "100%";
    $("phase-text").textContent = T("phase_done");
    $("install-btn").disabled = false;
    if (p.results !== undefined) { logLine(T("msg_batch_done", { ok: p.installed, total: p.total })); }
    else if (p.result) {
      if (p.result.ok) logLine(T("msg_installed_ok", { pkg: p.result.package || "" }));
      else { logLine(T("msg_installed_fail", { msg: p.result.message || "" })); if (p.result.hint) logLine("💡 " + T("hint_" + p.result.hint)); }
    } else if (p.error) { logLine(T("msg_installed_fail", { msg: p.message || p.error })); }
  }
  function poll(opid) {
    apiRaw("progress", opid).then(function (p) {
      $("bar").style.width = (p.percent || 0) + "%";
      $("phase-text").textContent = phaseText(p.phase);
      if (p.item) logLine(phaseText(p.phase) + ": " + p.item);
      if (p.done) finishInstall(p);
      else timer = setTimeout(function () { poll(opid); }, 800);
    });
  }
  $("install-btn").addEventListener("click", function () {
    var p = $("path").value.trim(); if (!p) { $("scan-out").textContent = T("msg_need_path"); return; }
    var args = { mode: mode }; if (isFolderMode(mode)) args.dir = p; else args.path = p;
    $("log").textContent = ""; $("bar").style.width = "0"; $("progress-card").classList.remove("hidden");
    $("install-btn").disabled = true; $("phase-text").textContent = T("phase_starting");
    api("install", args).then(function (r) {
      if (!r.ok || !r.opid) { $("install-btn").disabled = false; logLine(r.message || T("err_generic")); return; }
      curOpid = r.opid; poll(r.opid);
    });
  });
  $("cancel-btn").addEventListener("click", function () {
    if (curOpid) apiRaw("cancel", curOpid).then(function () { logLine(T("msg_cancelled")); });
  });

  // --- options (persisted in config.json) -------------------------------
  function loadOptions() {
    api("config-get", {}).then(function (c) {
      if (!c || c.config === null) return;
      $("o-spoof").checked = c.spoof_installer !== false;
      $("o-spoofpkg").value = c.spoof_installer_pkg || "com.android.vending";
      $("o-deepspoof").checked = c.deep_spoof !== false;
      $("o-grant").checked = !!c.grant_all_perms;
      $("o-test").checked = c.allow_test !== false;
      $("o-lowsdk").checked = c.bypass_low_target_sdk !== false;
      $("o-user").value = (c.target_user != null ? c.target_user : 0);
      setRadio("verifier", c.verifier_mode || "restore");
      setRadio("devverif", c.devverif_mode || "restore");
      updateVerifierWarn();
    });
  }
  function setRadio(name, val) {
    document.querySelectorAll('input[name="' + name + '"]').forEach(function (r) { r.checked = (r.value === val); });
  }
  function getRadio(name) {
    var r = document.querySelector('input[name="' + name + '"]:checked'); return r ? r.value : "restore";
  }
  function updateVerifierWarn() { $("verifier-warn").classList.toggle("hidden", getRadio("verifier") !== "always_off"); }
  var saveTimer = null;
  function saveOptions() {
    clearTimeout(saveTimer);
    saveTimer = setTimeout(function () {
      var u = parseInt($("o-user").value, 10); if (isNaN(u) || u < 0) u = 0;
      api("config-set", {
        spoof_installer: $("o-spoof").checked,
        spoof_installer_pkg: ($("o-spoofpkg").value.trim() || "com.android.vending"),
        deep_spoof: $("o-deepspoof").checked,
        grant_all_perms: $("o-grant").checked,
        allow_test: $("o-test").checked,
        bypass_low_target_sdk: $("o-lowsdk").checked,
        target_user: u,
        verifier_mode: getRadio("verifier"),
        devverif_mode: getRadio("devverif")
      });
    }, 300);
  }
  $("tab-options").addEventListener("change", function () { updateVerifierWarn(); saveOptions(); });
  $("o-spoofpkg").addEventListener("input", saveOptions);
  $("o-user").addEventListener("input", saveOptions);

  // --- about ------------------------------------------------------------
  function loadAbout() { api("version", {}).then(function (r) { if (r.version) $("ver").textContent = r.version + " (" + r.versionCode + ")"; }); }

  // --- restore install-source + activity log ----------------------------
  function pollSimple(opid, done) {
    apiRaw("progress", opid).then(function (p) {
      if (p.done) done(p); else setTimeout(function () { pollSimple(opid, done); }, 800);
    });
  }
  $("restore-source-btn").addEventListener("click", function () {
    var b = $("restore-source-btn"); b.disabled = true; $("restore-status").textContent = T("phase_starting");
    api("restore-source", {}).then(function (r) {
      if (!r.ok || !r.opid) { b.disabled = false; $("restore-status").textContent = r.message || T("err_generic"); return; }
      pollSimple(r.opid, function (p) {
        b.disabled = false;
        if (p.restored) { $("restore-status").textContent = T("msg_restore_ok"); loadActivity(); }
        else if (p.error === "ERR_NO_BACKUP") $("restore-status").textContent = T("msg_restore_none");
        else $("restore-status").textContent = T("msg_restore_fail", { msg: (p.message || p.error || "") });
      });
    });
  });
  function loadActivity() {
    api("history", { n: 50 }).then(function (r) {
      var el = $("activity"); if (!el) return;
      var ents = (r && r.entries) ? r.entries : [];
      if (!ents.length) { el.textContent = T("about_activity_empty"); return; }
      el.textContent = ents.slice().reverse().map(function (e) {
        return (e.ts ? e.ts.replace("T", " ").replace("Z", "") + "  " : "") + (e.msg || "");
      }).join("\n");
    });
  }

  // --- boot -------------------------------------------------------------
  api("config-get", {}).then(function (c) {
    var lang = (c && c.language) ? c.language : "auto";
    window.I18N.init(lang).then(function () { selectMode("single"); });
  });
  loadOptions();
  loadAbout();
  initVdlu();
})();
