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

> **Languages:** [English](../ARCHITECTURE.md) · العربية · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# البنية

VDInstaller هو WebUI رفيعة فوق محرك صدفة جذر. لا شيء في الواجهة يملك صلاحية؛ وكل إجراء ذي صلاحية هو استدعاء
صدفة واحد يُرجع كائن JSON واحداً.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI بـ JS صرف (بلا إطار عمل)، فاتح/داكن، 22 لغة. تستدعي المحرك عبر جسر KernelSU WebUI
  (`ksu.exec`) وتحلّل ردّ JSON.
- **`scripts/common.sh`** - المكتبة المشتركة التي يستوردها كلا السكربتين: تحليل ABI/PATH، وأغلفة
  `pm`/`dumpsys`/`fw` (بيئة نظيفة كي لا تحجب مكتبات Termux المرفقة مكتبات ART أبداً)، ومساعدات JSON و`jq`،
  و`xml_edit` المدرك لـ ABX.
- **`scripts/helper.sh`** - عقد الـ WebUI: سطر JSON واحد لكل استدعاء. الأفعال القصيرة (version, config,
  browse, scan) تعمل inline؛ أما الطويلة (install, uninstall) فتفصل عاملاً وتُرجع `opid`.
- **`scripts/worker.sh`** - محرك التثبيت المنفصل: أوضاع التثبيت الأربعة، ومفتاح المدقّق، وانتحال مصدر
  التثبيت، وواجهة جلسات مدير الحزم. يكتب التقدّم إلى ملف تستطلعه الـ WebUI، ويصمد عند إغلاق الـ WebUI
  (`setsid`، وهو يفلت من مجمّد التطبيقات).

## النقاط الأساسية

- **جذر بالفعل.** لا طلب "grant su" ولا تبديل `sucompat`؛ يعمل المحرك كجذر من الوحدة ويستدعي `pm` /
  `settings` مباشرة.
- **تثبيتات بالجلسات.** تستخدم كل الأوضاع `pm install-create` / `install-write` / `install-commit`، فتُثبّت
  التطبيقات المقسّمة بشكل صحيح ويُضبط مصدر التثبيت (`-i`) في وقت الجلسة.
- **مدرك لـ ABX.** يفحص انتحال البادئ في `packages.xml` عن سحر XML الثنائي `ABX\0`، ويفك التشفير، ويعدّل،
  ويعيد التشفير، ويقوم بدورة ذهاب وإياب للتحقق، وينسخ احتياطياً بايتاً ببايت، ويبدّل ذرّياً؛ ولا يُمسّ الملف
  الحي أبداً ما لم تنجح كل خطوة.
- **بلا إعادة تشغيل.** وحدة WebUI مكتفية ذاتياً لا شيء فيها يُركّب: ينسخها `customize.sh` إلى دليل الوحدات
  النشط، فتعمل لحظة فلاشها.
- **تحديثات بلا فلاش.** يحدّث محرك **VDLU** المرفق الوحدة بتنزيل الملفات المتغيّرة فقط، المعنونة بالمحتوى،
  الموقّعة بـ ed25519 - دون إعادة فلاش كاملة.
- **منفصل.** تعمل العمليات الطويلة خارج webview؛ وإغلاق الـ WebUI لا يقاطعها أبداً.

## ضمان التوافق

- POSIX `sh` على الجهاز (`sh -n` ينجح؛ لا bashisms تتجاوز `local`؛ لا اعتماد على `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` هي أدوات الإطار الوحيدة المستخدمة، كلها عبر `/system/bin`.
- الملفات التنفيذية المرفقة (`jq`، `abx2xml`/`xml2abx`) اختيارية للمسار الشائع وتحمل مصدرها؛ ويرتدّ محوّل ABX
  إلى `/system/bin/abx2xml` الخاص بالجهاز حيثما وُجد.

<!-- doc-footer -->

---

> _تم إنشاء هذا التوثيق باستخدام Claude (Anthropic) ويتولى صيانته VD171. التصحيحات والتحسينات مرحّب بها؛ راجع [CONTRIBUTING.md](CONTRIBUTING.md)._
