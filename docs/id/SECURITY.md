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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · Bahasa Indonesia · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# Kebijakan Keamanan

## Model ancaman dalam satu baris

VDInstaller berjalan sebagai root dan menginstal APK yang secara eksplisit dipilih pengguna; mematikan
Play Protect verifier untuk sebuah instalasi menonaktifkan pemindaian malware, jadi ini adalah
"frictionless install", bukan "safe install" - instal hanya APK yang Anda percaya.

## Apa yang dilakukannya dan tidak dilakukannya

- Secara default ia mengembalikan package verifier ke keadaan persisnya sebelumnya (meninggalkan `0`/`1` di tempat yang sebelumnya tidak ada adalah tell tersendiri, jadi dihapus kembali).
- Ia tidak pernah menyentuh setup HMA-OSS Anda; menyembunyikan aplikasi adalah rekomendasi yang Anda tindaklanjuti sendiri.
- Penyuntingan install-source `packages.xml` bersifat ABX-aware, membuat cadangan file live secara byte-exact sebelum perubahan apa pun, melakukan round-trip untuk memvalidasi, dan membiarkan file live tidak tersentuh pada kegagalan apa pun.
- Binary bawaan diambil saat build dari upstream resminya dan membawa sebuah `PROVENANCE.json`.

## Melaporkan kerentanan

Harap laporkan secara pribadi terlebih dahulu. Sertakan langkah-langkah untuk mereproduksi, versi yang terpengaruh, dan dampaknya.

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

> _Dokumentasi ini dibuat dengan Claude (Anthropic) dan dikelola oleh VD171. Koreksi dan perbaikan dipersilakan; lihat [CONTRIBUTING.md](CONTRIBUTING.md)._
