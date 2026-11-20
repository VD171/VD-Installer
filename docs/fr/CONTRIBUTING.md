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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · Français · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Contribuer

Les contributions sont les bienvenues - tickets, pull requests, traductions et documentation. Le projet vise
a etre simple et accueillant pour contribuer.

## Contributeurs IA bienvenus

Les contributions de l'IA et des agents sont les bienvenues au meme niveau d'exigence de revue que pour tout
le monde. Le moteur parle JSON via un contrat headless (`scripts/helper.sh <verb> <base64(JSON)>`); voir
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Utilisez le contrat, ne faites pas de scraping de la WebUI.

## Regles de code

- **Banniere complete par fichier** (SPDX + contacts) en haut de chaque fichier source. Jamais une version tronquee.
- Code, identifiants, logs et commentaires en **anglais**. Des commentaires seulement quand ils apportent quelque chose.
- Le shell est du **POSIX sh** pour l'appareil (`sh -n` doit passer; pas de bashismes au-dela de `local`; pas de dependance a `jq` dans les chemins de code qui doivent s'executer avant que le `jq` embarque soit dans le PATH).
- La WebUI est en **JS pur**, sans framework; theme clair et sombre dans toute l'interface.
- **Jamais** de tiret cadratin ni demi-cadratin; toujours un trait d'union `-`.
- La compilation est toujours en **release**, jamais en debug.
- **Ne jamais affaiblir un comportement reel** pour faire passer quelque chose, et ne jamais supprimer de contenu.

## Traductions

Les chaines de la WebUI se trouvent dans `module/webroot/lang/<code>.json` (cles plates, base anglaise dans
`lang/en.js`); le README a un `README.<code>.md` par langue. Ajoutez ou corrigez une langue et ouvrez une PR.

## Licence

En contribuant, vous acceptez que votre contribution soit sous licence GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Cette documentation a été générée avec Claude (Anthropic) et est maintenue par VD171. Les corrections et améliorations sont les bienvenues ; voir [CONTRIBUTING.md](CONTRIBUTING.md)._
