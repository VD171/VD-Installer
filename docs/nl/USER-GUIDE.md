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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · Nederlands · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# VDInstaller-gebruikershandleiding

## Inhoudsopgave

1. [Wat VDInstaller is](#1-wat-vdinstaller-is)
2. [Vereisten](#2-vereisten)
3. [Installeren en eerste keer uitvoeren](#3-installeren-en-eerste-keer-uitvoeren)
4. [De WebUI-rondleiding](#4-de-webui-rondleiding)
5. [APK's installeren](#5-apks-installeren)
6. [Opties](#6-opties)
7. [VDInstaller aansturen vanuit een AI-assistent](#7-vdinstaller-aansturen-vanuit-een-ai-assistent)
8. [Problemen oplossen en FAQ](#8-problemen-oplossen-en-faq)

## 1. Wat VDInstaller is

VDInstaller is een KernelSU / APatch / Magisk **WebUI-module** die sideloaded APK's als root installeert
zonder wrijving: geen "verleen su"-prompt, geen terminal, en geen gevecht met de Play Protect-verifier.
Het verwerkt losse APK's, een hele map in een keer, en split-apps (`.xapk` / `.apkm` / `.apks` / `.zip`
of losse split-bestanden), en het kan de installatiebron als de Play Store presenteren zodat een app er
niet sideloaded uitziet.

## 2. Vereisten

- Android 8.0 of nieuwer (API 26+).
- Een root-oplossing met WebUI-ondersteuning: **KernelSU**, **APatch** of **Magisk**.

## 3. Installeren en eerste keer uitvoeren

1. Download de nieuwste `VD-Installer-vX.XX-universal.zip` van de
   [Releases](https://github.com/VD171/VD-Installer/releases)-pagina.
2. Flash het als een module in je root-manager (*Modules -> Install from storage*).
3. VDInstaller wordt **zonder herstart** geactiveerd - het is zelfstandig (WebUI + gebundelde binaries),
   dus er is niets om te mounten.
4. Open de **VDInstaller**-WebUI vanuit de modulelijst van je root-manager.

Bij het flashen behoudt de installer alleen de ABI van je apparaat en voert een verplichte
`.sha256`-integriteitscontrole uit die **afbreekt** als de zip beschadigd of afgekapt is. Instellingen
leven in `/data/adb/vdinstaller` en overleven updates.

## 4. De WebUI-rondleiding

Drie tabbladen:

- **Install** - kies een modus, kies de APK of map, installeer, bekijk de live voortgang.
- **Options** - installatiebron, de Play Protect-verifier-schakelaar, en installatievlaggen. Alles wordt
  automatisch opgeslagen.
- **About** - versie, wat het doet, vereisten, links en licentie.

## 5. APK's installeren

Je kiest de modus op het tabblad **Install**; VDInstaller gokt nooit.

| Modus | Jij geeft | Wat er gebeurt |
|---|---|---|
| **Single APK** | een `.apk`-bestand | een installatiesessie, een app. |
| **Folder of APKs** (batch) | een map met onafhankelijke `.apk`-bestanden | elke APK wordt afzonderlijk geinstalleerd, de een na de ander; een gedeeltelijke batch meldt welke faalden en waarom. |
| **Split archive** | een `.xapk` / `.apkm` / `.apks` / `.zip` | uitgepakt, dan worden `base.apk` + splits als een app in een enkele sessie geinstalleerd (XAPK OBB wordt ook geplaatst, indien aanwezig). |
| **Split folder** | een map met de losse split-`.apk`-bestanden van een app | de splits worden als een app in een enkele sessie geinstalleerd. |

Een "split"-app is een APK verdeeld in een basis plus per-dichtheid- / per-ABI- / per-taal-config-APK's;
ze moeten **samen** in een sessie worden geinstalleerd, wat de Split-modi voor je doen.

### 5.1 Het Browse-dialoogvenster

**Browse** opent een bestandskiezer die mappen en installeerbare bestanden op een pad toont:

- Tik op een **map** om erin te gaan; **Up** gaat naar de bovenliggende map.
- In een bestandsmodus (Single APK / Split archive) tik je op een **bestand** om het te selecteren.
- In een mapmodus (Folder of APKs / Split folder) navigeer je in de map en tik je op **Use this folder**.

Je kunt ook rechtstreeks een pad typen of plakken (bijvoorbeeld `/sdcard/Download/app.apk`).

### 5.2 Voortgang, annuleren, hervatten

Installaties draaien als een **losgekoppeld root-proces**. Een voortgangskaart toont de fase; **Cancel**
stopt het. Als je de WebUI halverwege de installatie sluit, gaat de installatie door en koppelt de UI
zich opnieuw vast op bewerkings-id wanneer je hem heropent.

## 6. Opties

Alles hier wordt automatisch opgeslagen en geldt voor de volgende installatie.

### 6.1 Installatiebron

Een vers sideloaded app kondigt aan elke app die het leest (en aan attestatie) aan dat het sideloaded
was. VDInstaller kan in plaats daarvan de bron als de Play Store presenteren.

- **Toon de Play Store als installer** (standaard aan) - stelt `installerPackageName` in via
  `pm install-create -i com.android.vending`. Wordt onmiddellijk toegepast.
- **Spoof ook de initiator** (standaard aan) - stelt `installInitiator` en `packageSource` in door
  `/data/system/packages.xml` te bewerken. Dit is **ABX-bewust** (decoderen -> bewerken -> opnieuw
  coderen, met een byte-exacte back-up en een atomische wissel) en wordt **na de volgende herstart**
  toegepast, omdat de package manager `packages.xml` cachet.

### 6.2 Play Protect-pakketverifier

Een sideloaded installatie kan met `INSTALL_FAILED_VERIFICATION_FAILURE` worden geweigerd door de
pakketverifier van Play Protect. Een schakelaar met 3 standen:

- **Laat zoals het was** (standaard) - alleen uit voor de installatie, daarna hersteld naar de **exacte**
  eerdere staat (opnieuw verwijderd als er geen expliciete waarde was, aangezien een `0`/`1` waar er geen
  was zelf een verklikker is op een stealth-apparaat).
- **Altijd aan** - forceer het aan en houd het zo.
- **Altijd uit** - forceer het uit en houd het zo. De WebUI waarschuwt: het uit laten is een
  stealth-verklikker en schakelt een malwarescan uit voor elke installatie.

### 6.3 Developer Verification

De Developer Verification van Android uit 2026 blokkeert het installeren van apps van niet-geregistreerde
ontwikkelaars op gecertificeerde apparaten, maar het wordt afgedwongen door een **aparte dienst**, niet
door Play Protect, en een **root-installatie is er al van vrijgesteld** (dezelfde vrijstelling die
ADB-installaties krijgen). VDInstaller installeert je APK's hoe dan ook, dus deze schakelaar is
**best-effort en eerlijk**: hij past een echte knop alleen toe als die bestaat en doet nooit alsof hij
een schakelaar omzet die niets doet.

### 6.4 Installatievlaggen

| Vlag | Effect |
|---|---|
| **Verleen alle runtime-rechten** | verleen elk runtime-recht bij installatie (`-g`). |
| **Testpakketten toestaan** | installeer pakketten die als test-only gemarkeerd zijn (`-t`). |
| **Lage target-SDK-blokkade omzeilen** | installeer apps met een heel oude `targetSdk`. |
| **Doelgebruiker** | de Android-gebruikers-id om voor te installeren (standaard `0`). |

### 6.5 Verborgen blijven

Overweeg voor stealth om je root-manager en gevoelige apps met HMA-OSS te verbergen. VDInstaller **raakt
je HMA-OSS-opzet nooit aan** - de hint is slechts een herinnering; je brengt de wijziging zelf aan in
HMA-OSS.

## 7. VDInstaller aansturen vanuit een AI-assistent

De engine spreekt een klein JSON-contract over `scripts/helper.sh`, zodat een agent elke actie kan
aansturen die de WebUI kan. Zie [AI-AGENTS](AI-AGENTS). Stuur het contract aan, scrape de WebUI niet.

## 8. Problemen oplossen en FAQ

**Ik krijg `INSTALL_FAILED_VERIFICATION_FAILURE`.** Dat is de pakketverifier van Play Protect. Met de
verifier-schakelaar op **Laat zoals het was** (de standaard) zet VDInstaller hem uit voor de installatie
en herstelt hem, zodat het niet gebeurt.

**Ik heb de Play Store-bron aangezet maar de app ziet er nog steeds sideloaded uit.** Het installer-deel
wordt onmiddellijk toegepast; het initiator-deel (`packages.xml`) wordt **na de volgende herstart**
toegepast.

**Omzeilt het de Developer Verification van Google?** Dat hoeft niet - een root-installatie is
vrijgesteld (zie 6.3). Er is geen nepschakelaar voor.

**Is een herstart nodig?** Nee, behalve de optionele initiator-spoof.

**Verwijdert het deinstalleren van VDInstaller de apps die ik installeerde?** Nee - dat zijn echte
installaties die eigendom zijn van het systeem; het verwijderen van de module ruimt alleen de eigen staat
van VDInstaller op.

**Is het veilig?** Het installeert APK's die jij kiest en, met de verifier uit, slaat het een malwarescan
over - installeer alleen APK's die je vertrouwt. Het verzwakt nooit iets stilletjes.

<!-- doc-footer -->

---

> _Deze documentatie is gegenereerd met Claude (Anthropic) en wordt onderhouden door VD171. Correcties en verbeteringen zijn welkom; zie [CONTRIBUTING.md](CONTRIBUTING.md)._
