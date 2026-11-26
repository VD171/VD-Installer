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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · Українська · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Вбудовані бінарники: походження та аудит

## Принципи

- Нічого непрозорого не постачається. Кожен вбудований бінарник отримується **під час збирання з його
  офіційного upstream**, ніколи не витягується з пристрою, і кожен файл несе sha256, щоб корисне
  навантаження можна було відтворити.
- Бінарники вбудовуються для **всіх чотирьох ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`);
  інсталятор прошивання обрізає до одного ABI пристрою.
- Вони працюють автономно: замикання спільних бібліотек кожного бінарника постачається поруч, а рушій
  задає `LD_LIBRARY_PATH` на вбудовану `lib/`, тож залежності від встановленого Termux немає.

## Що постачається і звідки

| Бінарник | Звідки | Навіщо |
|---|---|---|
| `jq` (+ `lib/`) | репозиторій пакетів Termux (`packages.termux.dev/apt`), офіційний `.deb` | рушій спілкується JSON; `jq` розбирає аргументи й будує відповіді. |
| `abx2xml` / `xml2abx` | реліз [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | декодувати/кодувати двійковий XML Android (ABX) для підробки джерела встановлення в `packages.xml`, коли на пристрої немає `/system/bin/abx2xml` (до A12). Власний конвертер пристрою має пріоритет, коли він присутній. |
| `vdlu/verify/<abi>/ed25519-mini` | канонічний рушій [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | перевірити підпис ed25519 на оновленнях без прошивання (VDLU), без OpenSSL. |

Крок збирання - `.github/scripts/build_bin.sh`: він розв'язує пакет Termux плюс його транзитивні
залежності, розпаковує `.deb`-и, копіює потрібні бінарники й замикання спільних бібліотек, потрібне
кожному з них (розв'язане за допомогою `readelf`), потім отримує автономний конвертер ABX.

## Маніфест на пристрої: `PROVENANCE.json`

Кожна `bin/<abi>/` несе `PROVENANCE.json`, що перелічує кожен постачений файл (шлях, розмір, sha256) і
upstream-джерело кожного (пакет, версія, URL, sha256 архіву). Він переживає обрізання ABI на пристрої,
тож слід аудиту постачається разом із самим модулем.

## Як перевірити

1. Відкрийте `bin/<abi>/PROVENANCE.json` на пристрої або у прошивному zip.
2. Знову отримайте кожне закріплене джерело за URL, який він записує.
3. Розпакуйте й порівняйте sha256 кожного файлу з маніфестом.

Прошивний zip додатково несе супутник `.sha256` поруч із кожним постаченим файлом, `customize.sh`
перевіряє їх під час прошивання і **перериває** роботу за будь-якої невідповідності (пошкоджений або
обрізаний zip).

## Звітування

Знайшли невідповідність або занепокоєння щодо походження? Повідомте приватно - див.
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Ця документація створена за допомогою Claude (Anthropic) і підтримується VD171. Виправлення та покращення вітаються, див. [CONTRIBUTING.md](CONTRIBUTING.md)._
