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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · Polski · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# Polityka bezpieczeństwa

## Model zagrożeń w jednym zdaniu

VDInstaller działa jako root i instaluje pliki APK, które użytkownik wyraźnie wybiera; wyłączenie
weryfikatora Play Protect na czas instalacji wyłącza skanowanie w poszukiwaniu złośliwego
oprogramowania, więc jest to "instalacja bez tarcia", a nie "instalacja bezpieczna" - instaluj tylko te
pliki APK, którym ufasz.

## Co robi, a czego nie robi

- Domyślnie przywraca weryfikator pakietów do jego dokładnego poprzedniego stanu (pozostawienie `0`/`1`
  tam, gdzie wcześniej nic nie było, samo w sobie zdradza, więc jest ponownie usuwane).
- Nigdy nie ingeruje w Twoją konfigurację HMA-OSS; ukrywanie aplikacji to zalecenie, które realizujesz samodzielnie.
- Edycja źródła instalacji w `packages.xml` uwzględnia ABX, tworzy kopię zapasową aktywnego pliku co do
  bajta przed jakąkolwiek zmianą, wykonuje pełny cykl w celu walidacji i pozostawia aktywny plik
  nienaruszony w razie jakiegokolwiek niepowodzenia.
- Dołączone pliki binarne są pobierane podczas kompilacji z ich oficjalnego źródła upstream i zawierają `PROVENANCE.json`.

## Zgłaszanie podatności

Prosimy najpierw o zgłoszenie prywatne. Dołącz kroki do odtworzenia, wersję, której dotyczy problem, oraz wpływ.

- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me
- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)

<!-- doc-footer -->

---

> _Ta dokumentacja została wygenerowana za pomocą Claude (Anthropic) i jest utrzymywana przez VD171. Poprawki i ulepszenia są mile widziane; zobacz [CONTRIBUTING.md](CONTRIBUTING.md)._
