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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · Svenska · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Medföljande binärer: proveniens och granskning

## Principer

- Inget ogenomskinligt levereras. Varje medföljande binär hämtas vid **byggtid från sin officiella
  uppström**, aldrig dragen från en enhet, och varje fil bär en sha256 så att nyttolasten kan
  reproduceras.
- Binärer levereras för **alla fyra ABI:er** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`), flash-
  installeraren beskär till enhetens enda.
- De körs fristående: varje binärs delade biblioteksslutning levereras bredvid och motorn sätter
  `LD_LIBRARY_PATH` till den medföljande `lib/`, så det finns inget beroende av att Termux är
  installerat.

## Vad som levereras, och varifrån

| Binär | Från | Varför |
|---|---|---|
| `jq` (+ `lib/`) | Termux-paketförrådet (`packages.termux.dev/apt`), officiell `.deb` | motorn talar JSON; `jq` tolkar argument och bygger svar. |
| `abx2xml` / `xml2abx` | release från [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | avkoda/koda Androids binära XML (ABX) för installationskälleförfalskningen i `packages.xml`, där enheten saknar `/system/bin/abx2xml` (före A12). Enhetens egen konverterare föredras när den finns. |
| `vdlu/verify/<abi>/ed25519-mini` | den kanoniska [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)-motorn | verifiera ed25519-signaturen på flashlösa (VDLU) uppdateringar, utan OpenSSL. |

Byggsteget är `.github/scripts/build_bin.sh`: det löser upp Termux-paketet plus dess transitiva
beroenden, extraherar `.deb`-filerna, kopierar de önskade binärerna och den delade biblioteksslutning
var och en behöver (upplöst med `readelf`), och hämtar sedan den fristående ABX-konverteraren.

## Manifestet på enheten: `PROVENANCE.json`

Varje `bin/<abi>/` bär en `PROVENANCE.json` som listar varje levererad fil (sökväg, storlek, sha256)
och uppströmskällan för var och en (paket, version, URL, arkivets sha256). Den överlever ABI-
beskärningen på enheten, så granskningsspåret levereras med själva modulen.

## Hur man verifierar

1. Öppna `bin/<abi>/PROVENANCE.json` på enheten eller i den flashbara zip-filen.
2. Hämta om varje pinnad källa från den URL den registrerar.
3. Extrahera och jämför sha256 för varje fil mot manifestet.

Den flashbara zip-filen bär dessutom en `.sha256`-följeslagare bredvid varje levererad fil;
`customize.sh` verifierar dem vid flashtid och **avbryter** vid varje avvikelse (en skadad eller
trunkerad zip).

## Rapportering

Hittade du en avvikelse eller en proveniensoro? Rapportera den privat - se [SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Denna dokumentation genererades med Claude (Anthropic) och underhålls av VD171. Rättelser och förbättringar välkomnas, se [CONTRIBUTING.md](CONTRIBUTING.md)._
