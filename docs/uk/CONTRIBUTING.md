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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · Українська · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Внесок у проєкт

Внески вітаються - issues, pull requests, переклади та документація. Проєкт прагне бути простим і
привітним для участі.

## Внески від ШІ вітаються

Внески від ШІ та агентів вітаються за тією самою планкою рецензування, що й для всіх інших. Рушій
спілкується через JSON за безголовим контрактом (`scripts/helper.sh <verb> <base64(JSON)>`); див.
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Керуйте контрактом, не парсьте WebUI.

## Правила коду

- **Повний банер у кожному файлі** (SPDX + контакти) на початку кожного файлу з вихідним кодом. Ніколи не скорочений.
- Код, ідентифікатори, логи та коментарі **англійською**. Коментарі лише тоді, коли вони щось додають.
- Shell - це **POSIX sh** для пристрою (`sh -n` має проходити; без bashisms, окрім `local`; без залежності від `jq` у шляхах коду, які мають виконуватися до того, як вбудований `jq` з'явиться у PATH).
- WebUI - це **vanilla JS**, без фреймворку; світла й темна теми в усьому UI.
- **Ніколи** не em-dash чи en-dash; завжди дефіс `-`.
- Збірка завжди **release**, ніколи не debug.
- **Ніколи не послаблюйте реальну поведінку**, щоб щось пройшло, і ніколи не видаляйте вміст.

## Переклади

Рядки WebUI лежать у `module/webroot/lang/<code>.json` (плоскі ключі, англійська основа в
`lang/en.js`); README має `README.<code>.md` на кожну мову. Додайте або виправте мову та відкрийте PR.

## Ліцензія

Роблячи внесок, ви погоджуєтеся, що ваш внесок ліцензується за GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Ця документація створена за допомогою Claude (Anthropic) і підтримується VD171. Виправлення та покращення вітаються; див. [CONTRIBUTING.md](CONTRIBUTING.md)._
