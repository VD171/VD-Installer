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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · Українська · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# ШІ-агенти: безголовий контракт

VDInstaller керується одним контрактом оболонки. Агент (що працює як root, як і WebUI) викликає:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

і читає рівно один об'єкт JSON у stdout. Успіх - це `{"ok":true,...}`, невдача -
`{"ok":false,"code":"ERR_...","message":"..."}`. Довгі операції повертають `opid`, який ви опитуєте.
Не скрапте WebUI, користуйтеся цим контрактом.

## Дієслова

| Дієслово | Аргументи (JSON) | Повертає |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | об'єкт конфігурації |
| `config-set` | будь-які ключі конфігурації для злиття | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (від'єднано) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (від'єднано) |
| `progress` | base64 рядка opid (не JSON) | живий об'єкт прогресу; `done:true` після завершення |
| `cancel` | base64 рядка opid | `{cancelled}` |
| `verifier-status` | - | поточні налаштування верифікатора |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | очищує застарілі журнали |

## Режими встановлення

| `mode` | бере | значення |
|---|---|---|
| `single` | `path` | один `.apk` |
| `batch` | `dir` | тека з незалежними файлами `.apk`, одне встановлення кожного |
| `archive` | `path` | згрупований розділений архів (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | тека з окремими файлами-частинами `.apk` одного застосунку |

## Параметри (на операцію в аргументах або збережені через `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Прогрес

Опитуйте `progress` за допомогою `opid`. Об'єкт несе `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), необов'язковий `item`, а після
завершення `done:true` з `result` (single/split), масивом `results[]` (batch) або `error`.

## Запобіжники

- Перемикач верифікатора та редагування `packages.xml` оборотні й аудитовані (`logs/audit.jsonl`).
- `install`/`uninstall` змінюють стан пристрою, підтвердьте намір перед викликом, як це робить WebUI.
- Ніколи не скрапте й не автоматизуйте сам WebUI, цей контракт - підтримувана поверхня.

<!-- doc-footer -->

---

> _Ця документація створена за допомогою Claude (Anthropic) і підтримується VD171. Виправлення та покращення вітаються, див. [CONTRIBUTING.md](CONTRIBUTING.md)._
