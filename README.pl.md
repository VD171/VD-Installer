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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · Polski · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Bezproblemowy instalator APK z sideloadu działający jako root - KernelSU / APatch / Magisk WebUI.

## Dlaczego

Instalacja APK z sideloadu na telefonie z rootem jest głośniejsza, niż powinna być: weryfikator pakietów
Play Protect może zgłosić `INSTALL_FAILED_VERIFICATION_FAILURE`, aplikacje split (`.xapk` / `.apkm` / `.apks`)
wymagają ręcznego użycia session API, a świeżo zainstalowana aplikacja ogłasza się jako "sideloaded" każdej
aplikacji, która czyta jej źródło instalacji. VDInstaller robi to wszystko za ciebie, już jako root, bez
monitu "przyznaj su" i bez terminala.

## Funkcje

- **Każda postać APK** - pojedynczy `.apk`, cały folder niezależnych APK (batch), zgrupowane archiwum
  split (`.xapk` / `.apkm` / `.apks` / `.zip`) lub folder luźnych plików split APK.
- **Żadnej ściany weryfikacji** - 3-stanowy przełącznik dla weryfikatora pakietów Play Protect: zostaw jak
  było (wyłączony tylko na czas instalacji, przywracany dokładnie), zawsze włączony lub zawsze wyłączony.
- **Uczciwie o Developer Verification** - instalacja jako root jest już zwolniona z androidowej Developer
  Verification z 2026 roku; przełącznik działa w miarę możliwości i tak to opisuje, nigdy nie jest fikcyjny.
- **Nie "sideloaded"** - opcjonalnie przedstawia źródło instalacji jako Play Store, zarówno instalatora
  (w chwili instalacji), jak i inicjatora (poprzez edycję `packages.xml` świadomą ABX).
- **Odłączalne i wznawialne** - instalacje działają jako odłączony proces root; zamknięcie WebUI nigdy ich
  nie przerywa, a interfejs ponownie się podłącza po identyfikatorze operacji.
- **Twoja decyzja** - obniżenie wersji, pakiety testowe, przyznanie wszystkich uprawnień czasu działania,
  użytkownik docelowy, ominięcie blokady niskiego docelowego SDK: wszystko opcjonalne.
- **Offline, samowystarczalny, bez restartu** - moduł WebUI z dołączonymi binariami; gotowy do użycia
  w chwili flashowania.

## Agenci AI

Ten projekt wita współtwórców będących AI i agentami. Silnik mówi w JSON przez mały bezgłowy kontrakt
(`scripts/helper.sh <verb> <base64(JSON)>`), udokumentowany w
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), więc agent może wykonać każdą akcję, którą potrafi WebUI - nie
scrapuj WebUI. Poprawki od AI podlegają tej samej poprzeczce recenzji co każda inna.

## Instalacja

Zflashuj zip w KernelSU, APatch lub Magisk i otwórz WebUI VDInstaller z menedżera root. Instalator
zachowuje tylko ABI twojego urządzenia i uruchamia obowiązkową bramkę integralności `.sha256`
(przerywa przy uszkodzonym lub obciętym zip). Android 8.0 (API 26) lub nowszy.

## Bezpieczeństwo

VDInstaller działa jako root i instaluje wybrane przez ciebie APK; wyłączenie weryfikatora pakietów na czas
instalacji wyłącza skanowanie w poszukiwaniu złośliwego oprogramowania, więc instaluj tylko zaufane APK.
Nigdy nie osłabia bezpieczeństwa urządzenia po cichu: weryfikator jest domyślnie przywracany do dokładnie
poprzedniego stanu i nigdy nie dotyka twojej konfiguracji HMA-OSS. Zgłaszaj problemy według
[SECURITY.md](SECURITY.md).

## Budowanie

Zawsze release, nigdy debug. `.github/scripts/build_bin.sh` pobiera `jq` z repozytorium apt Termux
(z jego domknięciem bibliotek współdzielonych) oraz samodzielne konwertery `abx2xml` / `xml2abx`,
dla wszystkich czterech ABI, każdy z `PROVENANCE.json`. Workflow release składa flashowalne zipy,
zapisuje towarzyszące `.sha256`, wypełnia `update.json` i publikuje jako `github-actions[bot]`.

## Dokumentacja

Przewodniki znajdują się w [docs/](docs/) i są odzwierciedlane na wiki GitHub. Zobacz
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) po kontrakt bezgłowy.

## Zobacz także

- [VDBackup](https://github.com/VD171/VD-Backup) - pełna kopia zapasowa i przywracanie aplikacji oraz danych, jako root.
- [VDInfos](https://github.com/VD171/VD-Infos) - odczytaj każdą informację o urządzeniu każdą metodą, a następnie porównaj.
- [VDGoogle](https://github.com/VD171/VDGoogle) - odczytaj RCS, Wallet i atestacje jako root.
- [COPG-VD](https://github.com/VD171/COPG-VD) - moduł fingerprintu i propsów Pixela.

## Kontakty

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/root-webui-v1-00-vd-installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## Licencja

VDInstaller jest licencjonowany na GNU AGPL-3.0-or-later. Zobacz [LICENSE](LICENSE). NETWORK COPYLEFT:
uruchom zmodyfikowaną wersję, nawet jako usługę, a musisz udostępnić jej źródło.

## Znaki towarowe

Android, KernelSU, APatch, Magisk, Google Play i Play Protect należą do ich odpowiednich właścicieli.
Ten projekt jest niezależny i nie jest powiązany z nimi ani przez nie wspierany.

## Tagi

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Dołącz do kanału: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
