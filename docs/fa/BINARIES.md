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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · فارسی · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# باینری‌های همراه: منشأ و حسابرسی

## اصول

- هیچ چیز مبهمی عرضه نمی‌شود. هر باینری همراه در **زمان ساخت از upstream رسمی آن** واکشی می‌شود، هرگز از
  یک دستگاه بیرون کشیده نمی‌شود، و هر فایل یک sha256 به‌همراه دارد تا بتوان بار داده را بازتولید کرد.
- باینری‌ها برای **هر چهار ABI** (`arm64-v8a`، `armeabi-v7a`، `x86`، `x86_64`) همراه می‌شوند؛ نصب‌کننده‌ی
  فلش آن‌ها را به تنها ABI دستگاه هرس می‌کند.
- آن‌ها به‌صورت مستقل اجرا می‌شوند: بستارِ کتابخانه‌های اشتراکی هر باینری در کنار آن عرضه می‌شود و موتور
  `LD_LIBRARY_PATH` را روی `lib/` همراه‌شده تنظیم می‌کند، پس هیچ وابستگی‌ای به نصب‌بودن Termux وجود ندارد.

## چه چیزی عرضه می‌شود و از کجا

| باینری | از | چرا |
|---|---|---|
| `jq` (+ `lib/`) | مخزن بسته‌های Termux (`packages.termux.dev/apt`)، `.deb` رسمی | موتور JSON صحبت می‌کند؛ `jq` آرگومان‌ها را تجزیه و پاسخ‌ها را می‌سازد. |
| `abx2xml` / `xml2abx` | ریلیز [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | دیکد/انکد XML باینری اندروید (ABX) برای جعل منبع نصب در `packages.xml`، جایی که دستگاه فاقد `/system/bin/abx2xml` است (پیش از A12). مبدل خودِ دستگاه در صورت وجود ترجیح داده می‌شود. |
| `vdlu/verify/<abi>/ed25519-mini` | موتور قانونی [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | تأیید امضای ed25519 روی به‌روزرسانی‌های بدون فلش (VDLU)، بدون OpenSSL. |

گام ساخت `.github/scripts/build_bin.sh` است: بسته‌ی Termux به‌علاوه‌ی وابستگی‌های ترایِ آن را resolve
می‌کند، `.deb`ها را استخراج می‌کند، باینری‌های موردنظر و بستارِ کتابخانه‌های اشتراکی موردنیاز هرکدام را
(resolve‌شده با `readelf`) کپی می‌کند، سپس مبدل مستقل ABX را واکشی می‌کند.

## مانیفست روی دستگاه: `PROVENANCE.json`

هر `bin/<abi>/` یک `PROVENANCE.json` به‌همراه دارد که هر فایل عرضه‌شده (مسیر، اندازه، sha256) و منبع
upstream هرکدام (بسته، نسخه، URL، sha256 آرشیو) را فهرست می‌کند. این فایل از هرسِ ABI روی دستگاه دوام
می‌آورد، پس ردِ حسابرسی با خودِ ماژول عرضه می‌شود.

## چگونه تأیید کنیم

1. `bin/<abi>/PROVENANCE.json` را روی دستگاه یا در zip قابل‌فلش باز کنید.
2. هر منبع پین‌شده را دوباره از URLی که ثبت کرده واکشی کنید.
3. sha256 هر فایل را استخراج و با مانیفست مقایسه کنید.

zip قابل‌فلش علاوه بر این یک همراهِ `.sha256` در کنار هر فایل عرضه‌شده دارد؛ `customize.sh` آن‌ها را در
زمان فلش تأیید می‌کند و در هر ناهمخوانی (یک zip خراب یا ناقص) **لغو می‌کند**.

## گزارش‌دهی

یک ناهمخوانی یا یک نگرانی درباره‌ی منشأ یافتید؟ آن را به‌صورت خصوصی گزارش کنید - به
[SECURITY.md](../SECURITY.md) مراجعه کنید.

<!-- doc-footer -->

---

> _این مستندات با Claude (Anthropic) تولید شده و توسط VD171 نگهداری می‌شود. اصلاحات و بهبودها خوش‌آمد است؛ به [CONTRIBUTING.md](CONTRIBUTING.md) مراجعه کنید._
