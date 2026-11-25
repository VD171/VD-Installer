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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · Français · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Installateur de sideload root sans friction - KernelSU / APatch / Magisk WebUI.

## Pourquoi

Installer un APK par sideload sur un telephone roote est plus bruyant que necessaire : le verificateur
de paquets de Play Protect peut renvoyer `INSTALL_FAILED_VERIFICATION_FAILURE`, les applis divisees
(`.xapk` / `.apkm` / `.apks`) exigent la session API a la main, et une appli fraichement installee
s'annonce comme "sideloaded" a toute appli qui lit sa source d'installation. VDInstaller fait tout cela
pour vous, deja en root, sans aucune invite "accorder su" ni terminal.

## Fonctionnalites

- **Toutes les formes d'APK** - un seul `.apk`, un dossier entier d'APK independants (batch), une
  archive divisee groupee (`.xapk` / `.apkm` / `.apks` / `.zip`), ou un dossier d'APK divises en vrac.
- **Pas de mur de verification** - une bascule a 3 etats pour le verificateur de paquets de Play
  Protect : le garder tel quel (desactive seulement pendant l'installation, restaure a l'identique),
  toujours actif, ou toujours inactif.
- **Honnete sur la Verification Developpeur** - une installation en root est deja exemptee de la
  Developer Verification d'Android de 2026 ; la bascule fait au mieux et le dit, jamais un faux
  interrupteur.
- **Pas "sideloaded"** - presente en option la source d'installation comme le Play Store, a la fois
  l'installateur (au moment de l'installation) et l'initiateur (via une edition de `packages.xml`
  consciente d'ABX).
- **Detache et reprenable** - les installations tournent comme un processus root detache ; fermer la
  WebUI ne les interrompt jamais, et l'interface se rattache par identifiant d'operation.
- **A vous de choisir** - paquets de test, accorder toutes les permissions runtime,
  utilisateur cible, contourner le blocage de target SDK bas : tout est optionnel.
- **Hors ligne, autonome, sans redemarrage** - un module WebUI avec ses binaires inclus ; utilisable
  des qu'il est flashe.

## Agents d'IA

Ce projet accueille les contributeurs IA et les agents. Le moteur parle JSON via un petit contrat
headless (`scripts/helper.sh <verb> <base64(JSON)>`), documente dans
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), afin qu'un agent puisse piloter chaque action que la WebUI
peut faire - ne scrapez pas la WebUI. Les correctifs issus d'IA sont tenus au meme niveau de revue que
tout autre.

## Installation

Flashez le zip dans KernelSU, APatch ou Magisk et ouvrez la WebUI de VDInstaller depuis votre
gestionnaire de root. L'installateur ne conserve que l'ABI de votre appareil et execute le controle
d'integrite `.sha256` obligatoire (abandonne en cas de zip corrompu ou tronque). Android 8.0 (API 26)
ou plus recent.

## Securite

VDInstaller tourne en root et installe les APK que vous choisissez ; desactiver le verificateur de
paquets pour une installation desactive une analyse de malware, alors n'installez que des APK de
confiance. Il n'affaiblit jamais la securite de l'appareil en silence : par defaut, le verificateur est
restaure a son etat anterieur exact, et il ne touche jamais a votre configuration HMA-OSS. Signalez les
problemes selon [SECURITY.md](SECURITY.md).

## Compilation

Toujours release, jamais debug. `.github/scripts/build_bin.sh` recupere `jq` depuis le depot apt de
Termux (avec sa cloture de bibliotheques partagees) et les convertisseurs autonomes `abx2xml` /
`xml2abx`, pour les quatre ABI, chacun avec un `PROVENANCE.json`. Le workflow de release assemble les
zips flashables, ecrit les compagnons `.sha256`, remplit `update.json` et publie en tant que
`github-actions[bot]`.

## Documentation

Les guides se trouvent dans [docs/](docs/) et sont repliques vers le wiki GitHub. Voir
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) pour le contrat headless.

## Voir aussi

- **[COPG-VD](https://github.com/VD171/COPG-VD)** : spoofing global de l'empreinte de l'appareil / Play Integrity, sur tout l'appareil avec une portée par application et une WebUI.
- **[VDBackup](https://github.com/VD171/VD-Backup)** : sauvegarde et restauration complètes des applications et des données en root, pilotées entièrement depuis une WebUI.
- **[VD-dropbear](https://github.com/VD171/VD-dropbear)** : un démon SSH autonome avec les droits root (Dropbear).
- **[VDGoogle](https://github.com/VD171/VD-Google)** : vos services Google (RCS, Wallet, attestations Play Integrity), lus sur votre appareil sans internet.
- **[VDInfos](https://github.com/VD171/VD-Infos)** : un débogueur de méthodes de l'appareil qui lit chaque élément via toutes les méthodes capables de le lire et les compare côte à côte.
- **[VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)** : un moteur d'auto-mise à jour incrémentale et sans flashage, intégré aux modules KernelSU/APatch/Magisk.
- **[VD-Modules](https://github.com/VD171/VD-Modules)** : notre dépôt de modules MMRL/WebUI-X (installez-les tous depuis votre gestionnaire root).
- **[@VictorGabriel7Dev/build.prop](https://github.com/VictorGabriel7Dev/build.prop)** : un jeu de données d'empreintes `build.prop` de Pixel (fork de @T3SL4).
- **[@VictorGabriel7Dev/mtproto-store](https://github.com/VictorGabriel7Dev/mtproto-store)** : utilisez Telegram comme object store depuis une petite CLI Go.

## Contacts

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/VD-Installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## Licence

VDInstaller est sous licence GNU AGPL-3.0-or-later. Voir [LICENSE](LICENSE). NETWORK COPYLEFT : si vous
executez une version modifiee, meme en tant que service, vous devez en offrir le code source.

## Marques

Android, KernelSU, APatch, Magisk, Google Play et Play Protect appartiennent a leurs proprietaires
respectifs. Ce projet est independant et n'est ni affilie a eux ni approuve par eux.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Rejoignez le canal : [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
