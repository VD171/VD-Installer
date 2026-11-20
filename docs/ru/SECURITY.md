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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · Русский · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# Политика безопасности

## Модель угроз в одну строку

VDInstaller работает с правами root и устанавливает APK, которые пользователь выбирает явно; отключение
верификатора Play Protect на время установки отключает проверку на вредоносное ПО, поэтому это
"установка без трения", а не "безопасная установка" - устанавливайте только те APK, которым вы доверяете.

## Что он делает и чего не делает

- По умолчанию он восстанавливает верификатор пакетов в точно прежнее состояние (оставить `0`/`1` там,
  где его не было, само по себе выдаёт, поэтому значение снова удаляется).
- Он никогда не затрагивает вашу настройку HMA-OSS; скрытие приложений - это рекомендация, которую вы выполняете сами.
- Редактирование источника установки в `packages.xml` учитывает ABX, создаёт побайтовую резервную копию
  активного файла перед любым изменением, выполняет полный цикл для проверки и оставляет активный файл
  нетронутым при любой ошибке.
- Встроенные бинарные файлы загружаются при сборке из их официального upstream и содержат `PROVENANCE.json`.

## Сообщение об уязвимости

Пожалуйста, сначала сообщите приватно. Укажите шаги для воспроизведения, затронутую версию и влияние.

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

> _Эта документация создана с помощью Claude (Anthropic) и поддерживается VD171. Исправления и улучшения приветствуются; см. [CONTRIBUTING.md](CONTRIBUTING.md)._
