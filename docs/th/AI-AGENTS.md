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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · ไทย · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# เอเจนต์ AI: สัญญาแบบไม่มีส่วนติดต่อ

VDInstaller ถูกสั่งงานด้วยสัญญาเชลล์เพียงหนึ่งเดียว เอเจนต์ (ที่รันในฐานะ root เช่นเดียวกับ WebUI) เรียก:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

และอ่านออบเจกต์ JSON เพียงหนึ่งตัวบน stdout สำเร็จคือ `{"ok":true,...}`, ล้มเหลวคือ
`{"ok":false,"code":"ERR_...","message":"..."}` ปฏิบัติการยาวคืนค่า `opid` ที่คุณคอยเช็ค อย่าขูดข้อมูลจาก
WebUI, ใช้สัญญานี้

## เวิร์บ

| เวิร์บ | อาร์กิวเมนต์ (JSON) | คืนค่า |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | ออบเจกต์ config |
| `config-set` | คีย์ config ใด ๆ ที่จะรวมเข้า | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (แยกตัว) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (แยกตัว) |
| `progress` | base64 ของสตริง opid (ไม่ใช่ JSON) | ออบเจกต์ความคืบหน้าแบบสด; `done:true` เมื่อเสร็จ |
| `cancel` | base64 ของสตริง opid | `{cancelled}` |
| `verifier-status` | - | การตั้งค่าตัวตรวจสอบปัจจุบัน |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | ตัดล็อกที่ค้างเก่าทิ้ง |

## โหมดการติดตั้ง

| `mode` | รับ | ความหมาย |
|---|---|---|
| `single` | `path` | หนึ่ง `.apk` |
| `batch` | `dir` | โฟลเดอร์ที่มีไฟล์ `.apk` อิสระ ติดตั้งทีละไฟล์ |
| `archive` | `path` | อาร์ไคฟ์แบบแยกที่จัดกลุ่มแล้ว (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | โฟลเดอร์ที่มีไฟล์ `.apk` แยกที่กระจัดกระจายของแอปเดียว |

## ตัวเลือก (ต่อปฏิบัติการในอาร์กิวเมนต์ หรือเก็บไว้ผ่าน `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int)

## ความคืบหน้า

คอยเช็ค `progress` ด้วย `opid` ออบเจกต์นี้มี `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), `item` ที่เป็นตัวเลือก และเมื่อเสร็จ
จะมี `done:true` พร้อม `result` (single/split), อาร์เรย์ `results[]` (batch) หรือ `error`

## ราวกันตกด้านความปลอดภัย

- สวิตช์ตัวตรวจสอบและการแก้ไข `packages.xml` สามารถย้อนกลับได้และถูกตรวจสอบ (`logs/audit.jsonl`)
- `install`/`uninstall` เปลี่ยนสถานะของอุปกรณ์, ยืนยันเจตนาก่อนเรียก เช่นเดียวกับที่ WebUI ทำ
- อย่าขูดข้อมูลหรือทำให้ WebUI เองเป็นอัตโนมัติ, สัญญานี้คือพื้นผิวที่รองรับ

<!-- doc-footer -->

---

> _เอกสารนี้สร้างขึ้นด้วย Claude (Anthropic) และดูแลโดย VD171 ยินดีรับการแก้ไขและการปรับปรุง ดู [CONTRIBUTING.md](CONTRIBUTING.md)_
