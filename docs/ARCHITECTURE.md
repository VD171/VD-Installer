<!--
  ======================================================================
   VD INSTALLER  ::  frictionless root sideload installer
   Install sideload APKs as root (single/batch/split), no friction: KernelSU/APatch/Magisk WebUI.

   Copyright (C) 2026  VD171
   SPDX-License-Identifier: AGPL-3.0-or-later

   Free software under the GNU AGPL v3 or later. NETWORK COPYLEFT: run a
   modified version, even as a service, and you MUST offer its source.

   Site           : https://vd171.ru
   Site           : https://vd.priv8.ru
   Source         : https://github.com/VD171/VD-Installer
   GitHub         : @VD171 https://github.com/VD171
   XDA-Developers : @VD171 https://xdaforums.com/m/vd171.4699873/
   XDA thread     : https://xdaforums.com/t/VD-Installer.4809504/
   Telegram       : @VD_Priv8 https://t.me/VD_Priv8
   Channel        : @Priv8_VD https://t.me/Priv8_VD
   Discord        : @VD.Priv8 https://discord.com/users/1296831918989639721
   E-mail         : vd.priv8@pm.me
  ======================================================================
-->

# Architecture

VDInstaller is a thin WebUI over a root shell engine. Nothing in the UI has privilege; every
privileged action is one shell call that returns one JSON object.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - vanilla JS WebUI (no framework), light/dark, 22 languages. It calls the engine
  through the KernelSU WebUI bridge (`ksu.exec`) and parses the JSON reply.
- **`scripts/common.sh`** - the shared library sourced by both scripts: ABI/PATH resolution, the
  `pm`/`dumpsys`/`fw` wrappers (clean env so the bundled Termux libs never shadow ART's), the JSON and
  `jq` helpers, and the ABX-aware `xml_edit`.
- **`scripts/helper.sh`** - the WebUI contract: one JSON line per call. Short verbs (version, config,
  browse, scan) run inline; long ones (install, uninstall) detach a worker and return an `opid`.
- **`scripts/worker.sh`** - the detached install engine: the four install modes, the verifier toggle,
  the install-source spoof, and the package-manager session API. It writes progress to a file the
  WebUI polls, and survives the WebUI being closed (`setsid`, and it escapes the app freezer).

## Key points

- **Already root.** No "grant su" prompt and no `sucompat` toggling; the engine runs as root from the
  module and calls `pm` / `settings` directly.
- **Session installs.** All modes use `pm install-create` / `install-write` / `install-commit`, so
  split apps install correctly and the install source (`-i`) is set at session time.
- **ABX-aware.** The `packages.xml` initiator spoof checks for the `ABX\0` binary-XML magic, decodes,
  edits, re-encodes, round-trips to validate, backs up byte-exact and swaps atomically; the live file
  is never touched unless every step passes.
- **Reboot-free.** A self-contained WebUI module with nothing to mount: `customize.sh` copies it into
  the active modules dir so it works the moment it is flashed.
- **Flashless updates.** The vendored **VDLU** engine updates the module by downloading only the
  changed, content-addressed, ed25519-signed files - no full reflash.
- **Detached.** Long operations run outside the webview; closing the WebUI never interrupts them.

## Compatibility guarantee

- POSIX `sh` on the device (`sh -n` passes; no bashisms beyond `local`; no `awk` dependency).
- `pm` / `dumpsys` / `settings` / `cmd` are the only framework tools used, all via `/system/bin`.
- Bundled binaries (`jq`, `abx2xml`/`xml2abx`) are optional for the common path and carry provenance;
  the ABX converter falls back to the device's own `/system/bin/abx2xml` where present.

<!-- doc-footer -->

---

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](../CONTRIBUTING.md)._
