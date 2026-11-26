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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · Svenska · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# AI-agenter: det huvudlösa kontraktet

VDInstaller styrs av ett enda skalkontrakt. En agent (som körs som root, precis som WebUI) anropar:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

och läser exakt ett JSON-objekt på stdout. Framgång är `{"ok":true,...}`, fel är
`{"ok":false,"code":"ERR_...","message":"..."}`. Långa operationer returnerar ett `opid` som du
pollar. Skrapa inte WebUI, använd det här kontraktet.

## Verb

| Verb | Argument (JSON) | Returnerar |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | config-objektet |
| `config-set` | valfria config-nycklar att slå samman | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (frikopplad) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (frikopplad) |
| `progress` | base64 av opid-strängen (inte JSON) | det live förloppsobjektet; `done:true` när klart |
| `cancel` | base64 av opid-strängen | `{cancelled}` |
| `verifier-status` | - | de aktuella verifierarinställningarna |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | rensar inaktuella loggar |

## Installationslägen

| `mode` | tar | betydelse |
|---|---|---|
| `single` | `path` | en `.apk` |
| `batch` | `dir` | en mapp med fristående `.apk`-filer, en installation var |
| `archive` | `path` | ett grupperat delat arkiv (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | en mapp med de lösa delade `.apk`-filerna för en app |

## Alternativ (per operation i argumenten, eller bevarade via `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (sträng), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Förlopp

Polla `progress` med `opid`. Objektet bär `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), ett valfritt `item`, och vid
slutförande `done:true` med ett `result` (single/split), en `results[]`-array (batch), eller ett
`error`.

## Säkerhetsräcken

- Verifierarväxeln och redigeringen av `packages.xml` är reversibla och granskade (`logs/audit.jsonl`).
- `install`/`uninstall` ändrar enhetens tillstånd, bekräfta avsikten innan anrop, som WebUI gör.
- Skrapa eller automatisera aldrig WebUI själv, det här kontraktet är den stödda ytan.

<!-- doc-footer -->

---

> _Denna dokumentation genererades med Claude (Anthropic) och underhålls av VD171. Rättelser och förbättringar välkomnas, se [CONTRIBUTING.md](CONTRIBUTING.md)._
