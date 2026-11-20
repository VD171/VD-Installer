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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · Čeština · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Přispívání

Příspěvky jsou vítány - issues, pull requesty, překlady a dokumentace. Projekt usiluje o to, aby
se do něj přispívalo snadno a příjemně.

## Přispěvatelé s AI vítáni

Příspěvky od AI a agentů jsou vítány se stejnou laťkou kontroly jako od kohokoli jiného. Engine
mluví pomocí JSON přes bezhlavý kontrakt (`scripts/helper.sh <verb> <base64(JSON)>`); viz
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Řiďte kontrakt, nescrapujte WebUI.

## Pravidla kódu

- **Úplná hlavička v každém souboru** (SPDX + kontakty) na začátku každého zdrojového souboru. Nikdy ne zkrácená.
- Kód, identifikátory, logy a komentáře v **angličtině**. Komentáře jen tehdy, když něco přidávají.
- Shell je **POSIX sh** pro zařízení (`sh -n` musí projít; žádné bashismy kromě `local`; žádná závislost na `jq` v cestách kódu, které musí běžet dříve, než je přibalený `jq` v PATH).
- WebUI je **čisté JS**, bez frameworku; světlý i tmavý režim v celém UI.
- **Nikdy** em-dash ani en-dash; vždy spojovník `-`.
- Build je vždy **release**, nikdy debug.
- **Nikdy neoslabujte skutečné chování**, aby něco prošlo, a nikdy neodstraňujte obsah.

## Překlady

Řetězce WebUI se nacházejí v `module/webroot/lang/<code>.json` (ploché klíče, anglický základ v
`lang/en.js`); README má `README.<code>.md` pro každý jazyk. Přidejte nebo opravte jazyk a otevřete PR.

## Licence

Přispěním souhlasíte s tím, že váš příspěvek je licencován pod GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Tato dokumentace byla vytvořena pomocí Claude (Anthropic) a spravuje ji VD171. Opravy a vylepšení jsou vítány; viz [CONTRIBUTING.md](CONTRIBUTING.md)._
