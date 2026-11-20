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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · فارسی · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# سیاست امنیتی

## مدل تهدید در یک خط

VDInstaller با دسترسی root اجرا می‌شود و APKهایی را نصب می‌کند که کاربر به‌صراحت انتخاب می‌کند؛ خاموش کردن
وریفایر Play Protect برای یک نصب، یک اسکن بدافزار را غیرفعال می‌کند، پس این «نصب بدون اصطکاک» است، نه «نصب
امن» - فقط APKهایی را نصب کنید که به آن‌ها اعتماد دارید.

## کاری که می‌کند و کاری که نمی‌کند

- به‌طور پیش‌فرض وریفایر بسته را به وضعیت دقیق پیشین خود بازمی‌گرداند (باقی گذاشتن یک `0`/`1` در جایی که هیچ
  مقداری نبوده، خودش یک نشانه است، پس دوباره حذف می‌شود).
- هرگز به پیکربندی HMA-OSS شما دست نمی‌زند؛ مخفی کردن اپ‌ها توصیه‌ای است که خودتان انجام می‌دهید.
- ویرایش منبع نصب در `packages.xml` از ABX آگاه است، پیش از هر تغییر از فایل زنده یک نسخه‌ی پشتیبان بایت‌به‌بایت
  می‌گیرد، برای اعتبارسنجی یک رفت‌وبرگشت انجام می‌دهد و در صورت هرگونه خطا فایل زنده را دست‌نخورده باقی می‌گذارد.
- باینری‌های همراه در زمان بیلد از upstream رسمی‌شان دریافت می‌شوند و یک `PROVENANCE.json` به همراه دارند.

## گزارش یک آسیب‌پذیری

لطفاً ابتدا به‌صورت خصوصی گزارش دهید. مراحل بازتولید، نسخه‌ی متاثر و تاثیر را شامل کنید.

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

> _این مستندات با Claude (Anthropic) تولید شده و توسط VD171 نگهداری می‌شود. اصلاحات و بهبودها خوش‌آمد است؛ به [CONTRIBUTING.md](CONTRIBUTING.md) مراجعه کنید._
