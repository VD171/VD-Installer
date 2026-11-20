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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · Türkçe · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Mimari

VDInstaller, bir root kabuk motorunun üzerindeki ince bir WebUI'dir. Arayüzdeki hiçbir şeyin ayrıcalığı
yoktur; her ayrıcalıklı işlem, tek bir JSON nesnesi döndüren tek bir kabuk çağrısıdır.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - saf JS WebUI (çerçeve yok), açık/koyu, 22 dil. Motora KernelSU WebUI köprüsü
  (`ksu.exec`) üzerinden çağrı yapar ve JSON yanıtını ayrıştırır.
- **`scripts/common.sh`** - her iki betiğin de kaynak olarak aldığı ortak kitaplık: ABI/PATH çözümü,
  `pm`/`dumpsys`/`fw` sarmalayıcıları (paketlenmiş Termux kitaplıkları ART'ınkileri asla gölgelemesin
  diye temiz ortam), JSON ve `jq` yardımcıları ve ABX-farkında `xml_edit`.
- **`scripts/helper.sh`** - WebUI sözleşmesi: çağrı başına bir JSON satırı. Kısa fiiller (version,
  config, browse, scan) satır içi çalışır; uzun olanlar (install, uninstall) bir worker ayırır ve bir
  `opid` döndürür.
- **`scripts/worker.sh`** - ayrılmış kurulum motoru: dört kurulum modu, doğrulayıcı anahtarı, kurulum
  kaynağı taklidi ve paket yöneticisi oturum API'si. WebUI'nin yokladığı bir dosyaya ilerlemeyi yazar
  ve WebUI kapatılsa bile yaşamaya devam eder (`setsid` ve uygulama dondurucusundan kaçar).

## Temel noktalar

- **Zaten root.** "su ver" istemi yok ve `sucompat` anahtarlaması yok; motor modülden root olarak
  çalışır ve doğrudan `pm` / `settings` çağırır.
- **Oturum kurulumları.** Tüm modlar `pm install-create` / `install-write` / `install-commit`
  kullanır, böylece bölünmüş uygulamalar doğru kurulur ve kurulum kaynağı (`-i`) oturum zamanında
  ayarlanır.
- **ABX-farkında.** `packages.xml` başlatıcı taklidi, `ABX\0` ikili-XML sihirli dizisini kontrol eder,
  çözer, düzenler, yeniden kodlar, doğrulamak için gidip gelir, byte düzeyinde tam yedekler ve atomik
  olarak takas eder; her adım geçmedikçe canlı dosyaya asla dokunulmaz.
- **Yeniden başlatma gerektirmez.** Bağlanacak hiçbir şeyi olmayan kendi kendine yeten bir WebUI
  modülü: `customize.sh` onu etkin modül dizinine kopyalar, böylece flashlanır flashlanmaz çalışır.
- **Flashsız güncellemeler.** Paketlenmiş **VDLU** motoru, modülü yalnızca değişen, içerik adresli,
  ed25519 imzalı dosyaları indirerek günceller - tam bir yeniden flash yok.
- **Ayrılmış.** Uzun işlemler webview dışında çalışır; WebUI'yi kapatmak onları asla kesmez.

## Uyumluluk garantisi

- Cihazda POSIX `sh` (`sh -n` geçer; `local` dışında bashism yok; `awk` bağımlılığı yok).
- Kullanılan tek çerçeve araçları `pm` / `dumpsys` / `settings` / `cmd`'dir, hepsi `/system/bin`
  üzerinden.
- Paketlenmiş ikili dosyalar (`jq`, `abx2xml`/`xml2abx`) yaygın yol için isteğe bağlıdır ve köken
  taşır; ABX dönüştürücü, mevcut olduğu yerlerde cihazın kendi `/system/bin/abx2xml` dosyasına geri
  döner.

<!-- doc-footer -->

---

> _Bu belgeler Claude (Anthropic) ile oluşturulmuş olup VD171 tarafından yürütülmektedir. Düzeltmeler ve iyileştirmeler memnuniyetle karşılanır; bkz. [CONTRIBUTING.md](CONTRIBUTING.md)._
