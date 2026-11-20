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

> **Languages:** [English](README.md) · العربية · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> مُثبِّت sideload بصلاحيات الجذر دون عوائق - KernelSU / APatch / Magisk WebUI.

## لماذا

تثبيت حزمة APK عبر sideload على هاتف مُروَّت أكثر إزعاجًا مما ينبغي: قد يُطلق مُدقِّق الحزم في Play
Protect الخطأ `INSTALL_FAILED_VERIFICATION_FAILURE`، وتحتاج التطبيقات المُقسَّمة
(`.xapk` / `.apkm` / `.apks`) إلى session API يدويًا، ويُعلن التطبيق المُثبَّت حديثًا عن نفسه بأنه
"مُثبَّت عبر sideload" لكل تطبيق يقرأ مصدر تثبيته. يقوم VDInstaller بكل ذلك نيابةً عنك، بصلاحيات الجذر
مسبقًا، دون مُطالبة "منح su" ودون طرفية.

## المزايا

- **كل أشكال APK** - ملف `.apk` واحد، أو مجلد كامل من حزم APK المستقلة (دفعة)، أو أرشيف مُقسَّم مُجمَّع
  (`.xapk` / `.apkm` / `.apks` / `.zip`)، أو مجلد يضم ملفات split APK منفصلة.
- **لا جدار تحقُّق** - مفتاح ثلاثي الحالات لمُدقِّق الحزم في Play Protect: إبقاؤه كما كان (مُطفَأ أثناء
  التثبيت فقط، ويُستعاد تمامًا)، أو دائمًا مُشغَّل، أو دائمًا مُطفَأ.
- **صريح بشأن Developer Verification** - تثبيت الجذر مُعفًى أصلًا من Developer Verification لعام 2026 في
  أندرويد؛ المفتاح يبذل أقصى جهد ويقول ذلك، وليس مفتاحًا زائفًا أبدًا.
- **ليس "مُثبَّتًا عبر sideload"** - يُظهر مصدر التثبيت اختياريًا بوصفه Play Store، سواء المُثبِّت (وقت
  التثبيت) أو البادئ (عبر تعديل `packages.xml` مُراعٍ لـ ABX).
- **منفصل وقابل للاستئناف** - تعمل عمليات التثبيت كعملية جذر منفصلة؛ إغلاق WebUI لا يقطعها أبدًا،
  وتُعيد الواجهة الاتصال عبر معرِّف العملية.
- **قرارك** - حزم الاختبار، منح كل أذونات وقت التشغيل، المستخدم المُستهدَف، تجاوز
  حظر SDK المستهدف المنخفض: كلها اختيارية.
- **دون اتصال، مكتفٍ ذاتيًا، دون إعادة تشغيل** - وحدة WebUI مع ملفاتها الثنائية المُرفقة؛ قابلة
  للاستخدام في لحظة فلاشها.

## وكلاء الذكاء الاصطناعي

يرحب هذا المشروع بمساهمي الذكاء الاصطناعي والوكلاء. يتحدث المحرِّك بلغة JSON عبر عقد صغير بلا واجهة
(`scripts/helper.sh <verb> <base64(JSON)>`)، موثَّق في
[docs/AI-AGENTS.md](docs/AI-AGENTS.md)، حتى يستطيع الوكيل قيادة كل إجراء تستطيعه WebUI - لا تكشط
WebUI. تخضع تصحيحات الذكاء الاصطناعي لنفس مستوى المراجعة كأي تصحيح آخر.

## التثبيت

افلش الملف المضغوط في KernelSU أو APatch أو Magisk وافتح واجهة VDInstaller WebUI من مدير الجذر لديك.
يُبقي المُثبِّت على ABI جهازك فقط ويُشغِّل بوابة سلامة `.sha256` الإلزامية (يُجهِض عند ملف مضغوط تالف أو
مبتور). أندرويد 8.0 (API 26) أو أحدث.

## الأمان

يعمل VDInstaller بصلاحيات الجذر ويُثبِّت حزم APK التي تختارها؛ إطفاء مُدقِّق الحزم لعملية تثبيت يُعطِّل
فحص البرمجيات الخبيثة، لذا لا تُثبِّت إلا حزم APK التي تثق بها. لا يُضعف أمان الجهاز بصمت أبدًا:
يُستعاد المُدقِّق إلى حالته السابقة تمامًا افتراضيًا، ولا يمس إعداد HMA-OSS لديك أبدًا. أبلغ عن
المشكلات وفق [SECURITY.md](SECURITY.md).

## البناء

دائمًا release، أبدًا debug. يجلب `.github/scripts/build_bin.sh` الأداة `jq` من مستودع apt الخاص بـ
Termux (مع إغلاق مكتباته المشتركة) ومُحوِّلَي `abx2xml` / `xml2abx` المستقلَّين، لجميع ABI الأربعة،
كلٌّ مع `PROVENANCE.json`. يُجمِّع سير عمل الإصدار الملفات المضغوطة القابلة للفلاش، ويكتب رفقاء
`.sha256`، ويملأ `update.json`، وينشر بوصفه `github-actions[bot]`.

## التوثيق

توجد الأدلة في [docs/](docs/) وتُنسَخ إلى ويكي GitHub. راجع [docs/AI-AGENTS.md](docs/AI-AGENTS.md)
للاطلاع على العقد بلا واجهة.

## انظر أيضًا

- **[VDInfos](https://github.com/VD171/VD-Infos)**: مُنقّح طرق الجهاز يقرأ كل عنصر عبر كل طريقة يمكنها قراءته ويقارنها جنباً إلى جنب.
- **[VDGoogle](https://github.com/VD171/VD-Google)**: خدمات Google الخاصة بك (RCS، Wallet، شهادات Play Integrity)، تُقرأ على جهازك دون إنترنت.
- **[COPG-VD](https://github.com/VD171/COPG-VD)**: مُزيِّف جهاز يحوّل بصمة جديدة إلى ملف تعريف متماسك ومتسق.
- **[VD-dropbear](https://github.com/VD171/VD-dropbear)**: خادم SSH مستقل يعمل بصلاحيات الجذر (Dropbear).
- **[VDBackup](https://github.com/VD171/VD-Backup)**: نسخ احتياطي واستعادة كاملة للتطبيقات والبيانات بصلاحية root، تُدار بالكامل من WebUI.
- **[VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)**: محرك تحديث ذاتي تزايدي بلا فلاش، مدمج في وحدات KernelSU/APatch/Magisk.

## جهات الاتصال

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/root-webui-v1-00-vd-installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## الرخصة

VDInstaller مُرخَّص بموجب GNU AGPL-3.0-or-later. راجع [LICENSE](LICENSE). NETWORK COPYLEFT: إن شغَّلت
نسخة مُعدَّلة، ولو كخدمة، فيجب أن تُتيح مصدرها.

## العلامات التجارية

تعود Android وKernelSU وAPatch وMagisk وGoogle Play وPlay Protect إلى مالكيها المعنيين. هذا المشروع
مستقل وغير مرتبط بها ولا مُعتمَد منها.

## الوسوم

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> انضم إلى القناة: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
