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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · Français · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Architecture

VDInstaller est une WebUI légère par-dessus un moteur de shell root. Rien dans l'interface n'a de
privilège, chaque action privilégiée est un appel de shell qui renvoie un objet JSON.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI en JS pur (sans framework), clair/sombre, 22 langues. Elle appelle le moteur via
  le pont WebUI de KernelSU (`ksu.exec`) et analyse la réponse JSON.
- **`scripts/common.sh`** - la bibliothèque partagée sourcée par les deux scripts : résolution de
  l'ABI/PATH, les enveloppes `pm`/`dumpsys`/`fw` (environnement propre pour que les libs Termux intégrées
  n'éclipsent jamais celles d'ART), les aides JSON et `jq`, et le `xml_edit` compatible ABX.
- **`scripts/helper.sh`** - le contrat de la WebUI : une ligne JSON par appel. Les verbes courts
  (version, config, browse, scan) s'exécutent en ligne, les longs (install, uninstall) détachent un
  worker et renvoient un `opid`.
- **`scripts/worker.sh`** - le moteur d'installation détaché : les quatre modes d'installation,
  l'interrupteur du vérificateur, la falsification de la source d'installation et l'API de session du
  gestionnaire de paquets. Il écrit la progression dans un fichier que la WebUI interroge, et survit à la
  fermeture de la WebUI (`setsid`, et il échappe au gel des applis).

## Points clés

- **Déjà root.** Aucune invite "accorder su" et aucun basculement de `sucompat`, le moteur s'exécute en
  root depuis le module et appelle `pm` / `settings` directement.
- **Installations par session.** Tous les modes utilisent `pm install-create` / `install-write` /
  `install-commit`, de sorte que les applis split s'installent correctement et la source d'installation
  (`-i`) est définie au moment de la session.
- **Compatible ABX.** La falsification de l'initiateur dans `packages.xml` vérifie le nombre magique de
  XML binaire `ABX\0`, décode, édite, ré-encode, fait un aller-retour pour valider, sauvegarde à l'octet
  près et échange de façon atomique, le fichier en direct n'est jamais touché tant que chaque étape ne
  passe pas.
- **Sans redémarrage.** Un module WebUI autonome sans rien à monter : `customize.sh` le copie dans le
  répertoire des modules actifs pour qu'il fonctionne dès qu'il est flashé.
- **Mises à jour sans flash.** Le moteur **VDLU** intégré met à jour le module en ne téléchargeant que
  les fichiers modifiés, adressés par contenu et signés ed25519 - sans reflash complet.
- **Détaché.** Les opérations longues s'exécutent hors de la webview, fermer la WebUI ne les interrompt
  jamais.

## Garantie de compatibilité

- `sh` POSIX sur l'appareil (`sh -n` passe, aucun bashisme au-delà de `local`, aucune dépendance à
  `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` sont les seuls outils du framework utilisés, tous via
  `/system/bin`.
- Les binaires intégrés (`jq`, `abx2xml`/`xml2abx`) sont facultatifs pour le chemin courant et portent
  leur provenance, le convertisseur ABX se rabat sur le `/system/bin/abx2xml` propre à l'appareil
  lorsqu'il est présent.

<!-- doc-footer -->

---

> _Cette documentation a été générée avec Claude (Anthropic) et est maintenue par VD171. Les corrections et améliorations sont les bienvenues, voir [CONTRIBUTING.md](CONTRIBUTING.md)._
