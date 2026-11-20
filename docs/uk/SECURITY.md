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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · Українська · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# Політика безпеки

## Модель загроз в одному рядку

VDInstaller працює як root і встановлює APK, які користувач явно обирає; вимкнення верифікатора Play
Protect на час встановлення відключає сканування на шкідливе ПЗ, тож це "встановлення без тертя", а не
"безпечне встановлення" - встановлюйте лише ті APK, яким ви довіряєте.

## Що він робить і чого не робить

- За замовчуванням він відновлює верифікатор пакетів до його точного попереднього стану (залишити `0`/`1`
  там, де не було нічого, саме по собі є ознакою, тож його знову видаляють).
- Він ніколи не чіпає ваше налаштування HMA-OSS; приховування застосунків - це рекомендація, за якою ви дієте самі.
- Редагування джерела встановлення в `packages.xml` враховує ABX, робить побайтово точну резервну копію
  живого файлу перед будь-якою зміною, виконує round-trip для перевірки та залишає живий файл недоторканим у разі будь-якої невдачі.
- Вбудовані бінарники завантажуються під час збірки з їхнього офіційного upstream і несуть `PROVENANCE.json`.

## Повідомлення про вразливість

Будь ласка, спершу повідомляйте приватно. Включіть кроки для відтворення, уражену версію та вплив.

- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me
- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)

<!-- doc-footer -->

---

> _Ця документація створена за допомогою Claude (Anthropic) і підтримується VD171. Виправлення та покращення вітаються; див. [CONTRIBUTING.md](CONTRIBUTING.md)._
