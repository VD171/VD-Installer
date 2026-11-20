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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · فارسی · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# مشارکت

مشارکت‌ها خوش‌آمدند - ایشوها، پول‌ریکوئست‌ها، ترجمه‌ها و مستندات. هدف پروژه این است که مشارکت در آن آسان و
دعوت‌کننده باشد.

## مشارکت‌کنندگان هوش مصنوعی خوش‌آمدند

مشارکت‌های هوش مصنوعی و عامل‌ها با همان معیار بازبینی که برای همه اعمال می‌شود پذیرفته می‌شوند. موتور از طریق
یک قرارداد headless با JSON صحبت می‌کند (`scripts/helper.sh <verb> <base64(JSON)>`)؛ به
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) مراجعه کنید. قرارداد را به‌کار بگیرید، از WebUI اسکرپ نکنید.

## قواعد کد

- **بنر کامل در هر فایل** (SPDX + تماس‌ها) در بالای هر فایل منبع. هرگز نسخه‌ی کوتاه‌شده.
- کد، شناسه‌ها، لاگ‌ها و کامنت‌ها به **انگلیسی**. کامنت فقط زمانی که چیزی به مطلب می‌افزاید.
- شل برای دستگاه **POSIX sh** است (`sh -n` باید پاس شود؛ بدون bashism فراتر از `local`؛ بدون وابستگی به `jq` در مسیرهای کدی که باید پیش از قرار گرفتن `jq` همراه در PATH اجرا شوند).
- WebUI با **JS خالص** است، بدون فریم‌ورک؛ حالت روشن و تیره در کل رابط کاربری.
- **هرگز** خط تیره‌ی بلند یا کوتاه؛ همیشه یک خط تیره‌ی ساده `-`.
- بیلد همیشه **release** است، هرگز debug.
- **هرگز یک رفتار واقعی را تضعیف نکنید** تا چیزی پاس شود، و هرگز محتوایی را حذف نکنید.

## ترجمه‌ها

رشته‌های WebUI در `module/webroot/lang/<code>.json` قرار دارند (کلیدهای مسطح، پایه‌ی انگلیسی در
`lang/en.js`)؛ README برای هر زبان یک `README.<code>.md` دارد. زبانی را اضافه یا اصلاح کنید و یک PR باز کنید.

## مجوز

با مشارکت می‌پذیرید که مشارکت شما تحت مجوز GNU AGPL-3.0-or-later قرار می‌گیرد.

<!-- doc-footer -->

---

> _این مستندات با Claude (Anthropic) تولید شده و توسط VD171 نگهداری می‌شود. اصلاحات و بهبودها خوش‌آمد است؛ به [CONTRIBUTING.md](CONTRIBUTING.md) مراجعه کنید._
