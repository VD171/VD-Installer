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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · Svenska · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Bidra

Bidrag är välkomna - ärenden (issues), pull requests, översättningar och dokumentation. Projektet strävar
efter att vara enkelt och inbjudande att bidra till.

## AI-bidragsgivare är välkomna

AI- och agentbidrag är välkomna på samma granskningsnivå som alla andra. Motorn talar JSON över ett
headless-kontrakt (`scripts/helper.sh <verb> <base64(JSON)>`); se
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Driv kontraktet, skrapa inte WebUI:t.

## Kodregler

- **Fullständig banner per fil** (SPDX + kontakter) överst i varje källfil. Aldrig en nedkortad.
- Kod, identifierare, loggar och kommentarer på **engelska**. Kommentarer endast när de tillför något.
- Skalet är **POSIX sh** för enheten (`sh -n` måste passera; inga bashismer utöver `local`; inget `jq`-beroende i kodvägar som måste köras innan den medföljande `jq` finns på PATH).
- WebUI:t är **vanilla JS**, inget ramverk; ljust och mörkt i hela gränssnittet.
- **Aldrig** ett em-streck eller en-streck; alltid ett bindestreck `-`.
- Bygget är alltid **release**, aldrig debug.
- **Försvaga aldrig ett verkligt beteende** för att få något att passera, och ta aldrig bort innehåll.

## Översättningar

WebUI-strängarna finns i `module/webroot/lang/<code>.json` (platta nycklar, engelsk bas i
`lang/en.js`); README har en `README.<code>.md` per språk. Lägg till eller åtgärda ett språk och öppna en PR.

## Licens

Genom att bidra godkänner du att ditt bidrag licensieras under GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Denna dokumentation genererades med Claude (Anthropic) och underhålls av VD171. Rättelser och förbättringar välkomnas; se [CONTRIBUTING.md](CONTRIBUTING.md)._
