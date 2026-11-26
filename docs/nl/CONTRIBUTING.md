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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · Nederlands · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Bijdragen

Bijdragen zijn welkom - issues, pull requests, vertalingen en documentatie. Het project wil gemakkelijk en uitnodigend zijn om aan bij te dragen.

## AI-bijdragers welkom

Bijdragen van AI en agents zijn welkom op dezelfde reviewlat als die van iedereen. De engine spreekt JSON over een headless contract (`scripts/helper.sh <verb> <base64(JSON)>`), zie [docs/AI-AGENTS.md](docs/AI-AGENTS.md). Stuur het contract aan, scrape de WebUI niet.

## Coderegels

- **Volledige banner per bestand** (SPDX + contacten) bovenaan elk bronbestand. Nooit een ingekorte.
- Code, identifiers, logs en commentaar in het **Engels**. Commentaar alleen als het iets toevoegt.
- De shell is **POSIX sh** voor het apparaat (`sh -n` moet slagen, geen bashisms buiten `local`, geen `jq`-afhankelijkheid in codepaden die moeten draaien voordat de meegeleverde `jq` op het PATH staat).
- De WebUI is **vanilla JS**, geen framework, licht en donker in alle UI.
- **Nooit** een em-dash of en-dash, altijd een koppelteken `-`.
- De build is altijd **release**, nooit debug.
- **Verzwak nooit echt gedrag** om iets te laten slagen, en verwijder nooit inhoud.

## Vertalingen

De WebUI-strings staan in `module/webroot/lang/<code>.json` (platte sleutels, Engelse basis in `lang/en.js`), de README heeft een `README.<code>.md` per taal. Voeg een taal toe of verbeter er een en open een PR.

## Licentie

Door bij te dragen ga je ermee akkoord dat je bijdrage wordt gelicentieerd onder de GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Deze documentatie is gegenereerd met Claude (Anthropic) en wordt onderhouden door VD171. Correcties en verbeteringen zijn welkom, zie [CONTRIBUTING.md](CONTRIBUTING.md)._
