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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · Français · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Binaires intégrés : provenance et audit

## Principes

- Rien d'opaque n'est livré. Chaque binaire intégré est récupéré au **moment de la compilation depuis son
  upstream officiel**, jamais extrait d'un appareil, et chaque fichier porte un sha256 pour que la charge
  puisse être reproduite.
- Les binaires sont intégrés pour les **quatre ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`) ;
  l'installateur de flash les élague vers la seule de l'appareil.
- Ils s'exécutent de façon autonome : la fermeture de bibliothèques partagées de chaque binaire est
  livrée à côté et le moteur règle `LD_LIBRARY_PATH` sur le `lib/` intégré, il n'y a donc aucune
  dépendance à ce que Termux soit installé.

## Ce qui est livré, et d'où

| Binaire | De | Pourquoi |
|---|---|---|
| `jq` (+ `lib/`) | le dépôt de paquets Termux (`packages.termux.dev/apt`), `.deb` officiel | le moteur parle JSON ; `jq` analyse les args et construit les réponses. |
| `abx2xml` / `xml2abx` | release de [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | décoder/encoder le XML binaire Android (ABX) pour la falsification de la source d'installation dans `packages.xml`, là où l'appareil n'a pas `/system/bin/abx2xml` (avant A12). Le convertisseur propre à l'appareil est préféré lorsqu'il est présent. |
| `vdlu/verify/<abi>/ed25519-mini` | le moteur canonique [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | vérifier la signature ed25519 des mises à jour sans flash (VDLU), sans OpenSSL. |

L'étape de compilation est `.github/scripts/build_bin.sh` : elle résout le paquet Termux plus ses
dépendances transitives, extrait les `.deb`, copie les binaires voulus et la fermeture de bibliothèques
partagées dont chacun a besoin (résolue avec `readelf`), puis récupère le convertisseur ABX autonome.

## Le manifeste sur l'appareil : `PROVENANCE.json`

Chaque `bin/<abi>/` porte un `PROVENANCE.json` qui liste chaque fichier livré (chemin, taille, sha256) et
la source upstream de chacun (paquet, version, URL, sha256 de l'archive). Il survit à l'élagage d'ABI sur
l'appareil, de sorte que la piste d'audit est livrée avec le module lui-même.

## Comment vérifier

1. Ouvrez `bin/<abi>/PROVENANCE.json` sur l'appareil ou dans le zip flashable.
2. Récupérez à nouveau chaque source épinglée depuis l'URL qu'elle enregistre.
3. Extrayez et comparez le sha256 de chaque fichier au manifeste.

Le zip flashable porte en plus un compagnon `.sha256` à côté de chaque fichier livré ; `customize.sh` les
vérifie au moment du flash et **avorte** à la moindre divergence (un zip corrompu ou tronqué).

## Signalement

Vous avez trouvé une divergence ou une préoccupation de provenance ? Signalez-la en privé - voir
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Cette documentation a été générée avec Claude (Anthropic) et est maintenue par VD171. Les corrections et améliorations sont les bienvenues ; voir [CONTRIBUTING.md](CONTRIBUTING.md)._
