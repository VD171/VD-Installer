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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · Українська · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Архітектура

VDInstaller - це тонкий WebUI над рушієм командної оболонки root. Жодна частина інтерфейсу не має
привілеїв, кожна привілейована дія - це один виклик оболонки, що повертає один об'єкт JSON.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI на чистому JS (без фреймворку), світла/темна тема, 22 мови. Він викликає
  рушій через міст WebUI KernelSU (`ksu.exec`) і розбирає відповідь JSON.
- **`scripts/common.sh`** - спільна бібліотека, яку підключають обидва скрипти: розв'язання ABI/PATH,
  обгортки `pm`/`dumpsys`/`fw` (чисте середовище, щоб вбудовані бібліотеки Termux ніколи не затіняли
  бібліотеки ART), помічники JSON та `jq`, а також `xml_edit`, що враховує ABX.
- **`scripts/helper.sh`** - контракт WebUI: один рядок JSON на виклик. Короткі дієслова (version,
  config, browse, scan) виконуються вбудовано, довгі (install, uninstall) від'єднують робітника й
  повертають `opid`.
- **`scripts/worker.sh`** - від'єднаний рушій встановлення: чотири режими встановлення, перемикач
  верифікатора, підробка джерела встановлення та сеансовий API менеджера пакетів. Він пише прогрес у
  файл, який опитує WebUI, і переживає закриття WebUI (`setsid`, а також уникає заморожувача
  застосунків).

## Ключові моменти

- **Уже root.** Жодного запиту "надати su" і жодного перемикання `sucompat`, рушій працює як root із
  модуля й викликає `pm` / `settings` безпосередньо.
- **Сеансові встановлення.** Усі режими використовують `pm install-create` / `install-write` /
  `install-commit`, тож розділені застосунки встановлюються правильно, а джерело встановлення (`-i`)
  задається під час сеансу.
- **Враховує ABX.** Підробка ініціатора в `packages.xml` перевіряє наявність магії двійкового XML
  `ABX\0`, декодує, редагує, перекодовує, робить повний цикл для перевірки, створює побайтово точну
  резервну копію й атомарно замінює, живий файл ніколи не чіпається, доки не пройде кожен крок.
- **Без перезавантаження.** Самодостатній модуль WebUI, який нічого не монтує: `customize.sh` копіює
  його до активної теки модулів, тож він працює тієї ж миті, щойно його прошито.
- **Оновлення без прошивання.** Вбудований рушій **VDLU** оновлює модуль, завантажуючи лише змінені,
  адресовані за вмістом, підписані ed25519 файли - без повної переприйшивки.
- **Від'єднано.** Довгі операції виконуються поза webview, закриття WebUI ніколи їх не перериває.

## Гарантія сумісності

- POSIX `sh` на пристрої (`sh -n` проходить, жодних bashism-ів, окрім `local`, жодної залежності від
  `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` - єдині використовувані інструменти фреймворку, усі через
  `/system/bin`.
- Вбудовані бінарники (`jq`, `abx2xml`/`xml2abx`) необов'язкові для звичайного шляху й несуть
  походження, конвертер ABX вдається до власного `/system/bin/abx2xml` пристрою, де той присутній.

<!-- doc-footer -->

---

> _Ця документація створена за допомогою Claude (Anthropic) і підтримується VD171. Виправлення та покращення вітаються, див. [CONTRIBUTING.md](CONTRIBUTING.md)._
