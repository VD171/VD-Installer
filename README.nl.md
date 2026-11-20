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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · Nederlands · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Wrijvingsloze root sideload-installer - KernelSU / APatch / Magisk WebUI.

## Waarom

Een gesideloade APK installeren op een geroote telefoon is rommeliger dan het zou moeten zijn: de
pakketverificatie van Play Protect kan `INSTALL_FAILED_VERIFICATION_FAILURE` geven, split-apps
(`.xapk` / `.apkm` / `.apks`) vereisen de session-API met de hand, en een pas geïnstalleerde app
kondigt zichzelf aan als "gesideload" bij elke app die de installatiebron leest. VDInstaller doet dit
allemaal voor je, al als root, zonder "verleen su"-prompt en zonder terminal.

## Functies

- **Elke vorm van APK** - een enkele `.apk`, een hele map met onafhankelijke APK's (batch), een
  gegroepeerd split-archief (`.xapk` / `.apkm` / `.apks` / `.zip`), of een map met losse split-APK's.
- **Geen verificatiemuur** - een 3-weg-schakelaar voor de Play Protect-pakketverificatie: houden zoals
  het was (alleen uit tijdens de installatie, exact hersteld), altijd aan, of altijd uit.
- **Eerlijk over Ontwikkelaarsverificatie** - een root-installatie is al vrijgesteld van Androids
  Ontwikkelaarsverificatie van 2026; de schakelaar is best-effort en zegt dat ook, nooit een nep-knop.
- **Niet "gesideload"** - presenteert optioneel de installatiebron als de Play Store, zowel de
  installer (op installatietijd) als de initiator (via een ABX-bewuste `packages.xml`-bewerking).
- **Losgekoppeld en hervatbaar** - installaties draaien als een losgekoppeld root-proces; het sluiten
  van de WebUI onderbreekt ze nooit, en de UI koppelt opnieuw aan op operatie-id.
- **Jouw keuze** - downgrade, testpakketten, alle runtime-machtigingen verlenen, doelgebruiker, de
  blokkade voor lage doel-SDK omzeilen: allemaal optioneel.
- **Offline, zelfstandig, herstart-vrij** - een WebUI-module met zijn binaries gebundeld; bruikbaar op
  het moment dat hij geflasht is.

## AI-agents

Dit project verwelkomt AI- en agent-bijdragers. De engine spreekt JSON over een klein headless
contract (`scripts/helper.sh <verb> <base64(JSON)>`), gedocumenteerd in
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), zodat een agent elke actie kan aansturen die de WebUI kan -
scrape de WebUI niet. Patches van AI worden aan dezelfde reviewlat gehouden als alle andere.

## Installeren

Flash de zip in KernelSU, APatch of Magisk en open de VDInstaller-WebUI vanuit je root-manager. De
installer houdt alleen de ABI van je apparaat en draait de verplichte `.sha256`-integriteitsgate
(breekt af bij een beschadigde of afgekapte zip). Android 8.0 (API 26) of nieuwer.

## Beveiliging

VDInstaller draait als root en installeert APK's die jij kiest; de pakketverificatie uitzetten voor
een installatie schakelt een malwarescan uit, dus installeer alleen APK's die je vertrouwt. Het
verzwakt de apparaatbeveiliging nooit stilletjes: de verificatie wordt standaard exact in zijn vorige
staat hersteld, en het raakt je HMA-OSS-configuratie nooit aan. Meld problemen volgens
[SECURITY.md](SECURITY.md).

## Bouwen

Altijd release, nooit debug. `.github/scripts/build_bin.sh` haalt `jq` op uit de Termux apt-repository
(met zijn gedeelde-bibliotheeksluiting) en de standalone `abx2xml` / `xml2abx`-converters, voor alle
vier ABI's, elk met een `PROVENANCE.json`. De release-workflow stelt de flashbare zips samen, schrijft
`.sha256`-begeleiders, vult `update.json` en publiceert als `github-actions[bot]`.

## Documentatie

Gidsen staan in [docs/](docs/) en spiegelen naar de GitHub-wiki. Zie
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) voor het headless contract.

## Zie ook

- [VDBackup](https://github.com/VD171/VD-Backup) - volledige app- en data-back-up & herstel, als root.
- [VDInfos](https://github.com/VD171/VD-Infos) - lees elke apparaatinfo met elke methode, en vergelijk.
- [VDGoogle](https://github.com/VD171/VDGoogle) - lees RCS, Wallet en attestaties als root.
- [COPG-VD](https://github.com/VD171/COPG-VD) - Pixel-fingerprint- en props-module.

## Contacten

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

## Licentie

VDInstaller is gelicentieerd onder de GNU AGPL-3.0-or-later. Zie [LICENSE](LICENSE). NETWORK COPYLEFT:
draai een gewijzigde versie, zelfs als een service, en je moet de bron ervan aanbieden.

## Handelsmerken

Android, KernelSU, APatch, Magisk, Google Play en Play Protect behoren toe aan hun respectieve
eigenaren. Dit project is onafhankelijk en niet verbonden met of onderschreven door hen.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Word lid van het kanaal: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
