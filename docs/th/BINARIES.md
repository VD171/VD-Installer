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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · ไทย · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# ไบนารีที่มาพร้อม: ที่มาและการตรวจสอบ

## หลักการ

- ไม่มีสิ่งที่ปิดทึบถูกส่งมาด้วย ทุกไบนารีที่มาพร้อมถูกดึงมาที่ **เวลาบิลด์จากต้นทางอย่างเป็นทางการ** ไม่เคย
  ดึงมาจากอุปกรณ์ และทุกไฟล์มี sha256 กำกับเพื่อให้สามารถสร้างเพย์โหลดซ้ำได้
- ไบนารีมาพร้อมสำหรับ **ABI ทั้งสี่** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`); ตัวติดตั้งแบบแฟลชจะ
  ตัดให้เหลือเฉพาะของอุปกรณ์
- มันรันแบบ standalone: ชุดไลบรารีที่ใช้ร่วมของแต่ละไบนารีถูกส่งมาด้วยข้างกัน และเอนจินตั้ง
  `LD_LIBRARY_PATH` ไปยัง `lib/` ที่มาพร้อม จึงไม่มีการพึ่งพาว่าต้องติดตั้ง Termux

## สิ่งที่ส่งมา และมาจากที่ใด

| ไบนารี | จาก | เพราะเหตุใด |
|---|---|---|
| `jq` (+ `lib/`) | คลังแพ็กเกจ Termux (`packages.termux.dev/apt`), `.deb` อย่างเป็นทางการ | เอนจินพูด JSON; `jq` แยกวิเคราะห์อาร์กิวเมนต์และสร้างคำตอบ |
| `abx2xml` / `xml2abx` | release ของ [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | ถอด/เข้ารหัส binary XML ของ Android (ABX) สำหรับการปลอมแหล่งติดตั้งใน `packages.xml` ในที่ที่อุปกรณ์ขาด `/system/bin/abx2xml` (ก่อน A12) ตัวแปลงของอุปกรณ์เองจะถูกเลือกใช้ก่อนเมื่อมี |
| `vdlu/verify/<abi>/ed25519-mini` | เอนจิน [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) ตามหลักการ | ตรวจสอบลายเซ็น ed25519 บนการอัปเดตแบบไม่ต้องแฟลช (VDLU) โดยไม่ต้องใช้ OpenSSL |

ขั้นตอนบิลด์คือ `.github/scripts/build_bin.sh`: มันแก้ค่าแพ็กเกจ Termux บวกกับทรัพยากรที่พึ่งพาแบบสืบทอด
แตก `.deb` คัดลอกไบนารีที่ต้องการและชุดไลบรารีที่ใช้ร่วมที่แต่ละตัวต้องการ (แก้ค่าด้วย `readelf`) จากนั้น
ดึงตัวแปลง ABX แบบ standalone

## รายการที่มาบนอุปกรณ์: `PROVENANCE.json`

แต่ละ `bin/<abi>/` มี `PROVENANCE.json` ที่แสดงทุกไฟล์ที่ส่งมา (เส้นทาง ขนาด sha256) และต้นทางของแต่ละ
ไฟล์ (แพ็กเกจ เวอร์ชัน URL sha256 ของอาร์ไคฟ์) มันอยู่รอดจากการตัด ABI บนอุปกรณ์ ดังนั้นร่องรอยการ
ตรวจสอบจึงมาพร้อมกับตัวโมดูลเอง

## วิธีตรวจสอบ

1. เปิด `bin/<abi>/PROVENANCE.json` บนอุปกรณ์หรือในไฟล์ zip ที่แฟลชได้
2. ดึงแต่ละแหล่งที่ตรึงไว้ซ้ำจาก URL ที่มันบันทึกไว้
3. แตกไฟล์และเปรียบเทียบ sha256 ของแต่ละไฟล์กับรายการที่มา

ไฟล์ zip ที่แฟลชได้ยังมีไฟล์คู่ `.sha256` อยู่ข้างทุกไฟล์ที่ส่งมา; `customize.sh` ตรวจสอบพวกมันตอนแฟลช
และ **ยกเลิก** เมื่อมีสิ่งใดไม่ตรงกัน (zip ที่เสียหายหรือถูกตัดทอน)

## การรายงาน

พบความไม่ตรงกันหรือข้อกังวลเรื่องที่มา? รายงานเป็นการส่วนตัว - ดูที่ [SECURITY.md](../SECURITY.md)

<!-- doc-footer -->

---

> _เอกสารนี้สร้างขึ้นด้วย Claude (Anthropic) และดูแลโดย VD171 ยินดีรับการแก้ไขและการปรับปรุง ดู [CONTRIBUTING.md](CONTRIBUTING.md)_
