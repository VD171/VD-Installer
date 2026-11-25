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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · Bahasa Indonesia · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Pemasang sideload root tanpa hambatan - KernelSU / APatch / Magisk WebUI.

## Mengapa

Memasang APK sideloaded di ponsel yang di-root lebih berisik daripada seharusnya: verifier paket Play
Protect dapat memunculkan `INSTALL_FAILED_VERIFICATION_FAILURE`, aplikasi split (`.xapk` / `.apkm` /
`.apks`) membutuhkan session API secara manual, dan aplikasi yang baru dipasang mengumumkan dirinya
sebagai "sideloaded" ke setiap aplikasi yang membaca sumber pemasangannya. VDInstaller melakukan semua
itu untuk Anda, sudah sebagai root, tanpa permintaan "beri izin su" dan tanpa terminal.

## Fitur

- **Setiap bentuk APK** - satu `.apk`, seluruh folder berisi APK mandiri (batch), arsip split terkelompok
  (`.xapk` / `.apkm` / `.apks` / `.zip`), atau folder berisi APK split lepas.
- **Tanpa tembok verifikasi** - sakelar 3 arah untuk verifier paket Play Protect: biarkan apa adanya
  (mati hanya selama pemasangan, lalu dipulihkan persis seperti semula), selalu aktif, atau selalu
  nonaktif.
- **Jujur soal Developer Verification** - pemasangan root sudah dikecualikan dari Developer Verification
  Android 2026; sakelar ini bersifat best-effort dan menyatakannya, bukan sakelar palsu.
- **Bukan "sideloaded"** - secara opsional menampilkan sumber pemasangan sebagai Play Store, baik sebagai
  pemasang (saat pemasangan) maupun penginisiasi (melalui penyuntingan `packages.xml` yang sadar ABX).
- **Terlepas dan dapat dilanjutkan** - pemasangan berjalan sebagai proses root yang terlepas; menutup
  WebUI tidak pernah menghentikannya, dan antarmuka tersambung kembali melalui id operasi.
- **Keputusan Anda** - paket uji, berikan semua izin runtime, pengguna target, lewati blokir
  target SDK rendah: semuanya opsional.
- **Offline, mandiri, tanpa reboot** - modul WebUI dengan binernya ikut disertakan; dapat dipakai begitu
  di-flash.

## Agen AI

Proyek ini menyambut kontributor AI dan agen. Engine berbicara JSON melalui kontrak headless kecil
(`scripts/helper.sh <verb> <base64(JSON)>`), terdokumentasi di [docs/AI-AGENTS.md](docs/AI-AGENTS.md),
sehingga sebuah agen dapat menjalankan setiap tindakan yang bisa dilakukan WebUI - jangan melakukan
scraping pada WebUI. Patch dari AI dinilai dengan standar peninjauan yang sama dengan yang lain.

## Pemasangan

Flash zip di KernelSU, APatch atau Magisk lalu buka WebUI VDInstaller dari manajer root Anda. Pemasang
hanya menyimpan ABI perangkat Anda dan menjalankan gate integritas `.sha256` yang wajib (membatalkan jika
zip rusak atau terpotong). Android 8.0 (API 26) atau yang lebih baru.

## Keamanan

VDInstaller berjalan sebagai root dan memasang APK yang Anda pilih; mematikan verifier paket untuk sebuah
pemasangan menonaktifkan pemindaian malware, jadi pasang hanya APK yang Anda percaya. Ia tidak pernah
melemahkan keamanan perangkat secara diam-diam: secara default verifier dipulihkan ke keadaan sebelumnya
persis seperti semula, dan ia tidak pernah menyentuh konfigurasi HMA-OSS Anda. Laporkan masalah sesuai
[SECURITY.md](SECURITY.md).

## Build

Selalu release, tidak pernah debug. `.github/scripts/build_bin.sh` mengambil `jq` dari repositori apt
Termux (beserta closure pustaka bersamanya) dan konverter standalone `abx2xml` / `xml2abx`, untuk keempat
ABI, masing-masing dengan `PROVENANCE.json`. Workflow release merakit zip yang dapat di-flash, menulis
pendamping `.sha256`, mengisi `update.json` dan mempublikasikan sebagai `github-actions[bot]`.

## Dokumentasi

Panduan berada di [docs/](docs/) dan dicerminkan ke wiki GitHub. Lihat
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) untuk kontrak headless.

## Lihat juga

- **[COPG-VD](https://github.com/VD171/COPG-VD)**: spoofing global fingerprint perangkat / Play Integrity, untuk seluruh perangkat dengan cakupan per aplikasi dan sebuah WebUI.
- **[VDBackup](https://github.com/VD171/VD-Backup)**: backup dan pemulihan penuh aplikasi dan data sebagai root, dikendalikan sepenuhnya dari sebuah WebUI.
- **[VD-dropbear](https://github.com/VD171/VD-dropbear)**: daemon SSH mandiri dengan akses root (Dropbear).
- **[VDGoogle](https://github.com/VD171/VD-Google)**: layanan Google Anda (RCS, Wallet, atestasi Play Integrity), dibaca di perangkat Anda tanpa internet.
- **[VDInfos](https://github.com/VD171/VD-Infos)**: sebuah debugger metode perangkat yang membaca setiap item melalui setiap metode yang dapat membacanya dan membandingkannya secara berdampingan.
- **[VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)**: sebuah mesin pembaruan-mandiri inkremental tanpa flash, tertanam di dalam modul KernelSU/APatch/Magisk.
- **[VD-Modules](https://github.com/VD171/VD-Modules)**: repositori modul MMRL/WebUI-X kami (instal semuanya dari manajer root Anda).
- **[@VictorGabriel7Dev/build.prop](https://github.com/VictorGabriel7Dev/build.prop)**: sebuah dataset fingerprint `build.prop` Pixel (fork dari @T3SL4).
- **[@VictorGabriel7Dev/mtproto-store](https://github.com/VictorGabriel7Dev/mtproto-store)**: gunakan Telegram sebagai object store dari sebuah CLI Go mungil.

## Kontak

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/VD-Installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## Lisensi

VDInstaller dilisensikan di bawah GNU AGPL-3.0-or-later. Lihat [LICENSE](LICENSE). NETWORK COPYLEFT:
jalankan versi yang dimodifikasi, bahkan sebagai layanan, dan Anda harus menyediakan sumbernya.

## Merek Dagang

Android, KernelSU, APatch, Magisk, Google Play dan Play Protect adalah milik pemiliknya masing-masing.
Proyek ini independen dan tidak berafiliasi dengan atau didukung oleh mereka.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Bergabunglah ke kanal: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
