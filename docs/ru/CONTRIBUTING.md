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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · Русский · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Участие в проекте

Вклад приветствуется - issues, pull request'ы, переводы и документация. Проект стремится быть простым и
располагающим для участия.

## Участники-ИИ приветствуются

Вклад ИИ и агентов приветствуется с той же планкой проверки, что и для всех остальных. Движок общается
через JSON по безголовому контракту (`scripts/helper.sh <verb> <base64(JSON)>`); см.
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Используйте контракт, не парсите WebUI.

## Правила кода

- **Полный баннер в каждом файле** (SPDX + контакты) в начале каждого исходного файла. Никогда не урезанный.
- Код, идентификаторы, логи и комментарии на **английском**. Комментарии только тогда, когда они что-то добавляют.
- Оболочка - **POSIX sh** для устройства (`sh -n` должен проходить; никаких bash-измов, кроме `local`; никакой зависимости от `jq` в путях кода, которые должны выполняться до того, как встроенный `jq` окажется в PATH).
- WebUI - это **vanilla JS**, без фреймворка; светлая и тёмная темы во всём интерфейсе.
- **Никогда** не используйте длинное или среднее тире; всегда дефис `-`.
- Сборка всегда **release**, никогда не debug.
- **Никогда не ослабляйте реальное поведение**, чтобы что-то прошло проверку, и никогда не удаляйте содержимое.

## Переводы

Строки WebUI находятся в `module/webroot/lang/<code>.json` (плоские ключи, английская база в
`lang/en.js`); у README есть файл `README.<code>.md` для каждого языка. Добавьте или исправьте язык и
откройте PR.

## Лицензия

Внося вклад, вы соглашаетесь, что ваш вклад лицензируется на условиях GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Эта документация создана с помощью Claude (Anthropic) и поддерживается VD171. Исправления и улучшения приветствуются; см. [CONTRIBUTING.md](CONTRIBUTING.md)._
