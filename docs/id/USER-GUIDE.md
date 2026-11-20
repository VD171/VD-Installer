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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · Bahasa Indonesia · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# Panduan pengguna VDInstaller

## Daftar isi

1. [Apa itu VDInstaller](#1-apa-itu-vdinstaller)
2. [Persyaratan](#2-persyaratan)
3. [Instalasi dan menjalankan pertama kali](#3-instalasi-dan-menjalankan-pertama-kali)
4. [Tur WebUI](#4-tur-webui)
5. [Memasang APK](#5-memasang-apk)
6. [Opsi](#6-opsi)
7. [Mengendalikan VDInstaller dari asisten AI](#7-mengendalikan-vdinstaller-dari-asisten-ai)
8. [Pemecahan masalah dan FAQ](#8-pemecahan-masalah-dan-faq)

## 1. Apa itu VDInstaller

VDInstaller adalah **modul WebUI** KernelSU / APatch / Magisk yang memasang APK hasil sideload sebagai root
tanpa hambatan: tanpa perintah "berikan su", tanpa terminal, dan tanpa berjuang melawan verifikator Play
Protect. Ia menangani APK tunggal, seluruh folder sekaligus, dan aplikasi terpisah (`.xapk` / `.apkm` /
`.apks` / `.zip` atau berkas split lepas), dan ia dapat menampilkan sumber pemasangan sebagai Play Store
sehingga sebuah aplikasi tidak tampak hasil sideload.

## 2. Persyaratan

- Android 8.0 atau yang lebih baru (API 26+).
- Solusi root dengan dukungan WebUI: **KernelSU**, **APatch** atau **Magisk**.

## 3. Instalasi dan menjalankan pertama kali

1. Unduh `VD-Installer-vX.XX-universal.zip` terbaru dari halaman
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Pasang sebagai modul di pengelola root Anda (*Modules -> Install from storage*).
3. VDInstaller aktif **tanpa reboot** - ia mandiri (WebUI + biner bawaan), jadi tidak ada yang perlu
   dimuat (mount).
4. Buka WebUI **VDInstaller** dari daftar modul pengelola root Anda.

Saat pemasangan, installer hanya menyimpan ABI perangkat Anda dan menjalankan gerbang integritas `.sha256`
wajib yang **membatalkan** jika zip rusak atau terpotong. Pengaturan tersimpan di `/data/adb/vdinstaller`
dan bertahan melewati pembaruan.

## 4. Tur WebUI

Tiga tab:

- **Install** - pilih sebuah mode, pilih APK atau folder, pasang, pantau progres langsung.
- **Options** - sumber pemasangan, sakelar verifikator Play Protect, dan flag pemasangan. Semuanya
  disimpan otomatis.
- **About** - versi, apa yang dilakukannya, persyaratan, tautan dan lisensi.

## 5. Memasang APK

Anda memilih mode di tab **Install**; VDInstaller tidak pernah menebak.

| Mode | Yang Anda berikan | Yang terjadi |
|---|---|---|
| **APK tunggal** | sebuah berkas `.apk` | satu sesi pemasangan, satu aplikasi. |
| **Folder APK** (batch) | sebuah folder berisi berkas `.apk` yang mandiri | tiap APK dipasang sendiri-sendiri, satu demi satu; batch yang sebagian melaporkan mana yang gagal dan mengapa. |
| **Arsip split** | sebuah `.xapk` / `.apkm` / `.apks` / `.zip` | diekstrak, lalu `base.apk` + split dipasang sebagai satu aplikasi dalam satu sesi (OBB dari XAPK juga ditempatkan, bila ada). |
| **Folder split** | sebuah folder berisi berkas `.apk` split lepas dari satu aplikasi | split dipasang sebagai satu aplikasi dalam satu sesi. |

Aplikasi "split" adalah satu APK yang dibagi menjadi sebuah base ditambah APK konfigurasi per-kepadatan /
per-ABI / per-bahasa; semuanya harus dipasang **bersama** dalam satu sesi, yang dilakukan oleh mode split
untuk Anda.

### 5.1 Dialog Browse

**Browse** membuka pemilih berkas yang menampilkan folder dan berkas yang dapat dipasang di suatu jalur:

- Ketuk sebuah **folder** untuk masuk ke dalamnya; **Up** naik ke folder induk.
- Pada mode berkas (APK tunggal / Arsip split), ketuk sebuah **berkas** untuk memilihnya.
- Pada mode folder (Folder APK / Folder split), masuk ke dalam folder lalu ketuk **Use this folder**.

Anda juga dapat mengetik atau menempelkan jalur secara langsung (misalnya `/sdcard/Download/app.apk`).

### 5.2 Progres, batal, lanjutkan

Pemasangan berjalan sebagai **proses root yang terpisah (detached)**. Kartu progres menampilkan fasenya;
**Cancel** menghentikannya. Jika Anda menutup WebUI di tengah pemasangan, pemasangan tetap berjalan dan
antarmuka tersambung kembali berdasarkan id operasi saat Anda membukanya lagi.

## 6. Opsi

Semua di sini disimpan otomatis dan berlaku untuk pemasangan berikutnya.

### 6.1 Sumber pemasangan

Aplikasi yang baru di-sideload mengumumkan ke setiap aplikasi yang membacanya (dan ke atestasi) bahwa ia
di-sideload. VDInstaller dapat menampilkan sumbernya sebagai Play Store sebagai gantinya.

- **Tampilkan Play Store sebagai installer** (aktif secara default) - menyetel `installerPackageName`
  lewat `pm install-create -i com.android.vending`. Berlaku segera.
- **Palsukan juga inisiator** (aktif secara default) - menyetel `installInitiator` dan `packageSource`
  dengan menyunting `/data/system/packages.xml`. Ini **ABX-aware** (dekode -> sunting -> enkode ulang,
  dengan cadangan byte-persis dan pertukaran atomik) dan berlaku **setelah reboot berikutnya**, karena
  pengelola paket menyimpan `packages.xml` dalam cache.

### 6.2 Verifikator paket Play Protect

Pemasangan hasil sideload dapat ditolak dengan `INSTALL_FAILED_VERIFICATION_FAILURE` oleh verifikator paket
Play Protect. Sebuah sakelar 3-arah:

- **Biarkan apa adanya** (default) - mati hanya untuk pemasangan, lalu dipulihkan ke keadaan sebelumnya
  yang **persis** (dihapus lagi jika semula tak ada nilai eksplisit, karena `0`/`1` di tempat yang semula
  kosong itu sendiri adalah petunjuk pada perangkat stealth).
- **Selalu aktif** - paksa aktif dan pertahankan.
- **Selalu mati** - paksa mati dan pertahankan. WebUI memperingatkan: membiarkannya mati adalah petunjuk
  stealth dan menonaktifkan pemindaian malware untuk setiap pemasangan.

### 6.3 Developer Verification

Developer Verification Android 2026 memblokir pemasangan aplikasi dari pengembang yang tidak terdaftar pada
perangkat bersertifikat, tetapi ia diberlakukan oleh **layanan terpisah**, bukan Play Protect, dan
**pemasangan sebagai root sudah dikecualikan** darinya (pengecualian yang sama yang didapat pemasangan ADB).
VDInstaller memasang APK Anda tanpa memandang hal ini, jadi sakelar ini bersifat **upaya terbaik dan jujur**:
ia menerapkan tombol nyata hanya jika memang ada dan tidak pernah berpura-pura membalik sakelar yang tidak
melakukan apa-apa.

### 6.4 Flag pemasangan

| Flag | Efek |
|---|---|
| **Berikan semua izin runtime** | memberikan setiap izin runtime saat pemasangan (`-g`). |
| **Izinkan paket uji** | memasang paket yang ditandai khusus uji (`-t`). |
| **Lewati pemblokiran target SDK rendah** | memasang aplikasi dengan `targetSdk` yang sangat lama. |
| **Pengguna target** | id pengguna Android tujuan pemasangan (default `0`). |

### 6.5 Tetap tersembunyi

Untuk stealth, pertimbangkan menyembunyikan pengelola root dan aplikasi sensitif Anda dengan HMA-OSS.
VDInstaller **tidak pernah menyentuh pengaturan HMA-OSS Anda** - petunjuk ini hanya pengingat; perubahannya
Anda lakukan sendiri di HMA-OSS.

## 7. Mengendalikan VDInstaller dari asisten AI

Mesinnya berbicara dengan sebuah kontrak JSON kecil lewat `scripts/helper.sh`, sehingga sebuah agen dapat
mengendalikan setiap tindakan yang dapat dilakukan WebUI. Lihat [AI-AGENTS](AI-AGENTS). Kendalikan
kontraknya, jangan scrape WebUI-nya.

## 8. Pemecahan masalah dan FAQ

**Saya mendapat `INSTALL_FAILED_VERIFICATION_FAILURE`.** Itu verifikator paket Play Protect. Dengan sakelar
verifikator dibiarkan pada **Biarkan apa adanya** (default), VDInstaller mematikannya untuk pemasangan lalu
memulihkannya, jadi hal itu tidak terjadi.

**Saya mengaktifkan sumber Play Store tetapi aplikasi masih tampak hasil sideload.** Bagian installer
berlaku segera; bagian inisiator (`packages.xml`) berlaku **setelah reboot berikutnya**.

**Apakah ia melewati Developer Verification Google?** Tidak perlu - pemasangan sebagai root dikecualikan
(lihat 6.3). Tidak ada sakelar palsu untuknya.

**Apakah perlu reboot?** Tidak, kecuali pemalsuan inisiator yang opsional.

**Apakah menghapus VDInstaller akan menghapus aplikasi yang saya pasang?** Tidak - itu adalah pemasangan
nyata milik sistem; menghapus modul hanya membersihkan keadaan internal VDInstaller sendiri.

**Apakah aman?** Ia memasang APK yang Anda pilih dan, dengan verifikator mati, melewati pemindaian malware -
pasang hanya APK yang Anda percayai. Ia tidak pernah melemahkan apa pun secara diam-diam.

<!-- doc-footer -->

---

> _Dokumentasi ini dibuat dengan Claude (Anthropic) dan dikelola oleh VD171. Koreksi dan perbaikan dipersilakan; lihat [CONTRIBUTING.md](CONTRIBUTING.md)._
