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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · Nederlands · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Architectuur

VDInstaller is een dunne WebUI bovenop een root-shell-engine. Niets in de UI heeft privileges; elke
bevoorrechte actie is een shell-aanroep die een JSON-object teruggeeft.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - vanilla JS WebUI (geen framework), licht/donker, 22 talen. Het roept de engine aan via
  de KernelSU WebUI-bridge (`ksu.exec`) en parseert het JSON-antwoord.
- **`scripts/common.sh`** - de gedeelde bibliotheek die door beide scripts wordt gesourced: ABI/PATH-
  resolutie, de `pm`/`dumpsys`/`fw`-wrappers (schone omgeving zodat de gebundelde Termux-libs nooit die
  van ART overschaduwen), de JSON- en `jq`-helpers, en de ABX-bewuste `xml_edit`.
- **`scripts/helper.sh`** - het WebUI-contract: een JSON-regel per aanroep. Korte verbs (version, config,
  browse, scan) draaien inline; lange (install, uninstall) koppelen een worker los en geven een `opid`
  terug.
- **`scripts/worker.sh`** - de losgekoppelde installatie-engine: de vier installatiemodi, de
  verifier-schakelaar, de installatiebron-spoof, en de sessie-API van de package manager. Het schrijft
  voortgang naar een bestand dat de WebUI pollt, en overleeft het sluiten van de WebUI (`setsid`, en het
  ontsnapt aan de app-freezer).

## Kernpunten

- **Al root.** Geen "verleen su"-prompt en geen `sucompat`-schakelen; de engine draait als root vanuit de
  module en roept `pm` / `settings` rechtstreeks aan.
- **Sessie-installaties.** Alle modi gebruiken `pm install-create` / `install-write` / `install-commit`,
  dus split-apps installeren correct en de installatiebron (`-i`) wordt op sessietijd ingesteld.
- **ABX-bewust.** De `packages.xml`-initiator-spoof controleert op de `ABX\0` binaire-XML-magic,
  decodeert, bewerkt, hercodeert, doet een round-trip ter validatie, maakt een byte-exacte back-up en
  wisselt atomisch; het live bestand wordt nooit aangeraakt tenzij elke stap slaagt.
- **Herstartvrij.** Een zelfstandige WebUI-module met niets om te mounten: `customize.sh` kopieert het in
  de actieve modulesmap zodat het werkt op het moment dat het geflasht wordt.
- **Flashless updates.** De meegeleverde **VDLU**-engine werkt de module bij door alleen de gewijzigde,
  content-adressed, ed25519-ondertekende bestanden te downloaden - geen volledige herflash.
- **Losgekoppeld.** Lange bewerkingen draaien buiten de webview; het sluiten van de WebUI onderbreekt ze
  nooit.

## Compatibiliteitsgarantie

- POSIX `sh` op het apparaat (`sh -n` slaagt; geen bashisms voorbij `local`; geen `awk`-afhankelijkheid).
- `pm` / `dumpsys` / `settings` / `cmd` zijn de enige gebruikte framework-tools, alle via `/system/bin`.
- Gebundelde binaries (`jq`, `abx2xml`/`xml2abx`) zijn optioneel voor het gangbare pad en dragen
  herkomst; de ABX-converter valt terug op de eigen `/system/bin/abx2xml` van het apparaat waar aanwezig.

<!-- doc-footer -->

---

> _Deze documentatie is gegenereerd met Claude (Anthropic) en wordt onderhouden door VD171. Correcties en verbeteringen zijn welkom; zie [CONTRIBUTING.md](CONTRIBUTING.md)._
