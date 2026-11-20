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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · Türkçe · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Katkıda Bulunma

Katkılar memnuniyetle karşılanır - sorunlar (issues), pull request'ler, çeviriler ve belgeler. Proje,
katkıda bulunmanın kolay ve davetkar olmasını amaçlar.

## Yapay zeka katkıcıları hoş geldiniz

Yapay zeka ve ajan katkıları herkesle aynı inceleme çıtasında karşılanır. Motor, headless bir sözleşme
üzerinden JSON konuşur (`scripts/helper.sh <verb> <base64(JSON)>`); bkz.
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Sözleşmeyi sürün, WebUI'yi kazımayın.

## Kod kuralları

- Her kaynak dosyanın başında **dosya başına eksiksiz banner** (SPDX + iletişim bilgileri). Asla kırpılmış olanı.
- Kod, tanımlayıcılar, günlükler ve yorumlar **İngilizce**. Yorumlar yalnızca bir şey kattığında.
- Cihaz için kabuk **POSIX sh**'dir (`sh -n` geçmelidir; `local` dışında bashism yok; paketlenmiş `jq` PATH'te olmadan önce çalışması gereken kod yollarında `jq` bağımlılığı yok).
- WebUI **vanilla JS**'dir, çerçeve yok; tüm arayüzde açık ve koyu.
- **Asla** em-dash veya en-dash; her zaman bir tire `-`.
- Yapı her zaman **release**'dir, asla debug değil.
- Bir şeyin geçmesini sağlamak için **gerçek bir davranışı asla zayıflatmayın** ve asla içerik kaldırmayın.

## Çeviriler

WebUI dizeleri `module/webroot/lang/<code>.json` içinde bulunur (düz anahtarlar, İngilizce temel
`lang/en.js` içinde); README'nin dil başına bir `README.<code>.md` dosyası vardır. Bir dil ekleyin veya düzeltin ve bir PR açın.

## Lisans

Katkıda bulunarak, katkınızın GNU AGPL-3.0-or-later altında lisanslandığını kabul edersiniz.

<!-- doc-footer -->

---

> _Bu belgeler Claude (Anthropic) ile oluşturulmuş olup VD171 tarafından yürütülmektedir. Düzeltmeler ve iyileştirmeler memnuniyetle karşılanır; bkz. [CONTRIBUTING.md](CONTRIBUTING.md)._
