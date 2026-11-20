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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · Nederlands · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Gebundelde binaries: herkomst en audit

## Principes

- Niets ondoorzichtigs wordt meegeleverd. Elke gebundelde binary wordt op **buildtijd van zijn officiele
  upstream** opgehaald, nooit van een apparaat getrokken, en elk bestand draagt een sha256 zodat de
  payload gereproduceerd kan worden.
- Binaries worden gebundeld voor **alle vier de ABI's** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`); de
  flash-installer snoeit tot die van het apparaat.
- Ze draaien zelfstandig: de gedeelde-bibliotheek-closure van elke binary wordt ernaast meegeleverd en de
  engine stelt `LD_LIBRARY_PATH` in op de gebundelde `lib/`, dus er is geen afhankelijkheid van een
  geinstalleerde Termux.

## Wat wordt meegeleverd, en vanwaar

| Binary | Van | Waarom |
|---|---|---|
| `jq` (+ `lib/`) | de Termux-pakketrepository (`packages.termux.dev/apt`), officiele `.deb` | de engine spreekt JSON; `jq` parseert argumenten en bouwt antwoorden. |
| `abx2xml` / `xml2abx` | [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) release | decodeer/codeer Android binaire XML (ABX) voor de `packages.xml`-installatiebron-spoof, waar het apparaat `/system/bin/abx2xml` mist (pre-A12). De eigen converter van het apparaat heeft de voorkeur indien aanwezig. |
| `vdlu/verify/<abi>/ed25519-mini` | de canonieke [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)-engine | verifieer de ed25519-handtekening op flashless (VDLU) updates, zonder OpenSSL. |

De buildstap is `.github/scripts/build_bin.sh`: hij lost het Termux-pakket plus zijn transitieve
afhankelijkheden op, pakt de `.deb`'s uit, kopieert de gewenste binaries en de gedeelde-bibliotheek-
closure die elk nodig heeft (opgelost met `readelf`), en haalt dan de zelfstandige ABX-converter op.

## Het manifest op het apparaat: `PROVENANCE.json`

Elke `bin/<abi>/` draagt een `PROVENANCE.json` die elk meegeleverd bestand opsomt (pad, grootte, sha256)
en de upstream-bron van elk (pakket, versie, URL, archief-sha256). Het overleeft het snoeien van de ABI
op het apparaat, dus het audittraject wordt met de module zelf meegeleverd.

## Hoe te verifieren

1. Open `bin/<abi>/PROVENANCE.json` op het apparaat of in de flashbare zip.
2. Haal elke vastgepinde bron opnieuw op van de URL die het registreert.
3. Pak uit en vergelijk de sha256 van elk bestand met het manifest.

De flashbare zip draagt daarnaast een `.sha256`-metgezel naast elk meegeleverd bestand; `customize.sh`
verifieert ze bij het flashen en **breekt af** bij elke mismatch (een beschadigde of afgekapte zip).

## Melden

Een mismatch of een herkomstbezwaar gevonden? Meld het privaat - zie [SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Deze documentatie is gegenereerd met Claude (Anthropic) en wordt onderhouden door VD171. Correcties en verbeteringen zijn welkom; zie [CONTRIBUTING.md](CONTRIBUTING.md)._
