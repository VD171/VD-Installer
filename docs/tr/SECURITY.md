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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · Türkçe · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# Güvenlik Politikası

## Tek satırda tehdit modeli

VDInstaller root olarak çalışır ve kullanıcının açıkça seçtiği APK'leri yükler, bir yükleme için Play
Protect doğrulayıcısını kapatmak bir kötü amaçlı yazılım taramasını devre dışı bırakır, bu nedenle bu
"güvenli yükleme" değil, "sürtünmesiz yükleme"dir - yalnızca güvendiğiniz APK'leri yükleyin.

## Ne yapar ve ne yapmaz

- Paket doğrulayıcısını varsayılan olarak tam olarak önceki durumuna geri yükler (hiç olmayan yerde bir
  `0`/`1` bırakmak başlı başına bir ipucudur, bu yüzden tekrar silinir).
- HMA-OSS kurulumunuza asla dokunmaz, uygulamaları gizlemek sizin uygulayacağınız bir öneridir.
- `packages.xml` yükleme kaynağı düzenlemesi ABX-farkındadır, herhangi bir değişiklikten önce canlı dosyayı
  bayt düzeyinde yedekler, doğrulamak için round-trip yapar ve herhangi bir hatada canlı dosyayı dokunulmadan bırakır.
- Paketlenmiş ikili dosyalar yapı sırasında resmi upstream'lerinden getirilir ve bir `PROVENANCE.json` taşır.

## Bir güvenlik açığı bildirme

Lütfen önce özel olarak bildirin. Yeniden oluşturma adımlarını, etkilenen sürümü ve etkisini ekleyin.

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

> _Bu belgeler Claude (Anthropic) ile oluşturulmuş olup VD171 tarafından yürütülmektedir. Düzeltmeler ve iyileştirmeler memnuniyetle karşılanır, bkz. [CONTRIBUTING.md](CONTRIBUTING.md)._
