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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · Bahasa Indonesia · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Arsitektur

VDInstaller adalah WebUI tipis di atas mesin shell root. Tidak ada bagian antarmuka yang punya hak istimewa;
setiap tindakan berhak istimewa adalah satu panggilan shell yang mengembalikan satu objek JSON.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI JavaScript murni (tanpa framework), terang/gelap, 22 bahasa. Ia memanggil mesin
  melalui jembatan WebUI KernelSU (`ksu.exec`) dan mengurai balasan JSON-nya.
- **`scripts/common.sh`** - pustaka bersama yang di-source oleh kedua skrip: resolusi ABI/PATH, pembungkus
  `pm`/`dumpsys`/`fw` (lingkungan bersih sehingga pustaka Termux bawaan tidak pernah menutupi pustaka ART),
  helper JSON dan `jq`, serta `xml_edit` yang ABX-aware.
- **`scripts/helper.sh`** - kontrak WebUI: satu baris JSON per panggilan. Verb pendek (version, config,
  browse, scan) berjalan inline; yang panjang (install, uninstall) memisahkan sebuah worker dan
  mengembalikan `opid`.
- **`scripts/worker.sh`** - mesin pemasangan terpisah: keempat mode pemasangan, sakelar verifikator,
  pemalsuan sumber pemasangan, dan API sesi pengelola paket. Ia menulis progres ke sebuah berkas yang
  dipantau WebUI, dan bertahan meski WebUI ditutup (`setsid`, dan ia lolos dari pembeku aplikasi).

## Poin penting

- **Sudah root.** Tanpa perintah "berikan su" dan tanpa mengutak-atik `sucompat`; mesin berjalan sebagai
  root dari modul dan memanggil `pm` / `settings` secara langsung.
- **Pemasangan sesi.** Semua mode memakai `pm install-create` / `install-write` / `install-commit`,
  sehingga aplikasi split terpasang dengan benar dan sumber pemasangan (`-i`) disetel pada waktu sesi.
- **ABX-aware.** Pemalsuan inisiator di `packages.xml` memeriksa magic XML biner `ABX\0`, mendekode,
  menyunting, mengenkode ulang, melakukan round-trip untuk validasi, mencadangkan byte-persis dan menukar
  secara atomik; berkas yang hidup tidak pernah disentuh kecuali setiap langkah berhasil.
- **Tanpa reboot.** Modul WebUI mandiri tanpa ada yang perlu dimuat (mount): `customize.sh` menyalinnya ke
  direktori modul aktif sehingga ia bekerja pada saat ia dipasang.
- **Pembaruan tanpa flash.** Mesin **VDLU** bawaan memperbarui modul dengan mengunduh hanya berkas yang
  berubah, dialamatkan berdasarkan konten, dan ditandatangani ed25519 - tanpa flash ulang penuh.
- **Terpisah (detached).** Operasi panjang berjalan di luar webview; menutup WebUI tidak pernah
  menyelanya.

## Jaminan kompatibilitas

- `sh` POSIX di perangkat (`sh -n` lolos; tanpa bashism selain `local`; tanpa ketergantungan pada `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` adalah satu-satunya alat framework yang dipakai, semuanya lewat
  `/system/bin`.
- Biner bawaan (`jq`, `abx2xml`/`xml2abx`) bersifat opsional untuk jalur umum dan membawa provenans-nya;
  konverter ABX jatuh kembali ke `/system/bin/abx2xml` milik perangkat bila ada.

<!-- doc-footer -->

---

> _Dokumentasi ini dibuat dengan Claude (Anthropic) dan dikelola oleh VD171. Koreksi dan perbaikan dipersilakan; lihat [CONTRIBUTING.md](CONTRIBUTING.md)._
