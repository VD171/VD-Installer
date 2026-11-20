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

> **Languages:** [English](../../CONTRIBUTING.md) · العربية · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# المساهمة

المساهمات مرحب بها - التقارير وطلبات الدمج والترجمات والوثائق. يهدف المشروع إلى أن يكون
سهلاً ومرحّباً بالمساهمة فيه.

## مساهمو الذكاء الاصطناعي مرحب بهم

مساهمات الذكاء الاصطناعي والوكلاء مرحب بها وفق نفس معايير المراجعة المطبّقة على الجميع. يتحدّث
المحرك بلغة JSON عبر عقد بلا واجهة (`scripts/helper.sh <verb> <base64(JSON)>`)؛ راجع
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). قُد العقد، ولا تكشط واجهة WebUI.

## قواعد الكود

- **لافتة كاملة لكل ملف** (SPDX + جهات الاتصال) في أعلى كل ملف مصدري. لا تكتفِ بلافتة مقتطعة أبداً.
- الكود والمعرّفات والسجلّات والتعليقات بـ**الإنجليزية**. التعليقات فقط عندما تضيف شيئاً.
- الصدفة هي **POSIX sh** للجهاز (يجب أن يمرّ `sh -n`؛ لا bashisms عدا `local`؛ لا اعتماد على `jq` في مسارات الكود التي يجب أن تعمل قبل وجود `jq` المضمّن في PATH).
- واجهة WebUI بـ**JavaScript صرف**، بلا إطار عمل؛ وضع فاتح وداكن في كل الواجهة.
- **لا** شرطة طويلة (em-dash) أو متوسطة (en-dash) أبداً؛ دائماً شرطة `-`.
- البناء دائماً **release**، وليس debug أبداً.
- **لا تُضعِف سلوكاً حقيقياً أبداً** لتمرير شيء ما، ولا تحذف محتوى أبداً.

## الترجمات

تعيش سلاسل واجهة WebUI في `module/webroot/lang/<code>.json` (مفاتيح مسطّحة، الأساس الإنجليزي في
`lang/en.js`)؛ وللـ README ملف `README.<code>.md` لكل لغة. أضف لغة أو أصلحها وافتح طلب دمج (PR).

## الرخصة

بمساهمتك فإنك توافق على أن مساهمتك مرخّصة بموجب GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _تم إنشاء هذا التوثيق باستخدام Claude (Anthropic) ويتولى صيانته VD171. التصحيحات والتحسينات مرحّب بها؛ راجع [CONTRIBUTING.md](CONTRIBUTING.md)._
