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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · Bahasa Indonesia · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Biner bawaan: provenans dan audit

## Prinsip

- Tidak ada yang buram ikut dikirim. Setiap biner bawaan diambil pada **waktu build dari sumber resmi di
  hulu**, tidak pernah ditarik dari perangkat, dan setiap berkas membawa sha256 sehingga muatannya dapat
  direproduksi.
- Biner disertakan untuk **keempat ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`), installer flash
  memangkasnya menjadi satu milik perangkat.
- Mereka berjalan mandiri: closure pustaka bersama tiap biner dikirim bersamanya dan mesin menyetel
  `LD_LIBRARY_PATH` ke folder `lib/` bawaan, sehingga tidak ada ketergantungan pada Termux yang terpasang.

## Apa yang dikirim, dan dari mana

| Biner | Dari | Mengapa |
|---|---|---|
| `jq` (+ `lib/`) | repositori paket Termux (`packages.termux.dev/apt`), `.deb` resmi | mesin berbicara JSON; `jq` mengurai argumen dan menyusun balasan. |
| `abx2xml` / `xml2abx` | rilis [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | mendekode/mengenkode XML biner Android (ABX) untuk pemalsuan sumber pemasangan di `packages.xml`, ketika perangkat tidak punya `/system/bin/abx2xml` (pra-A12). Konverter milik perangkat lebih diutamakan bila ada. |
| `vdlu/verify/<abi>/ed25519-mini` | mesin kanonik [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | memverifikasi tanda tangan ed25519 pada pembaruan tanpa flash (VDLU), tanpa OpenSSL. |

Langkah build adalah `.github/scripts/build_bin.sh`: ia menyelesaikan paket Termux beserta dependensi
transitifnya, mengekstrak `.deb`, menyalin biner yang diinginkan dan closure pustaka bersama yang dibutuhkan
masing-masing (diselesaikan dengan `readelf`), lalu mengambil konverter ABX yang mandiri.

## Manifes di perangkat: `PROVENANCE.json`

Setiap `bin/<abi>/` membawa sebuah `PROVENANCE.json` yang mencantumkan setiap berkas yang dikirim (jalur,
ukuran, sha256) dan sumber hulu masing-masing (paket, versi, URL, sha256 arsip). Ia bertahan melewati
pemangkasan ABI di perangkat, sehingga jejak audit dikirim bersama modulnya sendiri.

## Cara memverifikasi

1. Buka `bin/<abi>/PROVENANCE.json` di perangkat atau di dalam zip yang dapat di-flash.
2. Ambil ulang setiap sumber yang dipatok dari URL yang dicatatnya.
3. Ekstrak dan bandingkan sha256 tiap berkas dengan manifes.

Zip yang dapat di-flash tambahan membawa pendamping `.sha256` di samping setiap berkas yang dikirim;
`customize.sh` memverifikasinya pada waktu flash dan **membatalkan** pada ketidakcocokan apa pun (zip rusak
atau terpotong).

## Pelaporan

Menemukan ketidakcocokan atau kekhawatiran tentang provenans? Laporkan secara pribadi - lihat
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Dokumentasi ini dibuat dengan Claude (Anthropic) dan dikelola oleh VD171. Koreksi dan perbaikan dipersilakan, lihat [CONTRIBUTING.md](CONTRIBUTING.md)._
