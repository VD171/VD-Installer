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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · Bahasa Indonesia · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# Agen AI: kontrak headless

VDInstaller dikendalikan oleh satu kontrak shell. Sebuah agen (berjalan sebagai root, seperti WebUI)
memanggil:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

dan membaca tepat satu objek JSON di stdout. Keberhasilan adalah `{"ok":true,...}`, kegagalan adalah
`{"ok":false,"code":"ERR_...","message":"..."}`. Operasi panjang mengembalikan `opid` yang Anda pantau.
Jangan scrape WebUI, gunakan kontrak ini.

## Verb

| Verb | Argumen (JSON) | Mengembalikan |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | objek konfigurasi |
| `config-set` | kunci konfigurasi mana pun untuk digabungkan | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (terpisah) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (terpisah) |
| `progress` | base64 dari string opid (bukan JSON) | objek progres langsung; `done:true` saat selesai |
| `cancel` | base64 dari string opid | `{cancelled}` |
| `verifier-status` | - | pengaturan verifikator saat ini |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | memangkas log usang |

## Mode pemasangan

| `mode` | menerima | makna |
|---|---|---|
| `single` | `path` | satu `.apk` |
| `batch` | `dir` | sebuah folder berisi berkas `.apk` mandiri, satu pemasangan masing-masing |
| `archive` | `path` | sebuah arsip split yang dikelompokkan (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | sebuah folder berisi berkas `.apk` split lepas dari satu aplikasi |

## Opsi (per operasi di dalam argumen, atau dipersistenkan lewat `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Progres

Pantau `progress` dengan `opid`. Objek tersebut membawa `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), sebuah `item` opsional, dan saat
selesai `done:true` dengan sebuah `result` (single/split), sebuah array `results[]` (batch), atau sebuah
`error`.

## Pengaman

- Sakelar verifikator dan penyuntingan `packages.xml` dapat dikembalikan dan diaudit
  (`logs/audit.jsonl`).
- `install`/`uninstall` mengubah keadaan perangkat, konfirmasikan niat sebelum memanggilnya, seperti yang
  dilakukan WebUI.
- Jangan pernah scrape atau mengotomatiskan WebUI itu sendiri, kontrak ini adalah permukaan yang didukung.

<!-- doc-footer -->

---

> _Dokumentasi ini dibuat dengan Claude (Anthropic) dan dikelola oleh VD171. Koreksi dan perbaikan dipersilakan, lihat [CONTRIBUTING.md](CONTRIBUTING.md)._
