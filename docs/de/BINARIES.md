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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · Deutsch · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Mitgelieferte Binaries: Herkunft und Prüfung

## Grundsätze

- Nichts Undurchsichtiges wird ausgeliefert. Jede mitgelieferte Binary wird zur **Build-Zeit von ihrem
  offiziellen Upstream** bezogen, nie von einem Gerät gezogen, und jede Datei trägt eine sha256, sodass
  die Nutzlast reproduziert werden kann.
- Binaries werden für **alle vier ABIs** mitgeliefert (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`), der
  Flash-Installer reduziert auf die eine des Geräts.
- Sie laufen eigenständig: der Shared-Library-Abschluss jeder Binary wird mitgeliefert und die Engine
  setzt `LD_LIBRARY_PATH` auf das mitgelieferte `lib/`, sodass keine Abhängigkeit von einem installierten
  Termux besteht.

## Was ausgeliefert wird, und von wo

| Binary | Von | Warum |
|---|---|---|
| `jq` (+ `lib/`) | dem Termux-Paket-Repository (`packages.termux.dev/apt`), offizielles `.deb` | die Engine spricht JSON; `jq` parst Argumente und baut Antworten. |
| `abx2xml` / `xml2abx` | [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) Release | dekodiert/kodiert Android-Binär-XML (ABX) für die `packages.xml`-Fälschung der Installationsquelle, wo dem Gerät `/system/bin/abx2xml` fehlt (vor A12). Der geräteeigene Konverter wird bevorzugt, wenn vorhanden. |
| `vdlu/verify/<abi>/ed25519-mini` | der kanonischen [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)-Engine | prüft die ed25519-Signatur bei flashlosen (VDLU) Updates, ohne OpenSSL. |

Der Build-Schritt ist `.github/scripts/build_bin.sh`: er löst das Termux-Paket plus seine transitiven
Abhängigkeiten auf, extrahiert die `.deb`s, kopiert die gewünschten Binaries und den
Shared-Library-Abschluss, den jede braucht (mit `readelf` aufgelöst), und bezieht dann den eigenständigen
ABX-Konverter.

## Das On-Device-Manifest: `PROVENANCE.json`

Jedes `bin/<abi>/` trägt eine `PROVENANCE.json`, die jede ausgelieferte Datei auflistet (Pfad, Größe,
sha256) und die Upstream-Quelle jeder einzelnen (Paket, Version, URL, Archiv-sha256). Sie übersteht die
ABI-Reduzierung auf dem Gerät, sodass die Prüfkette mit dem Modul selbst ausgeliefert wird.

## Wie man prüft

1. Öffne `bin/<abi>/PROVENANCE.json` auf dem Gerät oder im flashbaren Zip.
2. Beziehe jede fixierte Quelle erneut von der URL, die sie aufzeichnet.
3. Extrahiere und vergleiche die sha256 jeder Datei mit dem Manifest.

Das flashbare Zip trägt zusätzlich einen `.sha256`-Begleiter neben jeder ausgelieferten Datei;
`customize.sh` prüft sie zur Flash-Zeit und **bricht ab** bei jeder Abweichung (ein beschädigtes oder
abgeschnittenes Zip).

## Meldung

Eine Abweichung oder ein Herkunftsproblem gefunden? Melde es privat - siehe [SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Diese Dokumentation wurde mit Claude (Anthropic) erstellt und wird von VD171 gepflegt. Korrekturen und Verbesserungen sind willkommen, siehe [CONTRIBUTING.md](CONTRIBUTING.md)._
