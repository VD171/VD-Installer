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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · ไทย · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# การมีส่วนร่วม

ยินดีรับการมีส่วนร่วม - ปัญหา (issues), pull request, การแปล และเอกสาร โปรเจกต์นี้มุ่งหวังให้การมีส่วนร่วมเป็นเรื่องง่าย
และน่าเชิญชวน

## ยินดีต้อนรับผู้มีส่วนร่วมที่เป็น AI

การมีส่วนร่วมจาก AI และเอเจนต์ได้รับการต้อนรับด้วยมาตรฐานการตรวจสอบเดียวกันกับทุกคน เอนจินสื่อสารด้วย JSON ผ่านสัญญาแบบ
headless (`scripts/helper.sh <verb> <base64(JSON)>`), ดู
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) จงขับเคลื่อนผ่านสัญญา อย่าขูด (scrape) WebUI

## กฎของโค้ด

- **แบนเนอร์ต่อไฟล์ที่สมบูรณ์** (SPDX + ข้อมูลติดต่อ) ที่ด้านบนของไฟล์ต้นฉบับทุกไฟล์ ห้ามตัดทอน
- โค้ด ตัวระบุ (identifiers) บันทึก (logs) และความคิดเห็น เป็น**ภาษาอังกฤษ** ใส่ความคิดเห็นเฉพาะเมื่อมันเพิ่มคุณค่าเท่านั้น
- เชลล์เป็น **POSIX sh** สำหรับอุปกรณ์ (`sh -n` ต้องผ่าน, ไม่มี bashism นอกเหนือจาก `local`, ไม่มีการพึ่งพา `jq` ในเส้นทางโค้ดที่ต้องทำงานก่อนที่ `jq` ที่มาพร้อมกันจะอยู่บน PATH)
- WebUI เป็น **vanilla JS** ไม่มีเฟรมเวิร์ก, มีทั้งโหมดสว่างและมืดในทุกส่วนของ UI
- **ห้าม**ใช้ em-dash หรือ en-dash เด็ดขาด, ใช้ยัติภังค์ `-` เสมอ
- การ build เป็น **release** เสมอ ไม่ใช่ debug
- **ห้ามลดทอนพฤติกรรมจริง**เพื่อให้บางสิ่งผ่าน และห้ามลบเนื้อหา

## การแปล

สตริงของ WebUI อยู่ใน `module/webroot/lang/<code>.json` (คีย์แบบแบน ฐานภาษาอังกฤษใน
`lang/en.js`), README มี `README.<code>.md` หนึ่งไฟล์ต่อหนึ่งภาษา เพิ่มหรือแก้ไขภาษาแล้วเปิด PR

## สัญญาอนุญาต

เมื่อมีส่วนร่วม คุณยอมรับว่าการมีส่วนร่วมของคุณได้รับอนุญาตภายใต้ GNU AGPL-3.0-or-later

<!-- doc-footer -->

---

> _เอกสารนี้สร้างขึ้นด้วย Claude (Anthropic) และดูแลโดย VD171 ยินดีรับการแก้ไขและการปรับปรุง ดู [CONTRIBUTING.md](CONTRIBUTING.md)_
