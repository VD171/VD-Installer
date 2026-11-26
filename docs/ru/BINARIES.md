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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · Русский · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Встроенные бинарные файлы: происхождение и аудит

## Принципы

- Ничего непрозрачного не поставляется. Каждый встроенный бинарный файл скачивается во **время сборки из
  его официального источника upstream**, никогда не извлекается с устройства, и каждый файл несёт sha256,
  чтобы полезную нагрузку можно было воспроизвести.
- Бинарные файлы встроены для **всех четырёх ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`);
  установщик прошивки сокращает их до единственного ABI устройства.
- Они работают автономно: замыкание разделяемых библиотек каждого бинарного файла поставляется рядом, и
  движок задаёт `LD_LIBRARY_PATH` на встроенный `lib/`, поэтому нет зависимости от установленного Termux.

## Что поставляется и откуда

| Бинарный файл | Откуда | Зачем |
|---|---|---|
| `jq` (+ `lib/`) | репозиторий пакетов Termux (`packages.termux.dev/apt`), официальный `.deb` | движок говорит на JSON; `jq` разбирает аргументы и строит ответы. |
| `abx2xml` / `xml2abx` | релиз [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | декодировать/кодировать двоичный XML Android (ABX) для подмены источника установки в `packages.xml`, где у устройства нет `/system/bin/abx2xml` (до A12). Собственный конвертер устройства предпочтителен, когда он присутствует. |
| `vdlu/verify/<abi>/ed25519-mini` | канонический движок [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | проверить подпись ed25519 на обновлениях без прошивки (VDLU), без OpenSSL. |

Шаг сборки - `.github/scripts/build_bin.sh`: он разрешает пакет Termux плюс его транзитивные зависимости,
извлекает файлы `.deb`, копирует нужные бинарные файлы и замыкание разделяемых библиотек, которое нужно
каждому из них (разрешённое с помощью `readelf`), затем скачивает автономный конвертер ABX.

## Манифест на устройстве: `PROVENANCE.json`

Каждый `bin/<abi>/` несёт `PROVENANCE.json`, перечисляющий каждый поставляемый файл (путь, размер, sha256)
и источник upstream каждого из них (пакет, версия, URL, sha256 архива). Он переживает сокращение ABI на
устройстве, поэтому аудиторский след поставляется с самим модулем.

## Как проверить

1. Откройте `bin/<abi>/PROVENANCE.json` на устройстве или в прошиваемом zip.
2. Заново скачайте каждый закреплённый источник по URL, который он записывает.
3. Извлеките и сравните sha256 каждого файла с манифестом.

Прошиваемый zip дополнительно несёт сопутствующий файл `.sha256` рядом с каждым поставляемым файлом;
`customize.sh` проверяет их во время прошивки и **прерывает** процесс при любом несовпадении (повреждённый
или усечённый zip).

## Сообщение о проблемах

Нашли несовпадение или сомнение по поводу происхождения? Сообщите приватно - см.
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Эта документация создана с помощью Claude (Anthropic) и поддерживается VD171. Исправления и улучшения приветствуются, см. [CONTRIBUTING.md](CONTRIBUTING.md)._
