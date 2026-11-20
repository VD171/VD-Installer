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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · Svenska · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Friktionsfri root-installerare för sidoladdade APK - KernelSU / APatch / Magisk WebUI.

## Varför

Att installera en sidoladdad APK på en rootad telefon är brakigare än det borde vara: Play Protects
paketverifierare kan kasta `INSTALL_FAILED_VERIFICATION_FAILURE`, split-appar (`.xapk` / `.apkm` / `.apks`)
behöver session-API:t för hand, och en nyss installerad app kungör sig som "sideloaded" för varje app som
läser dess installationskälla. VDInstaller gör allt detta åt dig, redan som root, utan någon "bevilja
su"-dialog och utan terminal.

## Funktioner

- **Varje form av APK** - en enskild `.apk`, en hel mapp med fristående APK:er (batch), ett grupperat
  split-arkiv (`.xapk` / `.apkm` / `.apks` / `.zip`) eller en mapp med lösa split-APK:er.
- **Ingen verifieringsmur** - en 3-lägesväxel för Play Protects paketverifierare: behåll som det var
  (av endast under installationen, återställd exakt), alltid på eller alltid av.
- **Ärlig om Developer Verification** - en root-installation är redan undantagen från Androids Developer
  Verification från 2026; växeln gör sitt bästa och säger det, aldrig en falsk omkopplare.
- **Inte "sideloaded"** - presenterar valfritt installationskällan som Play Store, både installeraren
  (vid installationstillfället) och initieraren (via en ABX-medveten `packages.xml`-redigering).
- **Fristående och återupptagbar** - installationer kör som en fristående root-process; att stänga WebUI:t
  avbryter dem aldrig, och gränssnittet återansluter via operations-id.
- **Ditt val** - testpaket, bevilja alla körningsbehörigheter, målanvändare, kringgå
  blockeringen för låg mål-SDK: allt valfritt.
- **Offline, fristående, omstartsfri** - en WebUI-modul med sina binärer medföljande; användbar i samma
  stund den flashas.

## AI-agenter

Detta projekt välkomnar bidragsgivare som är AI och agenter. Motorn talar JSON över ett litet huvudlöst
kontrakt (`scripts/helper.sh <verb> <base64(JSON)>`), dokumenterat i
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), så att en agent kan driva varje åtgärd som WebUI:t kan - skrapa
inte WebUI:t. Patchar från AI hålls till samma granskningskrav som alla andra.

## Installera

Flasha zip-filen i KernelSU, APatch eller Magisk och öppna VDInstaller-WebUI:t från din root-hanterare.
Installeraren behåller endast din enhets ABI och kör den obligatoriska `.sha256`-integritetsgrinden
(avbryter vid en skadad eller trunkerad zip). Android 8.0 (API 26) eller nyare.

## Säkerhet

VDInstaller kör som root och installerar APK:er du väljer; att stänga av paketverifieraren för en
installation inaktiverar en skadeprogramsökning, så installera endast APK:er du litar på. Den försvagar
aldrig enhetens säkerhet i tysthet: verifieraren återställs som standard till sitt exakta tidigare
tillstånd, och den rör aldrig din HMA-OSS-inställning. Rapportera problem enligt [SECURITY.md](SECURITY.md).

## Bygga

Alltid release, aldrig debug. `.github/scripts/build_bin.sh` hämtar `jq` från Termux apt-arkivet
(med dess slutna mängd delade bibliotek) och de fristående konverterarna `abx2xml` / `xml2abx`,
för alla fyra ABI, var och en med en `PROVENANCE.json`. Release-arbetsflödet sammanställer de flashbara
zip-filerna, skriver `.sha256`-följeslagare, fyller i `update.json` och publicerar som `github-actions[bot]`.

## Dokumentation

Guider finns i [docs/](docs/) och speglas till GitHub-wikin. Se
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) för det huvudlösa kontraktet.

## Se även

- [VDBackup](https://github.com/VD171/VD-Backup) - fullständig säkerhetskopiering och återställning av appar och data, som root.
- [VDInfos](https://github.com/VD171/VD-Infos) - läs varje enhetsinfo med varje metod, jämför sedan.
- [VDGoogle](https://github.com/VD171/VDGoogle) - läs RCS, Wallet och attesteringar som root.
- [COPG-VD](https://github.com/VD171/COPG-VD) - modul för Pixel-fingerprint och props.

## Kontakter

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

## Licens

VDInstaller är licensierad under GNU AGPL-3.0-or-later. Se [LICENSE](LICENSE). NETWORK COPYLEFT:
kör en modifierad version, även som en tjänst, och du måste erbjuda dess källkod.

## Varumärken

Android, KernelSU, APatch, Magisk, Google Play och Play Protect tillhör sina respektive ägare.
Detta projekt är oberoende och inte anslutet till eller stött av dem.

## Taggar

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Gå med i kanalen: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
