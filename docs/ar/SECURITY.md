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

> **Languages:** [English](../../SECURITY.md) · العربية · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# سياسة الأمان

## نموذج التهديد في سطر واحد

يعمل VDInstaller بصلاحيات الجذر ويُثبّت ملفات APK التي يختارها المستخدم صراحةً؛ وإيقاف مدقّق
Play Protect أثناء التثبيت يعطّل فحص البرمجيات الخبيثة، لذا فهو "تثبيت بلا احتكاك"، وليس "تثبيت
آمن" - ثبّت فقط ملفات APK التي تثق بها.

## ماذا يفعل وماذا لا يفعل

- يستعيد مدقّق الحزم إلى حالته السابقة تماماً افتراضياً (ترك `0`/`1` حيث لم يكن هناك شيء هو بحدّ
  ذاته إشارة كاشفة، لذا يُحذف من جديد).
- لا يمسّ أبداً إعداد HMA-OSS الخاص بك؛ إخفاء التطبيقات توصية تنفّذها بنفسك.
- تعديل مصدر التثبيت في `packages.xml` يراعي ABX، وينسخ الملف الحيّ احتياطياً بدقة البايت قبل
  أي تغيير، ويُجري دورة ذهاب وإياب للتحقق، ويترك الملف الحيّ دون مساس عند أي إخفاق.
- تُجلب الملفات الثنائية المضمّنة أثناء البناء من مصدرها الرسمي الأصلي وتحمل ملف `PROVENANCE.json`.

## الإبلاغ عن ثغرة أمنية

يُرجى الإبلاغ بشكل خاص أولاً. أدرِج خطوات إعادة الإنتاج والإصدار المتأثر والأثر.

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

> _تم إنشاء هذا التوثيق باستخدام Claude (Anthropic) ويتولى صيانته VD171. التصحيحات والتحسينات مرحّب بها؛ راجع [CONTRIBUTING.md](CONTRIBUTING.md)._
