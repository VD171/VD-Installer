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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · Italiano · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# Agenti IA: il contratto headless

VDInstaller è pilotato da un unico contratto shell. Un agente (in esecuzione come root, come fa la WebUI)
chiama:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

e legge esattamente un oggetto JSON su stdout. Il successo è `{"ok":true,...}`; il fallimento è
`{"ok":false,"code":"ERR_...","message":"..."}`. Le operazioni lunghe restituiscono un `opid` che interroghi.
Non fare scraping della WebUI; usa questo contratto.

## Verbi

| Verbo | Argomenti (JSON) | Restituisce |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | l'oggetto di configurazione |
| `config-set` | qualsiasi chiave di configurazione da unire | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (distaccato) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (distaccato) |
| `progress` | base64 della stringa opid (non JSON) | l'oggetto di avanzamento dal vivo; `done:true` al termine |
| `cancel` | base64 della stringa opid | `{cancelled}` |
| `verifier-status` | - | le impostazioni correnti del verificatore |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | elimina i log obsoleti |

## Modalità di installazione

| `mode` | prende | significato |
|---|---|---|
| `single` | `path` | un `.apk` |
| `batch` | `dir` | una cartella di file `.apk` indipendenti, un'installazione ciascuno |
| `archive` | `path` | un archivio diviso raggruppato (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | una cartella con i file `.apk` di split sciolti di una stessa app |

## Opzioni (per operazione negli argomenti, o persistite via `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Avanzamento

Interroga `progress` con l'`opid`. L'oggetto porta `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), un `item` opzionale e al
completamento `done:true` con un `result` (single/split), un array `results[]` (batch) o un `error`.

## Protezioni di sicurezza

- L'interruttore del verificatore e la modifica di `packages.xml` sono reversibili e verificati
  (`logs/audit.jsonl`).
- `install`/`uninstall` modificano lo stato del dispositivo; conferma l'intenzione prima di chiamarli, come
  fa la WebUI.
- Non fare mai scraping o automazione della WebUI stessa; questo contratto è la superficie supportata.

<!-- doc-footer -->

---

> _Questa documentazione è stata generata con Claude (Anthropic) ed è gestita da VD171. Correzioni e miglioramenti sono benvenuti; vedi [CONTRIBUTING.md](CONTRIBUTING.md)._
