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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · Polski · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Współtworzenie

Wkład jest mile widziany - zgłoszenia problemów, pull requesty, tłumaczenia i dokumentacja. Projekt ma
być łatwy i zachęcający do współtworzenia.

## Współtwórcy AI mile widziani

Wkład AI i agentów jest mile widziany na tym samym poziomie weryfikacji co wszystkich innych. Silnik
komunikuje się w JSON poprzez bezgłowy kontrakt (`scripts/helper.sh <verb> <base64(JSON)>`); zobacz
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Korzystaj z kontraktu, nie zbieraj danych z WebUI.

## Zasady dotyczące kodu

- **Kompletny baner w każdym pliku** (SPDX + kontakty) na początku każdego pliku źródłowego. Nigdy skrócony.
- Kod, identyfikatory, logi i komentarze po **angielsku**. Komentarze tylko wtedy, gdy coś wnoszą.
- Powłoka to **POSIX sh** dla urządzenia (`sh -n` musi przechodzić; żadnych bashizmów poza `local`; żadnej zależności od `jq` w ścieżkach kodu, które muszą działać, zanim dołączony `jq` znajdzie się w PATH).
- WebUI to **vanilla JS**, bez frameworka; jasny i ciemny motyw w całym interfejsie.
- **Nigdy** myślnik ani półpauza; zawsze łącznik `-`.
- Kompilacja zawsze w trybie **release**, nigdy debug.
- **Nigdy nie osłabiaj rzeczywistego zachowania**, aby coś przeszło, i nigdy nie usuwaj treści.

## Tłumaczenia

Ciągi znaków WebUI znajdują się w `module/webroot/lang/<code>.json` (płaskie klucze, angielska baza w
`lang/en.js`); README ma plik `README.<code>.md` dla każdego języka. Dodaj lub popraw język i otwórz PR.

## Licencja

Wnosząc wkład, zgadzasz się, że Twój wkład jest licencjonowany na warunkach GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Ta dokumentacja została wygenerowana za pomocą Claude (Anthropic) i jest utrzymywana przez VD171. Poprawki i ulepszenia są mile widziane; zobacz [CONTRIBUTING.md](CONTRIBUTING.md)._
