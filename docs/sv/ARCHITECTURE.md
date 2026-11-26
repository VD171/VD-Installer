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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · Svenska · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Arkitektur

VDInstaller är ett tunt WebUI ovanpå en root-skalmotor. Inget i gränssnittet har privilegier, varje
privilegierad åtgärd är ett skalanrop som returnerar ett JSON-objekt.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - ren JS-WebUI (inget ramverk), ljus/mörk, 22 språk. Den anropar motorn genom
  KernelSU WebUI-bryggan (`ksu.exec`) och tolkar JSON-svaret.
- **`scripts/common.sh`** - det delade biblioteket som båda skripten läser in: ABI/PATH-upplösning,
  omslagen för `pm`/`dumpsys`/`fw` (ren miljö så att de medföljande Termux-biblioteken aldrig
  skuggar ART:s), JSON- och `jq`-hjälparna, samt den ABX-medvetna `xml_edit`.
- **`scripts/helper.sh`** - WebUI-kontraktet: en JSON-rad per anrop. Korta verb (version, config,
  browse, scan) körs inline, långa (install, uninstall) frikopplar en worker och returnerar ett `opid`.
- **`scripts/worker.sh`** - den frikopplade installationsmotorn: de fyra installationslägena,
  verifierarväxeln, installationskälleförfalskningen och pakethanterarens sessions-API. Den skriver
  förlopp till en fil som WebUI pollar, och överlever att WebUI stängs (`setsid`, och den undgår
  appfrysaren).

## Nyckelpunkter

- **Redan root.** Ingen "bevilja su"-fråga och ingen `sucompat`-växling, motorn körs som root från
  modulen och anropar `pm` / `settings` direkt.
- **Sessionsinstallationer.** Alla lägen använder `pm install-create` / `install-write` /
  `install-commit`, så delade appar installeras korrekt och installationskällan (`-i`) sätts vid
  sessionens start.
- **ABX-medveten.** Initiator-förfalskningen i `packages.xml` kontrollerar efter den binära XML-
  magin `ABX\0`, avkodar, redigerar, omkodar, går tur och retur för att validera, säkerhetskopierar
  byte-exakt och växlar atomärt, den aktiva filen rörs aldrig om inte varje steg lyckas.
- **Omstartsfri.** En fristående WebUI-modul utan något att montera: `customize.sh` kopierar in den i
  den aktiva modulkatalogen så att den fungerar i samma ögonblick den flashas.
- **Flashlösa uppdateringar.** Den medföljande **VDLU**-motorn uppdaterar modulen genom att bara
  ladda ner de ändrade, innehållsadresserade, ed25519-signerade filerna - ingen fullständig
  omflashning.
- **Frikopplad.** Långa operationer körs utanför webviewen, att stänga WebUI avbryter dem aldrig.

## Kompatibilitetsgaranti

- POSIX `sh` på enheten (`sh -n` går igenom, inga bashismer utöver `local`, inget `awk`-beroende).
- `pm` / `dumpsys` / `settings` / `cmd` är de enda ramverksverktygen som används, alla via
  `/system/bin`.
- Medföljande binärer (`jq`, `abx2xml`/`xml2abx`) är valfria för den vanliga vägen och bär proveniens;
  ABX-konverteraren faller tillbaka på enhetens egen `/system/bin/abx2xml` där den finns.

<!-- doc-footer -->

---

> _Denna dokumentation genererades med Claude (Anthropic) och underhålls av VD171. Rättelser och förbättringar välkomnas, se [CONTRIBUTING.md](CONTRIBUTING.md)._
