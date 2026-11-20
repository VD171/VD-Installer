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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · فارسی · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# معماری

VDInstaller یک WebUI سبک روی یک موتور شل روت است. هیچ چیزی در رابط کاربری دسترسی ویژه ندارد؛ هر کنش
دارای دسترسی ویژه، یک فراخوانی شل است که یک شیء JSON برمی‌گرداند.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI با JS خالص (بدون فریم‌ورک)، روشن/تاریک، ۲۲ زبان. از طریق پل WebUI مربوط به
  KernelSU (`ksu.exec`) موتور را فراخوانی و پاسخ JSON را تجزیه می‌کند.
- **`scripts/common.sh`** - کتابخانه‌ی مشترکی که هر دو اسکریپت آن را source می‌کنند: resolution مربوط به
  ABI/PATH، رَپِرهای `pm`/`dumpsys`/`fw` (محیط تمیز تا libهای همراهِ Termux هرگز روی libهای ART سایه
  نیندازند)، کمک‌کننده‌های JSON و `jq`، و `xml_edit` سازگار با ABX.
- **`scripts/helper.sh`** - قرارداد WebUI: یک خط JSON به‌ازای هر فراخوانی. فعل‌های کوتاه
  (version، config، browse، scan) به‌صورت درون‌خطی اجرا می‌شوند؛ فعل‌های بلند (install، uninstall) یک
  worker را جدا می‌کنند و یک `opid` برمی‌گردانند.
- **`scripts/worker.sh`** - موتور نصبِ جداشده: چهار حالت نصب، کلید وریفایر، جعل منبع نصب، و API نشست
  مدیر بسته. پیشرفت را در فایلی می‌نویسد که WebUI آن را پایش می‌کند، و در برابر بسته‌شدن WebUI دوام
  می‌آورد (`setsid`، و از فریزرِ اپ می‌گریزد).

## نکات کلیدی

- **از پیش روت.** بدون درخواست «اعطای su» و بدون جابه‌جایی `sucompat`؛ موتور از دل ماژول به‌صورت روت اجرا
  می‌شود و `pm` / `settings` را مستقیماً فراخوانی می‌کند.
- **نصب‌های نشستی.** همه‌ی حالت‌ها از `pm install-create` / `install-write` / `install-commit` استفاده
  می‌کنند، پس اپ‌های اسپلیت به‌درستی نصب می‌شوند و منبع نصب (`-i`) در زمان نشست تنظیم می‌شود.
- **سازگار با ABX.** جعل آغازگر در `packages.xml` به‌دنبال عدد جادویی XML باینری `ABX\0` می‌گردد، دیکد
  می‌کند، ویرایش می‌کند، ری‌انکد می‌کند، برای اعتبارسنجی یک رفت‌وبرگشت انجام می‌دهد، بایت‌به‌بایت پشتیبان
  می‌گیرد و به‌صورت اتمیک جابه‌جا می‌کند؛ تا زمانی که هر مرحله موفق نشود، فایل زنده هرگز دست‌کاری نمی‌شود.
- **بدون ریبوت.** یک ماژول WebUI خودبسنده بدون چیزی برای مانت‌کردن: `customize.sh` آن را در پوشه‌ی
  ماژول‌های فعال کپی می‌کند تا همان لحظه‌ای که فلش شد کار کند.
- **به‌روزرسانی‌های بدون فلش.** موتور همراه‌شده‌ی **VDLU** ماژول را با دانلود تنها فایل‌های تغییریافته،
  آدرس‌دهی‌شده بر اساس محتوا و امضاشده با ed25519 به‌روزرسانی می‌کند - بدون ری‌فلشِ کامل.
- **جداشده.** عملیات‌های بلند خارج از webview اجرا می‌شوند؛ بستن WebUI هرگز آن‌ها را قطع نمی‌کند.

## تضمین سازگاری

- `sh` سازگار با POSIX روی دستگاه (`sh -n` پاس می‌شود؛ بدون بَشیسم فراتر از `local`؛ بدون وابستگی به
  `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` تنها ابزارهای فریم‌ورکِ به‌کاررفته‌اند، همگی از طریق
  `/system/bin`.
- باینری‌های همراه (`jq`، `abx2xml`/`xml2abx`) برای مسیر رایج اختیاری‌اند و منشأ خود را به‌همراه دارند؛
  مبدل ABX در جایی که `/system/bin/abx2xml` خودِ دستگاه موجود باشد به آن بازمی‌گردد.

<!-- doc-footer -->

---

> _این مستندات با Claude (Anthropic) تولید شده و توسط VD171 نگهداری می‌شود. اصلاحات و بهبودها خوش‌آمد است؛ به [CONTRIBUTING.md](CONTRIBUTING.md) مراجعه کنید._
