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

> **Languages:** [English](../BINARIES.md) · العربية · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# الملفات التنفيذية المرفقة: المصدر والتدقيق

## المبادئ

- لا يُشحن أي شيء غامض. كل ملف تنفيذي مرفق يُجلب **في وقت البناء من مصدره الرسمي (upstream)**، ولا يُسحب أبداً
  من جهاز، وكل ملف يحمل sha256 كي يمكن إعادة إنتاج الحمولة.
- تُرفق الملفات التنفيذية لكل **ABI الأربعة** (`arm64-v8a`، `armeabi-v7a`، `x86`، `x86_64`)؛ ويقلّمها مثبّت
  الفلاش إلى ABI الجهاز الواحد.
- تعمل بشكل مستقل: تُشحن سلسلة المكتبات المشتركة لكل ملف تنفيذي بجانبه ويضبط المحرك `LD_LIBRARY_PATH` على
  `lib/` المرفق، فلا يوجد اعتماد على تثبيت Termux.

## ما الذي يُشحن، ومن أين

| الملف التنفيذي | من | لماذا |
|---|---|---|
| `jq` (+ `lib/`) | مستودع حزم Termux (`packages.termux.dev/apt`)، `.deb` الرسمي | المحرك يتحدث JSON؛ و`jq` يحلّل الوسائط ويبني الردود. |
| `abx2xml` / `xml2abx` | إصدار [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | يفك/يشفّر XML الثنائي لـ Android (ABX) من أجل انتحال مصدر التثبيت في `packages.xml`، حيث يفتقر الجهاز إلى `/system/bin/abx2xml` (قبل A12). ويُفضّل محوّل الجهاز الخاص عند وجوده. |
| `vdlu/verify/<abi>/ed25519-mini` | محرك [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) المرجعي | يتحقق من توقيع ed25519 في تحديثات (VDLU) بلا فلاش، دون OpenSSL. |

خطوة البناء هي `.github/scripts/build_bin.sh`: تحلّ حزمة Termux بالإضافة إلى اعتماداتها المتعدّية، وتستخرج
ملفات `.deb`، وتنسخ الملفات التنفيذية المطلوبة وسلسلة المكتبات المشتركة التي يحتاجها كل منها (محلولة بـ
`readelf`)، ثم تجلب محوّل ABX المستقل.

## بيان المصدر على الجهاز: `PROVENANCE.json`

يحمل كل `bin/<abi>/` ملف `PROVENANCE.json` يسرد كل ملف مشحون (المسار، الحجم، sha256) والمصدر الأصلي لكل منها
(الحزمة، الإصدار، URL، sha256 الأرشيف). وهو يصمد بعد تقليم ABI على الجهاز، فيُشحن أثر التدقيق مع الوحدة نفسها.

## كيفية التحقق

1. افتح `bin/<abi>/PROVENANCE.json` على الجهاز أو في الـ zip القابل للفلاش.
2. أعد جلب كل مصدر مثبّت من الـ URL الذي يسجّله.
3. استخرج وقارن sha256 لكل ملف مع البيان.

يحمل الـ zip القابل للفلاش إضافةً إلى ذلك رفيق `.sha256` بجانب كل ملف مشحون؛ ويتحقق منها `customize.sh` في
وقت الفلاش و**يُجهض** عند أي عدم تطابق (zip تالف أو مبتور).

## الإبلاغ

وجدت عدم تطابق أو مصدر قلق بشأن المصدر؟ أبلغ عنه بشكل خاص - انظر [SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _تم إنشاء هذا التوثيق باستخدام Claude (Anthropic) ويتولى صيانته VD171. التصحيحات والتحسينات مرحّب بها؛ راجع [CONTRIBUTING.md](CONTRIBUTING.md)._
