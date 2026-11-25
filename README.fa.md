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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · فارسی · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> نصب‌کننده sideload با روت و بدون دردسر - KernelSU / APatch / Magisk WebUI.

## چرا

نصب یک APK از راه sideload روی گوشی روت‌شده پر سر و صداتر از آن است که باید باشد: بررسی‌کننده بسته
Play Protect ممکن است `INSTALL_FAILED_VERIFICATION_FAILURE` بدهد، اپ‌های split (`.xapk` / `.apkm` /
`.apks`) به استفاده دستی از session API نیاز دارند، و اپی که تازه نصب شده خود را به هر اپی که منبع
نصبش را می‌خواند به عنوان "sideloaded" معرفی می‌کند. VDInstaller همه این کارها را برای شما انجام
می‌دهد، آن هم از پیش به صورت روت، بدون هیچ پیام "اعطای su" و بدون ترمینال.

## ویژگی‌ها

- **هر شکلی از APK** - یک `.apk` تکی، یک پوشه کامل از APKهای مستقل (batch)، یک آرشیو split گروه‌بندی‌شده
  (`.xapk` / `.apkm` / `.apks` / `.zip`)، یا پوشه‌ای از APKهای split پراکنده.
- **بدون دیوار بررسی** - یک کلید سه‌حالته برای بررسی‌کننده بسته Play Protect: همان‌طور که بود نگه دار
  (فقط در حین نصب خاموش، دقیقا بازگردانده شود)، همیشه روشن، یا همیشه خاموش.
- **صادق درباره Developer Verification** - نصب با روت پیشاپیش از Developer Verification سال ۲۰۲۶ اندروید
  معاف است؛ این کلید در حد تلاش است و همین را می‌گوید، نه یک کلید جعلی.
- **نه "sideloaded"** - به صورت اختیاری منبع نصب را Play Store نشان می‌دهد، هم به عنوان نصب‌کننده (در
  زمان نصب) و هم به عنوان آغازگر (از طریق یک ویرایش `packages.xml` با آگاهی از ABX).
- **جدا و قابل ازسرگیری** - نصب‌ها به صورت یک فرآیند روت جدا اجرا می‌شوند؛ بستن WebUI هرگز آن‌ها را قطع
  نمی‌کند، و UI با شناسه عملیات دوباره متصل می‌شود.
- **انتخاب با شماست** - بسته‌های آزمایشی، اعطای همه مجوزهای runtime، کاربر هدف، دور زدن قفل
  target SDK پایین: همه اختیاری هستند.
- **آفلاین، خودبسنده، بدون ریبوت** - یک ماژول WebUI با باینری‌های همراهش؛ در همان لحظه فلش قابل استفاده
  است.

## عامل‌های هوش مصنوعی

این پروژه از مشارکت‌کنندگان هوش مصنوعی و عامل‌ها استقبال می‌کند. موتور از طریق یک قرارداد headless کوچک
(`scripts/helper.sh <verb> <base64(JSON)>`) به JSON صحبت می‌کند که در
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) مستند شده است، بنابراین یک عامل می‌تواند هر کاری را که WebUI
می‌تواند انجام دهد - WebUI را scrape نکنید. وصله‌های هوش مصنوعی به همان معیار بازبینی هر وصله دیگری
پایبند هستند.

## نصب

زیپ را در KernelSU، APatch یا Magisk فلش کنید و WebUI مربوط به VDInstaller را از مدیر روت خود باز کنید.
نصب‌کننده فقط ABI دستگاه شما را نگه می‌دارد و گیت اجباری یکپارچگی `.sha256` را اجرا می‌کند (در صورت زیپ
خراب یا بریده‌شده متوقف می‌شود). اندروید ۸.۰ (API 26) یا جدیدتر.

## امنیت

