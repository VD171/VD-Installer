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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · Русский · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# ИИ-агенты: безголовый контракт

VDInstaller управляется одним контрактом оболочки. Агент (работающий с правами root, как и WebUI)
вызывает:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

и читает ровно один объект JSON в stdout. Успех - это `{"ok":true,...}`, неудача -
`{"ok":false,"code":"ERR_...","message":"..."}`. Длинные операции возвращают `opid`, который вы
опрашиваете. Не парсите WebUI, используйте этот контракт.

## Глаголы

| Глагол | Аргументы (JSON) | Возвращает |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | объект конфигурации |
| `config-set` | любые ключи конфигурации для слияния | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (отсоединённый) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (отсоединённый) |
| `progress` | base64 строки opid (не JSON) | живой объект прогресса; `done:true` по завершении |
| `cancel` | base64 строки opid | `{cancelled}` |
| `verifier-status` | - | текущие настройки верификатора |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | очищает устаревшие логи |

## Режимы установки

| `mode` | принимает | значение |
|---|---|---|
| `single` | `path` | один `.apk` |
| `batch` | `dir` | папка независимых файлов `.apk`, по одной установке каждый |
| `archive` | `path` | сгруппированный архив split (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | папка с отдельными файлами `.apk` split-частей одного приложения |

## Параметры (на операцию в аргументах или сохранённые через `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Прогресс

Опрашивайте `progress` с `opid`. Объект несёт `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), необязательный `item`, а по
завершении `done:true` с `result` (single/split), массивом `results[]` (batch) или `error`.

## Защитные ограничения

- Переключатель верификатора и правка `packages.xml` обратимы и фиксируются в аудите (`logs/audit.jsonl`).
- `install`/`uninstall` меняют состояние устройства, подтвердите намерение перед вызовом, как это делает
  WebUI.
- Никогда не парсите и не автоматизируйте сам WebUI, этот контракт - поддерживаемая поверхность.

<!-- doc-footer -->

---

> _Эта документация создана с помощью Claude (Anthropic) и поддерживается VD171. Исправления и улучшения приветствуются, см. [CONTRIBUTING.md](CONTRIBUTING.md)._
