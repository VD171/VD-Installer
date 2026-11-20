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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · Italiano · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Contribuire

I contributi sono benvenuti - issues, pull requests, traduzioni e docs. Il progetto mira a essere
facile e accogliente per chi vuole contribuire.

## Contributori AI benvenuti

I contributi di AI e agent sono benvenuti allo stesso standard di revisione di chiunque altro. L'engine
parla JSON tramite un headless contract (`scripts/helper.sh <verb> <base64(JSON)>`); vedi
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Guida il contract, non fare scraping della WebUI.

## Regole del codice

- **Banner per-file completo** (SPDX + contacts) in cima a ogni file sorgente. Mai uno ridotto.
- Codice, identificatori, log e commenti in **inglese**. Commenti solo quando aggiungono qualcosa.
- La shell e **POSIX sh** per il dispositivo (`sh -n` deve passare; nessun bashism oltre `local`; nessuna dipendenza da `jq` nei percorsi di codice che devono essere eseguiti prima che il `jq` incluso sia nel PATH).
- La WebUI e **vanilla JS**, senza framework; chiaro e scuro in tutta la UI.
- **Mai** un em-dash o un en-dash; sempre un hyphen `-`.
- La build e sempre **release**, mai debug.
- **Non indebolire mai un comportamento reale** per far passare qualcosa, e non rimuovere mai contenuti.

## Traduzioni

Le stringhe della WebUI si trovano in `module/webroot/lang/<code>.json` (flat keys, base inglese in
`lang/en.js`); il README ha un `README.<code>.md` per lingua. Aggiungi o correggi una lingua e apri una PR.

## Licenza

Contribuendo accetti che il tuo contributo sia concesso in licenza sotto la GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Questa documentazione è stata generata con Claude (Anthropic) ed è gestita da VD171. Correzioni e miglioramenti sono benvenuti; vedi [CONTRIBUTING.md](CONTRIBUTING.md)._