VDInstaller به صورت روت اجرا می‌شود و APKهایی را که انتخاب می‌کنید نصب می‌کند؛ خاموش کردن بررسی‌کننده بسته
برای یک نصب، اسکن بدافزار را غیرفعال می‌کند، پس فقط APKهایی را نصب کنید که به آن‌ها اعتماد دارید. هرگز
امنیت دستگاه را بی‌سر و صدا تضعیف نمی‌کند: بررسی‌کننده به صورت پیش‌فرض دقیقا به حالت قبلی‌اش بازگردانده
می‌شود، و هرگز به پیکربندی HMA-OSS شما دست نمی‌زند. مشکلات را مطابق [SECURITY.md](SECURITY.md) گزارش دهید.

## ساخت

همیشه release، هرگز debug. `.github/scripts/build_bin.sh` ابزار `jq` را از مخزن apt مربوط به Termux
(همراه با بسته کتابخانه‌های اشتراکی‌اش) و مبدل‌های مستقل `abx2xml` / `xml2abx` را برای هر چهار ABI
دریافت می‌کند، هر کدام با یک `PROVENANCE.json`. workflow مربوط به release زیپ‌های قابل فلش را سر هم
می‌کند، همراهان `.sha256` را می‌نویسد، `update.json` را پر می‌کند و با `github-actions[bot]` منتشر می‌کند.

## مستندات

راهنماها در [docs/](docs/) قرار دارند و به ویکی GitHub آینه می‌شوند. برای قرارداد headless به
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) مراجعه کنید.

## همچنین ببینید

- **[COPG-VD](https://github.com/VD171/COPG-VD)**: جعل سراسری اثرانگشت دستگاه / Play Integrity، روی کل دستگاه با دامنه‌ی هر اپ و یک WebUI.
- **[VDBackup](https://github.com/VD171/VD-Backup)**: پشتیبان‌گیری و بازیابی کامل اپ‌ها و داده‌ها به‌صورت root، که به‌طور کامل از یک WebUI هدایت می‌شود.
- **[VD-dropbear](https://github.com/VD171/VD-dropbear)**: یک دیمن SSH مستقل با روت (Dropbear).
- **[VDGoogle](https://github.com/VD171/VD-Google)**: سرویس‌های Google شما (RCS، Wallet، گواهی‌های Play Integrity)، خوانده‌شده روی دستگاه شما بدون اینترنت.
- **[VDInfos](https://github.com/VD171/VD-Infos)**: یک اشکال‌زدای روش‌های دستگاه که هر مورد را از طریق همه روش‌هایی که می‌توانند آن را بخوانند می‌خواند و آن‌ها را کنار هم مقایسه می‌کند.
- **[VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)**: یک موتور خودبه‌روزرسانی افزایشی و بدون فلش، تعبیه‌شده در ماژول‌های KernelSU/APatch/Magisk.
- **[VD-Modules](https://github.com/VD171/VD-Modules)**: مخزن ماژول‌های MMRL/WebUI-X ما (همه‌ی آن‌ها را از مدیر root خود نصب کنید).
- **[@VictorGabriel7Dev/build.prop](https://github.com/VictorGabriel7Dev/build.prop)**: یک مجموعه‌داده از اثرانگشت‌های `build.prop` پیکسل (فورک از @T3SL4).
- **[@VictorGabriel7Dev/mtproto-store](https://github.com/VictorGabriel7Dev/mtproto-store)**: از Telegram به‌عنوان ذخیره‌گاه شیء از طریق یک Go CLI کوچک استفاده کنید.

## تماس‌ها

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/VD-Installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## مجوز

VDInstaller تحت GNU AGPL-3.0-or-later مجوز دارد. به [LICENSE](LICENSE) مراجعه کنید. NETWORK COPYLEFT:
یک نسخه اصلاح‌شده را اجرا کنید، حتی به صورت یک سرویس، و باید کد منبع آن را عرضه کنید.

## علامت‌های تجاری

Android، KernelSU، APatch، Magisk، Google Play و Play Protect به صاحبان مربوطه‌شان تعلق دارند. این
پروژه مستقل است و به آن‌ها وابسته نیست و مورد تایید آن‌ها نیز قرار ندارد.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> به کانال بپیوندید: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
