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

> **Languages:** [English](../AI-AGENTS.md) · العربية · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# وكلاء الذكاء الاصطناعي: العقد بلا واجهة

يُقاد VDInstaller بعقد صدفة واحد. يستدعي وكيل (يعمل كجذر، كما تفعل الـ WebUI):

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

ويقرأ كائن JSON واحداً بالضبط على stdout. النجاح هو `{"ok":true,...}`؛ والفشل هو
`{"ok":false,"code":"ERR_...","message":"..."}`. تُرجع العمليات الطويلة `opid` تستطلعه. لا تكشط الـ WebUI؛
استخدم هذا العقد.

## الأفعال

| الفعل | الوسائط (JSON) | يُرجع |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | كائن الإعدادات |
| `config-set` | أي مفاتيح إعدادات للدمج | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (منفصل) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (منفصل) |
| `progress` | base64 لسلسلة opid (لا JSON) | كائن التقدّم الحي؛ `done:true` عند الانتهاء |
| `cancel` | base64 لسلسلة opid | `{cancelled}` |
| `verifier-status` | - | إعدادات المدقّق الحالية |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | يقلّم السجلات القديمة |

## أوضاع التثبيت

| `mode` | يأخذ | المعنى |
|---|---|---|
| `single` | `path` | `.apk` واحد |
| `batch` | `dir` | مجلد يحوي ملفات `.apk` مستقلة، تثبيت واحد لكل ملف |
| `archive` | `path` | أرشيف مقسّم مجمّع (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | مجلد يحوي ملفات الأجزاء `.apk` المنفصلة لتطبيق واحد |

## الخيارات (لكل عملية في الوسائط، أو مثبّتة عبر `config-set`)

`spoof_installer` (bool)، `spoof_installer_pkg` (string)، `deep_spoof` (bool)،
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`)،
`grant_all_perms`، `allow_test`، `bypass_low_target_sdk` (bool)، `target_user` (int).

## التقدّم

استطلع `progress` بـ `opid`. يحمل الكائن `percent` و`phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`)، و`item` اختيارياً، وعند الاكتمال
`done:true` مع `result` (single/split)، أو مصفوفة `results[]` (batch)، أو `error`.

## حواجز الأمان

- مفتاح المدقّق وتعديل `packages.xml` قابلان للعكس ومدقّقان (`logs/audit.jsonl`).
- `install`/`uninstall` يغيّران حالة الجهاز؛ أكّد النية قبل الاستدعاء، كما تفعل الـ WebUI.
- لا تكشط أو تؤتمت الـ WebUI نفسها أبداً؛ هذا العقد هو السطح المدعوم.

<!-- doc-footer -->

---

> _تم إنشاء هذا التوثيق باستخدام Claude (Anthropic) ويتولى صيانته VD171. التصحيحات والتحسينات مرحّب بها؛ راجع [CONTRIBUTING.md](CONTRIBUTING.md)._
