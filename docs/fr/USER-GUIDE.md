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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · Français · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# Guide d'utilisation de VDInstaller

## Table des matières

1. [Qu'est-ce que VDInstaller](#1-quest-ce-que-vdinstaller)
2. [Prérequis](#2-prérequis)
3. [Installation et première utilisation](#3-installation-et-première-utilisation)
4. [Visite de la WebUI](#4-visite-de-la-webui)
5. [Installer des APK](#5-installer-des-apk)
6. [Options](#6-options)
7. [Piloter VDInstaller depuis un assistant IA](#7-piloter-vdinstaller-depuis-un-assistant-ia)
8. [Dépannage et FAQ](#8-dépannage-et-faq)

## 1. Qu'est-ce que VDInstaller

VDInstaller est un **module WebUI** KernelSU / APatch / Magisk qui installe des APK chargés latéralement
(sideload) en root sans friction : aucune invite "accorder su", aucun terminal et aucune lutte contre le
vérificateur de Play Protect. Il gère les APK uniques, un dossier entier d'un coup et les applis
découpées (split) (`.xapk` / `.apkm` / `.apks` / `.zip` ou fichiers split épars), et il peut présenter la
source d'installation comme la Play Store pour qu'une appli ne paraisse pas chargée latéralement.

## 2. Prérequis

- Android 8.0 ou plus récent (API 26+).
- Une solution root avec prise en charge WebUI : **KernelSU**, **APatch** ou **Magisk**.

## 3. Installation et première utilisation

1. Téléchargez le dernier `VD-Installer-vX.XX-universal.zip` depuis la page
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Flashez-le comme module dans votre gestionnaire de root (*Modules -> Installer depuis le stockage*).
3. VDInstaller s'active **sans redémarrage** - il est autonome (WebUI + binaires intégrés), il n'y a donc
   rien à monter.
4. Ouvrez la WebUI **VDInstaller** depuis la liste des modules de votre gestionnaire de root.

Au flash, l'installateur ne conserve que l'ABI de votre appareil et exécute un contrôle d'intégrité
`.sha256` obligatoire qui **avorte** si le zip est corrompu ou tronqué. Les réglages résident dans
`/data/adb/vdinstaller` et survivent aux mises à jour.

## 4. Visite de la WebUI

Trois onglets :

- **Install** - choisissez un mode, sélectionnez l'APK ou le dossier, installez, suivez la progression en
  direct.
- **Options** - source d'installation, l'interrupteur du vérificateur de Play Protect et les flags
  d'installation. Tout est enregistré automatiquement.
- **About** - version, ce qu'il fait, prérequis, liens et licence.

## 5. Installer des APK

Vous choisissez le mode dans l'onglet **Install**, VDInstaller ne devine jamais.

| Mode | Ce que vous fournissez | Ce qui se passe |
|---|---|---|
| **APK unique** | un fichier `.apk` | une session d'installation, une appli. |
| **Dossier d'APK** (batch) | un dossier de fichiers `.apk` indépendants | chaque APK est installé seul, l'un après l'autre ; un batch partiel indique lesquels ont échoué et pourquoi. |
| **Archive split** | un `.xapk` / `.apkm` / `.apks` / `.zip` | extrait, puis `base.apk` + les splits installés comme une appli en une seule session (l'OBB du XAPK est aussi placé, lorsqu'il est présent). |
| **Dossier split** | un dossier avec les fichiers `.apk` split épars d'une appli | les splits installés comme une appli en une seule session. |

Une appli "split" est un APK divisé en une base plus des APK de configuration par densité / par ABI / par
langue, ils doivent être installés **ensemble** en une seule session, ce que font pour vous les modes
Split.

### 5.1 La boîte de dialogue Browse

**Browse** ouvre un sélecteur de fichiers qui liste les dossiers et les fichiers installables à un
chemin :

- Touchez un **dossier** pour y entrer, **Up** remonte au parent.
- Dans un mode fichier (APK unique / Archive split), touchez un **fichier** pour le sélectionner.
- Dans un mode dossier (Dossier d'APK / Dossier split), naviguez dans le dossier et touchez **Use this folder**.

Vous pouvez aussi saisir ou coller un chemin directement (par exemple `/sdcard/Download/app.apk`).

### 5.2 Progression, annuler, reprendre

Les installations s'exécutent comme un **processus root détaché**. Une carte de progression affiche la
phase, **Cancel** l'arrête. Si vous fermez la WebUI en pleine installation, celle-ci continue et
l'interface se rattache par id d'opération quand vous la rouvrez.

## 6. Options

Tout ici est enregistré automatiquement et s'applique à la prochaine installation.

### 6.1 Source d'installation

Une appli fraîchement chargée latéralement annonce à chaque appli qui la lit (et à l'attestation)
qu'elle a été chargée latéralement. VDInstaller peut présenter la source comme la Play Store à la place.

- **Afficher la Play Store comme installateur** (activé par défaut) - définit `installerPackageName`
  via `pm install-create -i com.android.vending`. S'applique immédiatement.
- **Falsifier aussi l'initiateur** (activé par défaut) - définit `installInitiator` et `packageSource`
  en éditant `/data/system/packages.xml`. C'est **compatible ABX** (décoder -> éditer -> ré-encoder, avec
  une sauvegarde identique à l'octet près et un échange atomique) et s'applique **après le prochain
  redémarrage**, car le gestionnaire de paquets met `packages.xml` en cache.

### 6.2 Vérificateur de paquets de Play Protect

Une installation chargée latéralement peut être rejetée avec `INSTALL_FAILED_VERIFICATION_FAILURE` par
le vérificateur de paquets de Play Protect. Un interrupteur à 3 positions :

- **Garder tel quel** (par défaut) - désactivé uniquement pour l'installation, puis restauré à son état
  **exact** antérieur (supprimé de nouveau s'il n'y avait pas de valeur explicite, car un `0`/`1` là où
  il n'y en avait aucune est en soi un indice sur un appareil furtif).
- **Toujours activé** - forcez-le activé et conservez-le.
- **Toujours désactivé** - forcez-le désactivé et conservez-le. La WebUI avertit : le laisser désactivé
  est un indice de furtivité et désactive une analyse de malware à chaque installation.

### 6.3 Developer Verification

La Developer Verification 2026 d'Android bloque l'installation d'applis de développeurs non enregistrés
sur les appareils certifiés, mais elle est appliquée par un **service distinct**, pas par Play Protect,
et une **installation root en est déjà exemptée** (la même exemption dont bénéficient les installations
ADB). VDInstaller installe vos APK quoi qu'il arrive, donc cet interrupteur est **au mieux possible et
honnête** : il applique un vrai réglage seulement s'il en existe un et ne prétend jamais actionner un
interrupteur qui ne fait rien.

### 6.4 Flags d'installation

| Flag | Effet |
|---|---|
| **Accorder toutes les permissions d'exécution** | accorde chaque permission d'exécution à l'installation (`-g`). |
| **Autoriser les paquets de test** | installe les paquets marqués test-only (`-t`). |
| **Contourner le blocage targetSdk bas** | installe des applis avec un `targetSdk` très ancien. |
| **Utilisateur cible** | l'id d'utilisateur Android pour lequel installer (par défaut `0`). |

### 6.5 Rester caché

Pour la furtivité, envisagez de masquer votre gestionnaire de root et les applis sensibles avec HMA-OSS.
VDInstaller **ne touche jamais à votre configuration HMA-OSS** - l'indication n'est qu'un rappel, vous
faites le changement vous-même dans HMA-OSS.

## 7. Piloter VDInstaller depuis un assistant IA

Le moteur parle un petit contrat JSON via `scripts/helper.sh`, de sorte qu'un agent peut piloter chaque
action que la WebUI peut faire. Voir [AI-AGENTS](AI-AGENTS). Pilotez le contrat, ne scrapez pas la WebUI.

## 8. Dépannage et FAQ

**J'obtiens `INSTALL_FAILED_VERIFICATION_FAILURE`.** C'est le vérificateur de paquets de Play Protect.
Avec l'interrupteur du vérificateur laissé sur **Garder tel quel** (le défaut), VDInstaller le désactive
pour l'installation et le restaure, donc cela n'arrive pas.

**J'ai activé la source Play Store mais l'appli paraît encore chargée latéralement.** La partie
installateur s'applique immédiatement, la partie initiateur (`packages.xml`) s'applique **après le
prochain redémarrage**.

**Est-ce qu'il contourne la Developer Verification de Google ?** Il n'en a pas besoin - une installation
root en est exemptée (voir 6.3). Il n'y a aucun faux interrupteur pour elle.

**A-t-il besoin d'un redémarrage ?** Non, sauf la falsification facultative de l'initiateur.

**Désinstaller VDInstaller supprimera-t-il les applis que j'ai installées ?** Non - ce sont de vraies
installations possédées par le système, retirer le module ne nettoie que l'état propre de VDInstaller.

**Est-ce sûr ?** Il installe les APK que vous choisissez et, avec le vérificateur désactivé, saute une
analyse de malware - n'installez que des APK de confiance. Il n'affaiblit jamais rien en silence.

<!-- doc-footer -->

---

> _Cette documentation a été générée avec Claude (Anthropic) et est maintenue par VD171. Les corrections et améliorations sont les bienvenues, voir [CONTRIBUTING.md](CONTRIBUTING.md)._
