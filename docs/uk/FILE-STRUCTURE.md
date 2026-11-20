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

> **Languages:** [English](../FILE-STRUCTURE.md) · [العربية](../ar/FILE-STRUCTURE.md) · [Čeština](../cs/FILE-STRUCTURE.md) · [Deutsch](../de/FILE-STRUCTURE.md) · [Español](../es/FILE-STRUCTURE.md) · [فارسی](../fa/FILE-STRUCTURE.md) · [Français](../fr/FILE-STRUCTURE.md) · [हिन्दी](../hi/FILE-STRUCTURE.md) · [Bahasa Indonesia](../id/FILE-STRUCTURE.md) · [Italiano](../it/FILE-STRUCTURE.md) · [日本語](../ja/FILE-STRUCTURE.md) · [한국어](../ko/FILE-STRUCTURE.md) · [Nederlands](../nl/FILE-STRUCTURE.md) · [Polski](../pl/FILE-STRUCTURE.md) · [Português](../pt/FILE-STRUCTURE.md) · [Русский](../ru/FILE-STRUCTURE.md) · [Svenska](../sv/FILE-STRUCTURE.md) · [ไทย](../th/FILE-STRUCTURE.md) · [Türkçe](../tr/FILE-STRUCTURE.md) · Українська · [Tiếng Việt](../vi/FILE-STRUCTURE.md) · [中文](../zh/FILE-STRUCTURE.md)

---

# Структура файлів

```
module/                         flashable module root (module.prop at the top of the zip)
├── module.prop                 id/name/version/author/updateJson
├── customize.sh                flash hook: per-ABI prune, .sha256 gate, config seed, reboot-free activation
├── service.sh                  boot: VDLU flashless-update check (detached, no-op without a feed)
├── uninstall.sh                cleanup of transient state (keeps config)
├── update.json                 version + zipUrl for the in-app updater
├── META-INF/.../update-binary  Magisk/KernelSU installer stub
├── .vd/sha256-gate.sh          vendored flash-time integrity gate (aborts on mismatch)
├── scripts/
│   ├── common.sh               shared library: ABI/PATH, pm/dumpsys/fw wrappers, JSON+jq, ABX xml_edit
│   ├── helper.sh               WebUI JSON contract (verbs; long ops detach + opid)
│   └── worker.sh               detached install engine (4 modes, verifier toggle, install-source spoof, session API)
├── webroot/                    the WebUI
│   ├── index.html scripts.js styles.css config.json i18n.js
│   ├── lang/en.js + <code>.json    22-language strings
│   └── assets/logo-icon.svg
├── bin/<abi>/                  jq + abx2xml/xml2abx (+ lib/) + PROVENANCE.json   [built by CI, 4 ABIs]
└── vdlu/                       vendored VDLiveUpdate engine (update.sh, vdlu-verify, verify/<abi>, keyring)
docs/                           these guides (AI-AGENTS, ARCHITECTURE, BINARIES, FILE-STRUCTURE, USER-GUIDE)
.github/
├── workflows/                  VD-Installer.yml (release), ci.yml, wiki-sync.yml, bin-refresh.yml
└── scripts/                    build_bin.sh, version.sh, gen-sha256.sh, gen-doc-nav.py, gen_wiki.sh, vdlu-pack
README.md + README.<code>.md    22 languages
CHANGELOG.md CONTRIBUTING.md SECURITY.md CODE_OF_CONDUCT.md LICENSE
```

Робочий стан живе в `/data/adb/vdinstaller/` (конфігурація, журнали, проміжне розміщення), поза текою
модуля, тож він переживає оновлення.

## Звідки почати

- Щоб зрозуміти рушій, прочитайте `scripts/common.sh`, потім `scripts/worker.sh`.
- Щоб зрозуміти інтерфейс, прочитайте `webroot/index.html` та `webroot/scripts.js`.
- Щоб автоматизувати його, прочитайте [AI-AGENTS](AI-AGENTS) (контракт JSON `helper.sh`).
- Щоб побачити, як це поєднується, прочитайте [ARCHITECTURE](ARCHITECTURE).

## Документація

- [USER-GUIDE](USER-GUIDE) - встановлення, режими, параметри, усунення несправностей.
- [ARCHITECTURE](ARCHITECTURE) - як поєднуються WebUI, helper і worker.
- [BINARIES](BINARIES) - вбудовані бінарники, походження та аудит.
- [AI-AGENTS](AI-AGENTS) - безголовий контракт JSON.

<!-- doc-footer -->

---

> _Ця документація створена за допомогою Claude (Anthropic) і підтримується VD171. Виправлення та покращення вітаються; див. [CONTRIBUTING.md](CONTRIBUTING.md)._
