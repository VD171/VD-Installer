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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · Türkçe · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Paketlenmiş ikili dosyalar: köken ve denetim

## İlkeler

- Hiçbir belirsiz şey gönderilmez. Paketlenmiş her ikili dosya **derleme zamanında kendi resmi
  kaynağından** getirilir, asla bir cihazdan çekilmez ve her dosya, yükün yeniden üretilebilmesi için
  bir sha256 taşır.
- İkili dosyalar **dört ABI'nin tümü** için paketlenir (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`);
  flash kurucusu cihazın tek ABI'sine budar.
- Bağımsız çalışırlar: her ikili dosyanın paylaşılan kitaplık kapanışı yanında gönderilir ve motor
  `LD_LIBRARY_PATH` değerini paketlenmiş `lib/` dizinine ayarlar, böylece Termux'un kurulu olmasına
  bağımlılık yoktur.

## Ne gönderilir ve nereden

| İkili | Nereden | Neden |
|---|---|---|
| `jq` (+ `lib/`) | Termux paket deposu (`packages.termux.dev/apt`), resmi `.deb` | motor JSON konuşur; `jq` argümanları ayrıştırır ve yanıtlar oluşturur. |
| `abx2xml` / `xml2abx` | [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) sürümü | cihazın `/system/bin/abx2xml` dosyasına sahip olmadığı yerlerde (A12 öncesi), `packages.xml` kurulum kaynağı taklidi için Android ikili XML'ini (ABX) çözer/kodlar. Mevcut olduğunda cihazın kendi dönüştürücüsü tercih edilir. |
| `vdlu/verify/<abi>/ed25519-mini` | kanonik [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) motoru | flashsız (VDLU) güncellemelerdeki ed25519 imzasını OpenSSL olmadan doğrular. |

Derleme adımı `.github/scripts/build_bin.sh`'dir: Termux paketini artı onun geçişli bağımlılıklarını
çözer, `.deb` dosyalarını çıkarır, istenen ikili dosyaları ve her birinin ihtiyaç duyduğu paylaşılan
kitaplık kapanışını (`readelf` ile çözülmüş) kopyalar, ardından bağımsız ABX dönüştürücüyü getirir.

## Cihaz üzerindeki bildirim: `PROVENANCE.json`

Her `bin/<abi>/`, gönderilen her dosyayı (yol, boyut, sha256) ve her birinin kaynak kökenini (paket,
sürüm, URL, arşiv sha256'sı) listeleyen bir `PROVENANCE.json` taşır. Cihaz üzerindeki ABI budamasından
sağ çıkar, böylece denetim izi modülün kendisiyle birlikte gönderilir.

## Nasıl doğrulanır

1. Cihazda veya flashlanabilir zip içinde `bin/<abi>/PROVENANCE.json` dosyasını açın.
2. Her sabitlenmiş kaynağı kaydettiği URL'den yeniden getirin.
3. Her dosyanın sha256'sını çıkarın ve bildirimle karşılaştırın.

Flashlanabilir zip, ayrıca gönderilen her dosyanın yanında bir `.sha256` eşlikçisi taşır;
`customize.sh` bunları flash zamanında doğrular ve herhangi bir uyuşmazlıkta **iptal eder** (bozuk veya
kesik bir zip).

## Raporlama

Bir uyuşmazlık veya bir köken endişesi mi buldunuz? Bunu özel olarak bildirin - bkz.
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Bu belgeler Claude (Anthropic) ile oluşturulmuş olup VD171 tarafından yürütülmektedir. Düzeltmeler ve iyileştirmeler memnuniyetle karşılanır, bkz. [CONTRIBUTING.md](CONTRIBUTING.md)._
