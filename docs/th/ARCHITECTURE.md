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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · ไทย · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# สถาปัตยกรรม

VDInstaller เป็น WebUI บาง ๆ วางทับเอนจินเชลล์ที่เป็น root ไม่มีส่วนใดใน UI ที่มีสิทธิพิเศษ, ทุกการกระทำ
ที่มีสิทธิพิเศษคือการเรียกเชลล์หนึ่งครั้งที่คืนค่าออบเจกต์ JSON หนึ่งตัว

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI แบบ JS ล้วน (ไม่มีเฟรมเวิร์ก) สว่าง/มืด 22 ภาษา มันเรียกเอนจินผ่านบริดจ์ WebUI
  ของ KernelSU (`ksu.exec`) และแยกวิเคราะห์คำตอบ JSON
- **`scripts/common.sh`** - ไลบรารีร่วมที่ทั้งสองสคริปต์โหลดเข้า: การแก้ค่า ABI/PATH, ตัวหุ้ม
  `pm`/`dumpsys`/`fw` (สภาพแวดล้อมสะอาดเพื่อให้ไลบรารี Termux ที่มาพร้อมไม่บดบังของ ART), ตัวช่วย
  JSON และ `jq` รวมถึง `xml_edit` ที่รู้จัก ABX
- **`scripts/helper.sh`** - สัญญาของ WebUI: หนึ่งบรรทัด JSON ต่อการเรียก เวิร์บสั้น (version, config,
  browse, scan) รันแบบ inline, เวิร์บยาว (install, uninstall) แยกตัว worker ออกไปและคืนค่า `opid`
- **`scripts/worker.sh`** - เอนจินติดตั้งที่แยกตัว: โหมดติดตั้งทั้งสี่ สวิตช์ตัวตรวจสอบ การปลอมแหล่งติดตั้ง
  และ session API ของตัวจัดการแพ็กเกจ มันเขียนความคืบหน้าลงไฟล์ที่ WebUI คอยเช็ค และอยู่รอดได้แม้ WebUI
  จะถูกปิด (`setsid` และมันหลบตัวหยุดแอป)

## ประเด็นสำคัญ

- **เป็น root อยู่แล้ว** ไม่มีกล่อง "grant su" และไม่มีการสลับ `sucompat`, เอนจินรันในฐานะ root จากโมดูล
  และเรียก `pm` / `settings` โดยตรง
- **การติดตั้งแบบเซสชัน** ทุกโหมดใช้ `pm install-create` / `install-write` / `install-commit` ดังนั้น
  แอปแบบแยกจึงติดตั้งได้ถูกต้องและแหล่งติดตั้ง (`-i`) ถูกตั้งตอนเริ่มเซสชัน
- **รู้จัก ABX** การปลอมตัวริเริ่มใน `packages.xml` ตรวจหาเลขมหัศจรรย์ binary-XML `ABX\0` ถอดรหัส แก้ไข
  เข้ารหัสใหม่ วนไปกลับเพื่อตรวจสอบ สำรองแบบตรงไบต์ และสลับแบบอะตอม, ไฟล์ที่ใช้งานจริงไม่เคยถูกแตะต้อง
  เว้นแต่ทุกขั้นตอนจะผ่าน
- **ไม่ต้องรีบูต** โมดูล WebUI แบบในตัวที่ไม่มีอะไรต้องเมานต์: `customize.sh` คัดลอกมันเข้าไปยังไดเรกทอรี
  โมดูลที่ใช้งานอยู่ เพื่อให้มันทำงานได้ทันทีที่ถูกแฟลช
- **อัปเดตแบบไม่ต้องแฟลช** เอนจิน **VDLU** ที่มาพร้อมอัปเดตโมดูลโดยดาวน์โหลดเฉพาะไฟล์ที่เปลี่ยนแปลง ซึ่ง
  ระบุด้วยเนื้อหาและลงนาม ed25519 เท่านั้น - ไม่ต้องแฟลชใหม่ทั้งหมด
- **แยกตัว** ปฏิบัติการยาวรันนอก webview, การปิด WebUI ไม่เคยขัดจังหวะมัน

## การรับประกันความเข้ากันได้

- POSIX `sh` บนอุปกรณ์ (`sh -n` ผ่าน, ไม่มี bashism นอกเหนือจาก `local`, ไม่พึ่งพา `awk`)
- `pm` / `dumpsys` / `settings` / `cmd` เป็นเครื่องมือเฟรมเวิร์กเพียงอย่างเดียวที่ใช้ ทั้งหมดผ่าน
  `/system/bin`
- ไบนารีที่มาพร้อม (`jq`, `abx2xml`/`xml2abx`) เป็นตัวเลือกสำหรับเส้นทางทั่วไปและมีที่มา, ตัวแปลง ABX
  จะย้อนกลับไปใช้ `/system/bin/abx2xml` ของอุปกรณ์เองในที่ที่มีอยู่

<!-- doc-footer -->

---

> _เอกสารนี้สร้างขึ้นด้วย Claude (Anthropic) และดูแลโดย VD171 ยินดีรับการแก้ไขและการปรับปรุง ดู [CONTRIBUTING.md](CONTRIBUTING.md)_
