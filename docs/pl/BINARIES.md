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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · Polski · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Dołączone binaria: pochodzenie i audyt

## Zasady

- Nic nieprzejrzystego nie jest dostarczane. Każde dołączone binarium jest pobierane w **czasie budowania
  z oficjalnego źródła upstream**, nigdy nie jest ściągane z urządzenia, a każdy plik niesie sumę sha256,
  dzięki czemu ładunek można odtworzyć.
- Binaria są dołączane dla **wszystkich czterech ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`);
  instalator flash przycina je do jednego ABI urządzenia.
- Działają samodzielnie: domknięcie bibliotek współdzielonych każdego binarium jest dostarczane obok, a
  silnik ustawia `LD_LIBRARY_PATH` na dołączone `lib/`, więc nie ma zależności od zainstalowanego Termux.

## Co jest dostarczane i skąd

| Binarium | Z | Dlaczego |
|---|---|---|
| `jq` (+ `lib/`) | repozytorium pakietów Termux (`packages.termux.dev/apt`), oficjalny `.deb` | silnik mówi w JSON; `jq` parsuje argumenty i buduje odpowiedzi. |
| `abx2xml` / `xml2abx` | wydanie [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | dekoduj/koduj binarny XML Androida (ABX) na potrzeby podszycia się pod źródło instalacji w `packages.xml`, gdy urządzeniu brakuje `/system/bin/abx2xml` (przed A12). Preferowany jest własny konwerter urządzenia, gdy jest obecny. |
| `vdlu/verify/<abi>/ed25519-mini` | kanoniczny silnik [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | weryfikuj podpis ed25519 aktualizacji bez flashowania (VDLU), bez OpenSSL. |

Krokiem budowania jest `.github/scripts/build_bin.sh`: rozwiązuje pakiet Termux wraz z jego przechodnimi
zależnościami, wypakowuje pliki `.deb`, kopiuje wybrane binaria i domknięcie bibliotek współdzielonych,
którego każde potrzebuje (rozwiązane za pomocą `readelf`), a następnie pobiera samodzielny konwerter ABX.

## Manifest na urządzeniu: `PROVENANCE.json`

Każdy `bin/<abi>/` niesie `PROVENANCE.json` wymieniający każdy dostarczony plik (ścieżka, rozmiar,
sha256) oraz źródło upstream każdego z nich (pakiet, wersja, URL, sha256 archiwum). Przeżywa przycięcie
ABI na urządzeniu, więc ślad audytu jest dostarczany wraz z samym modułem.

## Jak zweryfikować

1. Otwórz `bin/<abi>/PROVENANCE.json` na urządzeniu lub w instalowalnym zipie.
2. Pobierz ponownie każde przypięte źródło z URL, który zapisuje.
3. Wypakuj i porównaj sumę sha256 każdego pliku z manifestem.

Instalowalny zip dodatkowo niesie towarzyszący plik `.sha256` obok każdego dostarczonego pliku;
`customize.sh` weryfikuje je w czasie instalacji flashem i **przerywa** przy jakiejkolwiek niezgodności
(uszkodzony lub niepełny zip).

## Zgłaszanie

Znalazłeś niezgodność lub obawę co do pochodzenia? Zgłoś to prywatnie - zobacz [SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Ta dokumentacja została wygenerowana za pomocą Claude (Anthropic) i jest utrzymywana przez VD171. Poprawki i ulepszenia są mile widziane, zobacz [CONTRIBUTING.md](CONTRIBUTING.md)._
