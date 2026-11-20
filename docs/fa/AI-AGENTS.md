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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · فارسی · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# عامل‌های هوش مصنوعی: قرارداد بدون رابط

VDInstaller با یک قرارداد شل واحد هدایت می‌شود. یک عامل (که مانند WebUI به‌صورت روت اجرا می‌شود) این را
فراخوانی می‌کند:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

و دقیقاً یک شیء JSON را روی stdout می‌خواند. موفقیت `{"ok":true,...}` است؛ شکست
`{"ok":false,"code":"ERR_...","message":"..."}` است. عملیات‌های بلند یک `opid` برمی‌گردانند که آن را
پایش (poll) می‌کنید. WebUI را اسکرپ نکنید؛ از این قرارداد استفاده کنید.

## فعل‌ها

| فعل | آرگومان‌ها (JSON) | برمی‌گرداند |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | شیء پیکربندی |
| `config-set` | هر کلید پیکربندی برای ادغام | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (جداشده) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (جداشده) |
| `progress` | base64 رشته‌ی opid (نه JSON) | شیء پیشرفت زنده؛ `done:true` هنگام پایان |
| `cancel` | base64 رشته‌ی opid | `{cancelled}` |
| `verifier-status` | - | تنظیمات فعلی وریفایر |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | logهای کهنه را هرس می‌کند |

## حالت‌های نصب

| `mode` | می‌گیرد | معنا |
|---|---|---|
| `single` | `path` | یک `.apk` |
| `batch` | `dir` | یک پوشه از فایل‌های `.apk` مستقل، هرکدام یک نصب |
| `archive` | `path` | یک آرشیو اسپلیت گروه‌بندی‌شده (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | یک پوشه با فایل‌های `.apk` اسپلیت جداگانه‌ی یک اپ |

## گزینه‌ها (به‌ازای هر عملیات در args، یا ماندگارشده از طریق `config-set`)

`spoof_installer` (bool)، `spoof_installer_pkg` (string)، `deep_spoof` (bool)،
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`)،
`grant_all_perms`، `allow_test`، `bypass_low_target_sdk` (bool)، `target_user` (int).

## پیشرفت

`progress` را با `opid` پایش کنید. این شیء شامل `percent`، `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`)، یک `item` اختیاری، و هنگام تکمیل
`done:true` همراه با یک `result` (single/split)، یک آرایه‌ی `results[]` (batch)، یا یک `error` است.

## حفاظ‌های ایمنی

- کلید وریفایر و ویرایش `packages.xml` بازگشت‌پذیر و حسابرسی‌شده‌اند (`logs/audit.jsonl`).
- `install`/`uninstall` وضعیت دستگاه را تغییر می‌دهند؛ مانند WebUI، پیش از فراخوانی قصد را تأیید کنید.
- هرگز خودِ WebUI را اسکرپ یا خودکارسازی نکنید؛ این قرارداد همان سطح پشتیبانی‌شده است.

<!-- doc-footer -->

---

> _این مستندات با Claude (Anthropic) تولید شده و توسط VD171 نگهداری می‌شود. اصلاحات و بهبودها خوش‌آمد است؛ به [CONTRIBUTING.md](CONTRIBUTING.md) مراجعه کنید._
