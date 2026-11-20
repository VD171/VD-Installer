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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · Deutsch · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Mitwirken

Beiträge sind willkommen - Issues, Pull Requests, Übersetzungen und Dokumentation. Das Projekt
möchte einfach und einladend zum Mitwirken sein.

## KI-Mitwirkende willkommen

Beiträge von KI und Agenten sind mit derselben Prüflatte wie bei allen anderen willkommen. Die
Engine spricht JSON über einen Headless-Kontrakt (`scripts/helper.sh <verb> <base64(JSON)>`); siehe
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Steuere den Kontrakt an, scrape nicht die WebUI.

## Code-Regeln

- **Vollständiges Banner pro Datei** (SPDX + Kontakte) am Anfang jeder Quelldatei. Niemals ein gekürztes.
- Code, Bezeichner, Logs und Kommentare auf **Englisch**. Kommentare nur, wenn sie etwas hinzufügen.
- Die Shell ist **POSIX sh** für das Gerät (`sh -n` muss bestehen; keine Bashismen außer `local`; keine `jq`-Abhängigkeit in Code-Pfaden, die laufen müssen, bevor das mitgelieferte `jq` im PATH ist).
- Die WebUI ist **reines JS**, ohne Framework; hell und dunkel in der gesamten UI.
- **Niemals** ein Em-Dash oder En-Dash; immer ein Bindestrich `-`.
- Der Build ist immer **release**, niemals debug.
- **Schwäche niemals ein echtes Verhalten ab**, um etwas durchzubekommen, und entferne niemals Inhalte.

## Übersetzungen

Die WebUI-Strings liegen in `module/webroot/lang/<code>.json` (flache Schlüssel, englische Basis in
`lang/en.js`); die README hat eine `README.<code>.md` pro Sprache. Füge eine Sprache hinzu oder korrigiere sie und öffne einen PR.

## Lizenz

Mit deinem Beitrag stimmst du zu, dass dein Beitrag unter der GNU AGPL-3.0-or-later lizenziert ist.

<!-- doc-footer -->

---

> _Diese Dokumentation wurde mit Claude (Anthropic) erstellt und wird von VD171 gepflegt. Korrekturen und Verbesserungen sind willkommen; siehe [CONTRIBUTING.md](CONTRIBUTING.md)._
