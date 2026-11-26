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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · Svenska · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# Användarguide för VDInstaller

## Innehållsförteckning

1. [Vad VDInstaller är](#1-vad-vdinstaller-är)
2. [Krav](#2-krav)
3. [Installation och första körning](#3-installation-och-första-körning)
4. [Rundtur i WebUI](#4-rundtur-i-webui)
5. [Installera APK-filer](#5-installera-apk-filer)
6. [Alternativ](#6-alternativ)
7. [Styra VDInstaller från en AI-assistent](#7-styra-vdinstaller-från-en-ai-assistent)
8. [Felsökning och vanliga frågor](#8-felsökning-och-vanliga-frågor)

## 1. Vad VDInstaller är

VDInstaller är en KernelSU / APatch / Magisk **WebUI-modul** som installerar sidladdade APK-filer som
root helt utan friktion: ingen "bevilja su"-fråga, ingen terminal och ingen kamp mot Play Protect-
verifieraren. Den hanterar enskilda APK-filer, en hel mapp på en gång och delade appar (`.xapk` /
`.apkm` / `.apks` / `.zip` eller lösa delfiler), och den kan presentera installationskällan som Play
Store så att en app inte ser sidladdad ut.

## 2. Krav

- Android 8.0 eller nyare (API 26+).
- En root-lösning med WebUI-stöd: **KernelSU**, **APatch** eller **Magisk**.

## 3. Installation och första körning

1. Ladda ner den senaste `VD-Installer-vX.XX-universal.zip` från sidan
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Flasha den som en modul i din root-hanterare (*Modules -> Install from storage*).
3. VDInstaller aktiveras **utan omstart** - den är fristående (WebUI + medföljande binärer), så det
   finns inget att montera.
4. Öppna WebUI för **VDInstaller** från modullistan i din root-hanterare.

Vid flashning behåller installeraren bara din enhets ABI och kör en obligatorisk `.sha256`-
integritetskontroll som **avbryter** om zip-filen är skadad eller trunkerad. Inställningar lever i
`/data/adb/vdinstaller` och överlever uppdateringar.

## 4. Rundtur i WebUI

Tre flikar:

- **Install** - välj ett läge, välj APK-fil eller mapp, installera, följ förloppet live.
- **Options** - installationskälla, växeln för Play Protect-verifieraren och installationsflaggor.
  Allt sparas automatiskt.
- **About** - version, vad den gör, krav, länkar och licens.

## 5. Installera APK-filer

Du väljer läget på fliken **Install**, VDInstaller gissar aldrig.

| Läge | Du anger | Vad som händer |
|---|---|---|
| **Enskild APK** | en `.apk`-fil | en installationssession, en app. |
| **Mapp med APK-filer** (batch) | en mapp med fristående `.apk`-filer | varje APK installeras för sig, en efter en; en delvis batch rapporterar vilka som misslyckades och varför. |
| **Delat arkiv** | en `.xapk` / `.apkm` / `.apks` / `.zip` | packas upp, sedan installeras `base.apk` + delar som en app i en enda session (XAPK OBB placeras också, om den finns). |
| **Delmapp** | en mapp med de lösa delade `.apk`-filerna för en app | delarna installeras som en app i en enda session. |

En "delad" app är en APK uppdelad i en bas plus konfigurations-APK:er per densitet / per ABI / per
språk, de måste installeras **tillsammans** i en session, vilket de delade lägena gör åt dig.

### 5.1 Bläddra-dialogen

**Browse** öppnar en filväljare som listar mappar och installerbara filer i en sökväg:

- Tryck på en **mapp** för att gå in i den, **Up** går till den överordnade.
- I ett fil-läge (Enskild APK / Delat arkiv), tryck på en **fil** för att välja den.
- I ett mapp-läge (Mapp med APK-filer / Delmapp), navigera in i mappen och tryck på **Use this folder**.

Du kan också skriva eller klistra in en sökväg direkt (till exempel `/sdcard/Download/app.apk`).

### 5.2 Förlopp, avbryt, återuppta

Installationer körs som en **frikopplad root-process**. Ett förloppskort visar fasen, **Cancel**
stoppar den. Om du stänger WebUI mitt i en installation fortsätter installationen, och gränssnittet
återansluter via operations-id när du öppnar det igen.

## 6. Alternativ

Allt här sparas automatiskt och gäller för nästa installation.

### 6.1 Installationskälla

En nyss sidladdad app meddelar varje app som läser den (och attestering) att den sidladdades.
VDInstaller kan i stället presentera källan som Play Store.

- **Visa Play Store som installerare** (på som standard) - sätter `installerPackageName` via
  `pm install-create -i com.android.vending`. Gäller omedelbart.
- **Förfalska även initiatorn** (på som standard) - sätter `installInitiator` och `packageSource`
  genom att redigera `/data/system/packages.xml`. Detta är **ABX-medvetet** (avkoda -> redigera ->
  omkoda, med en byte-exakt säkerhetskopia och en atomär växling) och gäller **efter nästa omstart**,
  eftersom pakethanteraren cachar `packages.xml`.

### 6.2 Play Protect-paketverifierare

En sidladdad installation kan avvisas med `INSTALL_FAILED_VERIFICATION_FAILURE` av Play Protects
paketverifierare. En 3-vägs växel:

- **Behåll som det var** (standard) - av endast under installationen, sedan återställd till sitt
  **exakta** tidigare tillstånd (raderad igen om det inte fanns något uttryckligt värde, eftersom en
  `0`/`1` där det inte fanns något i sig är ett avslöjande tecken på en stealth-enhet).
- **Alltid på** - tvinga på den och behåll den.
- **Alltid av** - tvinga av den och behåll den. WebUI varnar: att lämna den av är ett stealth-
  avslöjande och inaktiverar en skadeprogramskanning för varje installation.

### 6.3 Utvecklarverifiering

Androids Utvecklarverifiering från 2026 blockerar installation av appar från oregistrerade utvecklare
på certifierade enheter, men den upprätthålls av en **separat tjänst**, inte Play Protect, och en
**root-installation är redan undantagen** från den (samma undantag som ADB-installationer får).
VDInstaller installerar dina APK-filer oavsett, så den här växeln är **bästa möjliga och ärlig**: den
tillämpar en verklig knapp bara om en sådan finns och låtsas aldrig vrida om en brytare som inte gör
något.

### 6.4 Installationsflaggor

| Flagga | Effekt |
|---|---|
| **Bevilja alla körtidsbehörigheter** | bevilja varje körtidsbehörighet vid installation (`-g`). |
| **Tillåt testpaket** | installera paket märkta som endast test (`-t`). |
| **Kringgå blockering av låg mål-SDK** | installera appar med en mycket gammal `targetSdk`. |
| **Målanvändare** | det Android-användar-id som ska installeras för (standard `0`). |

### 6.5 Att förbli dold

För stealth, överväg att dölja din root-hanterare och känsliga appar med HMA-OSS. VDInstaller **rör
aldrig din HMA-OSS-uppsättning** - tipset är bara en påminnelse, du gör ändringen själv i HMA-OSS.

## 7. Styra VDInstaller från en AI-assistent

Motorn talar ett litet JSON-kontrakt över `scripts/helper.sh`, så en agent kan styra varje åtgärd som
WebUI kan. Se [AI-AGENTS](AI-AGENTS). Styr kontraktet, skrapa inte WebUI.

## 8. Felsökning och vanliga frågor

**Jag får `INSTALL_FAILED_VERIFICATION_FAILURE`.** Det är Play Protects paketverifierare. Med
verifierarväxeln kvar på **Behåll som det var** (standard) stänger VDInstaller av den för
installationen och återställer den, så det inträffar inte.

**Jag slog på Play Store-källan men appen ser fortfarande sidladdad ut.** Installerar-delen gäller
omedelbart, initiator-delen (`packages.xml`) gäller **efter nästa omstart**.

**Kringgår den Googles Utvecklarverifiering?** Den behöver inte - en root-installation är undantagen
(se 6.3). Det finns ingen falsk brytare för den.

**Behöver den en omstart?** Nej, förutom den valfria initiator-förfalskningen.

**Tar avinstallation av VDInstaller bort apparna jag installerade?** Nej - de är riktiga
installationer som ägs av systemet, att ta bort modulen rensar bara VDInstallers eget tillstånd.

**Är den säker?** Den installerar APK-filer du väljer och, med verifieraren av, hoppar över en
skadeprogramskanning - installera bara APK-filer du litar på. Den försvagar aldrig något i tysthet.

<!-- doc-footer -->

---

> _Denna dokumentation genererades med Claude (Anthropic) och underhålls av VD171. Rättelser och förbättringar välkomnas, se [CONTRIBUTING.md](CONTRIBUTING.md)._
