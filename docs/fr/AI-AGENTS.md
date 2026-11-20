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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · Français · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# Agents IA : le contrat sans interface

VDInstaller est piloté par un seul contrat de shell. Un agent (s'exécutant en root, comme le fait la
WebUI) appelle :

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

et lit exactement un objet JSON sur stdout. Le succès est `{"ok":true,...}` ; l'échec est
`{"ok":false,"code":"ERR_...","message":"..."}`. Les opérations longues renvoient un `opid` que vous
interrogez. Ne scrapez pas la WebUI ; utilisez ce contrat.

## Verbes

| Verbe | Args (JSON) | Renvoie |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | l'objet de configuration |
| `config-set` | toute clé de config à fusionner | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (détaché) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (détaché) |
| `progress` | base64 de la chaîne opid (pas du JSON) | l'objet de progression en direct ; `done:true` une fois terminé |
| `cancel` | base64 de la chaîne opid | `{cancelled}` |
| `verifier-status` | - | les réglages actuels du vérificateur |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | élague les logs obsolètes |

## Modes d'installation

| `mode` | prend | signification |
|---|---|---|
| `single` | `path` | un `.apk` |
| `batch` | `dir` | un dossier de fichiers `.apk` indépendants, une installation chacun |
| `archive` | `path` | une archive split groupée (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | un dossier avec les fichiers `.apk` split épars d'une appli |

## Options (par opération dans les args, ou persistées via `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Progression

Interrogez `progress` avec le `opid`. L'objet porte `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), un `item` facultatif, et à
l'achèvement `done:true` avec un `result` (single/split), un tableau `results[]` (batch), ou une `error`.

## Garde-fous de sécurité

- L'interrupteur du vérificateur et l'édition de `packages.xml` sont réversibles et audités
  (`logs/audit.jsonl`).
- `install`/`uninstall` modifient l'état de l'appareil ; confirmez l'intention avant d'appeler, comme le
  fait la WebUI.
- Ne scrapez ni n'automatisez jamais la WebUI elle-même ; ce contrat est la surface prise en charge.

<!-- doc-footer -->

---

> _Cette documentation a été générée avec Claude (Anthropic) et est maintenue par VD171. Les corrections et améliorations sont les bienvenues ; voir [CONTRIBUTING.md](CONTRIBUTING.md)._
