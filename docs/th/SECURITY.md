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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · ไทย · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# นโยบายความปลอดภัย

## โมเดลภัยคุกคามในหนึ่งบรรทัด

VDInstaller ทำงานในฐานะ root และติดตั้ง APK ที่ผู้ใช้เลือกอย่างชัดเจน, การปิดตัวตรวจสอบ (verifier) ของ Play Protect
สำหรับการติดตั้งจะปิดใช้งานการสแกนมัลแวร์ ดังนั้นมันจึงเป็น "การติดตั้งแบบไร้แรงเสียดทาน" ไม่ใช่ "การติดตั้งที่ปลอดภัย" -
ติดตั้งเฉพาะ APK ที่คุณไว้วางใจเท่านั้น

## สิ่งที่มันทำและไม่ทำ

- โดยค่าเริ่มต้น มันจะคืนค่าตัวตรวจสอบแพ็กเกจกลับสู่สถานะเดิมอย่างแม่นยำ (การทิ้งค่า `0`/`1` ไว้ในที่ที่เดิมไม่มีค่าใด ๆ
  ถือเป็นการเปิดเผยตัว (tell) ในตัวมันเอง ดังนั้นจึงถูกลบอีกครั้ง)
- มันจะไม่แตะต้องการตั้งค่า HMA-OSS ของคุณเลย, การซ่อนแอปเป็นคำแนะนำที่คุณต้องดำเนินการเอง
- การแก้ไขแหล่งที่มาของการติดตั้งใน `packages.xml` รับรู้ ABX (ABX-aware) สำรองไฟล์ที่ใช้งานจริงแบบตรงตามไบต์ก่อนการเปลี่ยนแปลงใด ๆ
  ทำ round-trip เพื่อตรวจสอบความถูกต้อง และปล่อยให้ไฟล์ที่ใช้งานจริงไม่ถูกแตะต้องเมื่อเกิดความล้มเหลวใด ๆ
- ไบนารีที่มาพร้อมกันถูกดึงมาขณะ build จาก upstream ทางการของมัน และมี `PROVENANCE.json` กำกับ

## การรายงานช่องโหว่

กรุณารายงานแบบส่วนตัวก่อน ระบุขั้นตอนการทำซ้ำ เวอร์ชันที่ได้รับผลกระทบ และผลกระทบ

- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me
- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)

<!-- doc-footer -->

---

> _เอกสารนี้สร้างขึ้นด้วย Claude (Anthropic) และดูแลโดย VD171 ยินดีรับการแก้ไขและการปรับปรุง ดู [CONTRIBUTING.md](CONTRIBUTING.md)_
