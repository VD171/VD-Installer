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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · Bahasa Indonesia · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Berkontribusi

Kontribusi sangat diterima - issues, pull requests, terjemahan dan docs. Proyek ini bertujuan agar
mudah dan ramah untuk dikontribusikan.

## Kontributor AI diterima

Kontribusi AI dan agent diterima dengan standar peninjauan yang sama seperti semua orang. Engine
berbicara JSON melalui headless contract (`scripts/helper.sh <verb> <base64(JSON)>`), lihat
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Jalankan contract-nya, jangan scrape WebUI.

## Aturan kode

- **Banner per-file lengkap** (SPDX + contacts) di bagian atas setiap file sumber. Jangan pernah yang dipangkas.
- Kode, identifier, log dan komentar dalam **bahasa Inggris**. Komentar hanya jika menambahkan sesuatu.
- Shell adalah **POSIX sh** untuk perangkat (`sh -n` harus lolos, tidak ada bashism di luar `local`, tidak ada dependensi `jq` pada jalur kode yang harus berjalan sebelum `jq` bawaan ada di PATH).
- WebUI adalah **vanilla JS**, tanpa framework, terang dan gelap di semua UI.
- **Jangan pernah** em-dash atau en-dash, selalu hyphen `-`.
- Build selalu **release**, tidak pernah debug.
- **Jangan pernah melemahkan perilaku nyata** agar sesuatu lolos, dan jangan pernah menghapus konten.

## Terjemahan

String WebUI berada di `module/webroot/lang/<code>.json` (flat keys, basis bahasa Inggris di
`lang/en.js`), README memiliki satu `README.<code>.md` per bahasa. Tambahkan atau perbaiki bahasa dan buka PR.

## Lisensi

Dengan berkontribusi, Anda setuju bahwa kontribusi Anda dilisensikan di bawah GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Dokumentasi ini dibuat dengan Claude (Anthropic) dan dikelola oleh VD171. Koreksi dan perbaikan dipersilakan, lihat [CONTRIBUTING.md](CONTRIBUTING.md)._
