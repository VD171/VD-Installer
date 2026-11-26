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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · Русский · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Архитектура

VDInstaller - это тонкий WebUI поверх движка root-оболочки. Ничто в интерфейсе не имеет привилегий, каждое
привилегированное действие - это один вызов оболочки, который возвращает один объект JSON.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI на чистом JS (без фреймворка), светлая/тёмная тема, 22 языка. Он вызывает движок
  через мост WebUI KernelSU (`ksu.exec`) и разбирает ответ JSON.
- **`scripts/common.sh`** - общая библиотека, подключаемая обоими скриптами: разрешение ABI/PATH, обёртки
  `pm`/`dumpsys`/`fw` (чистое окружение, чтобы встроенные библиотеки Termux никогда не заслоняли
  библиотеки ART), помощники JSON и `jq`, а также `xml_edit` с учётом ABX.
- **`scripts/helper.sh`** - контракт WebUI: одна строка JSON на вызов. Короткие глаголы (version, config,
  browse, scan) выполняются встроенно, длинные (install, uninstall) отсоединяют worker и возвращают
  `opid`.
- **`scripts/worker.sh`** - отсоединённый движок установки: четыре режима установки, переключатель
  верификатора, подмена источника установки и API сессий менеджера пакетов. Он пишет прогресс в файл,
  который опрашивает WebUI, и переживает закрытие WebUI (`setsid`, и ускользает от замораживателя
  приложений).

## Ключевые моменты

- **Уже root.** Нет запроса "предоставить su" и нет переключения `sucompat`, движок работает с правами
  root из модуля и вызывает `pm` / `settings` напрямую.
- **Сессионные установки.** Все режимы используют `pm install-create` / `install-write` /
  `install-commit`, поэтому разделённые приложения устанавливаются корректно, а источник установки (`-i`)
  задаётся во время сессии.
- **С учётом ABX.** Подмена инициатора в `packages.xml` проверяет сигнатуру двоичного XML `ABX\0`,
  декодирует, редактирует, перекодирует, делает цикл туда и обратно для проверки, создаёт побайтово точную
  резервную копию и подменяет атомарно, живой файл никогда не трогается, пока не пройдёт каждый шаг.
- **Без перезагрузки.** Самодостаточный модуль WebUI, которому нечего монтировать: `customize.sh` копирует
  его в каталог активных модулей, поэтому он работает в момент прошивки.
- **Обновления без прошивки.** Встроенный движок **VDLU** обновляет модуль, скачивая только изменённые,
  адресуемые по содержимому, подписанные ed25519 файлы - без полной перепрошивки.
- **Отсоединённый.** Длинные операции выполняются вне webview, закрытие WebUI никогда их не прерывает.

## Гарантия совместимости

- POSIX `sh` на устройстве (`sh -n` проходит, без башизмов, кроме `local`, без зависимости от `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` - единственные используемые инструменты фреймворка, все через
  `/system/bin`.
- Встроенные бинарные файлы (`jq`, `abx2xml`/`xml2abx`) опциональны для обычного пути и несут
  происхождение, конвертер ABX откатывается к собственному `/system/bin/abx2xml` устройства там, где он
  присутствует.

<!-- doc-footer -->

---

> _Эта документация создана с помощью Claude (Anthropic) и поддерживается VD171. Исправления и улучшения приветствуются, см. [CONTRIBUTING.md](CONTRIBUTING.md)._
