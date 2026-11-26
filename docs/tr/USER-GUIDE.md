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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · Türkçe · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# VDInstaller kullanıcı kılavuzu

## İçindekiler

1. [VDInstaller nedir](#1-vdinstaller-nedir)
2. [Gereksinimler](#2-gereksinimler)
3. [Kurulum ve ilk çalıştırma](#3-kurulum-ve-ilk-çalıştırma)
4. [WebUI turu](#4-webui-turu)
5. [APK kurma](#5-apk-kurma)
6. [Seçenekler](#6-seçenekler)
7. [VDInstaller'ı bir yapay zeka asistanıyla kullanma](#7-vdinstallerı-bir-yapay-zeka-asistanıyla-kullanma)
8. [Sorun giderme ve SSS](#8-sorun-giderme-ve-sss)

## 1. VDInstaller nedir

VDInstaller, sideload edilmiş APK'leri root olarak hiçbir sürtünme olmadan kuran bir KernelSU /
APatch / Magisk **WebUI modülüdür**: "su ver" istemi yok, terminal yok ve Play Protect doğrulayıcısıyla
mücadele yok. Tek APK'leri, bir klasörün tamamını tek seferde ve bölünmüş uygulamaları (`.xapk` /
`.apkm` / `.apks` / `.zip` veya dağınık bölüm dosyaları) işler ve bir uygulama sideload edilmiş
görünmesin diye kurulum kaynağını Play Store olarak gösterebilir.

## 2. Gereksinimler

- Android 8.0 veya daha yeni (API 26+).
- WebUI desteği olan bir root çözümü: **KernelSU**, **APatch** veya **Magisk**.

## 3. Kurulum ve ilk çalıştırma

1. En son `VD-Installer-vX.XX-universal.zip` dosyasını
   [Releases](https://github.com/VD171/VD-Installer/releases) sayfasından indirin.
2. Root yöneticinizde bir modül olarak flashlayın (*Modules -> Install from storage*).
3. VDInstaller **yeniden başlatma olmadan** etkinleşir - kendi kendine yeterlidir (WebUI + paketlenmiş
   ikili dosyalar), dolayısıyla bağlanacak bir şey yoktur.
4. Root yöneticinizin modül listesinden **VDInstaller** WebUI'sini açın.

Flash sırasında kurucu yalnızca cihazınızın ABI'sini saklar ve zip bozuk veya kesikse **iptal eden**
zorunlu bir `.sha256` bütünlük kontrolü çalıştırır. Ayarlar `/data/adb/vdinstaller` içinde yaşar ve
güncellemeler boyunca korunur.

## 4. WebUI turu

Üç sekme:

- **Install** - bir mod seçin, APK veya klasörü seçin, kurun, ilerlemeyi canlı izleyin.
- **Options** - kurulum kaynağı, Play Protect doğrulayıcı anahtarı ve kurulum bayrakları. Her şey
  otomatik olarak kaydedilir.
- **About** - sürüm, ne yaptığı, gereksinimler, bağlantılar ve lisans.

## 5. APK kurma

Modu **Install** sekmesinde siz seçersiniz, VDInstaller asla tahmin etmez.

| Mod | Siz verirsiniz | Ne olur |
|---|---|---|
| **Tek APK** | bir `.apk` dosyası | tek kurulum oturumu, tek uygulama. |
| **APK klasörü** (toplu) | bağımsız `.apk` dosyalarından oluşan bir klasör | her APK kendi başına, birbiri ardına kurulur; kısmi bir toplu işlem hangilerinin başarısız olduğunu ve nedenini bildirir. |
| **Bölünmüş arşiv** | bir `.xapk` / `.apkm` / `.apks` / `.zip` | çıkarılır, ardından `base.apk` + bölümler tek bir oturumda tek uygulama olarak kurulur (varsa XAPK OBB de yerleştirilir). |
| **Bölüm klasörü** | tek bir uygulamanın dağınık bölünmüş `.apk` dosyalarını içeren bir klasör | bölümler tek bir oturumda tek uygulama olarak kurulur. |

"Bölünmüş" bir uygulama, bir tabana artı yoğunluk başına / ABI başına / dil başına yapılandırma
APK'lerine ayrılmış bir APK'dir, bunlar bir oturumda **birlikte** kurulmalıdır ve bölme modları bunu
sizin için yapar.

### 5.1 Gözat iletişim kutusu

**Browse**, bir yoldaki klasörleri ve kurulabilir dosyaları listeleyen bir dosya seçici açar:

- İçine girmek için bir **klasöre** dokunun, **Up** üst klasöre gider.
- Bir dosya modunda (Tek APK / Bölünmüş arşiv), seçmek için bir **dosyaya** dokunun.
- Bir klasör modunda (APK klasörü / Bölüm klasörü), klasörün içine gidin ve **Use this folder**'a
  dokunun.

Ayrıca bir yolu doğrudan yazabilir veya yapıştırabilirsiniz (örneğin `/sdcard/Download/app.apk`).

### 5.2 İlerleme, iptal, sürdürme

Kurulumlar **ayrılmış bir root işlemi** olarak çalışır. Bir ilerleme kartı aşamayı gösterir, **Cancel**
onu durdurur. Kurulumun ortasında WebUI'yi kapatırsanız kurulum devam eder ve arayüz yeniden
açtığınızda işlem kimliğine göre yeniden bağlanır.

## 6. Seçenekler

Buradaki her şey otomatik olarak kaydedilir ve bir sonraki kuruluma uygulanır.

### 6.1 Kurulum kaynağı

Yeni sideload edilmiş bir uygulama, onu okuyan her uygulamaya (ve belgelendirmeye) sideload edildiğini
bildirir. VDInstaller bunun yerine kaynağı Play Store olarak gösterebilir.

- **Play Store'u kurucu olarak göster** (varsayılan açık) - `pm install-create -i com.android.vending`
  aracılığıyla `installerPackageName` ayarlar. Hemen uygulanır.
- **Başlatıcıyı da taklit et** (varsayılan açık) - `/data/system/packages.xml` dosyasını düzenleyerek
  `installInitiator` ve `packageSource` ayarlar. Bu **ABX-farkındadır** (çöz -> düzenle -> yeniden
  kodla, byte düzeyinde tam bir yedek ve atomik bir takasla) ve paket yöneticisi `packages.xml`
  dosyasını önbelleğe aldığı için **bir sonraki yeniden başlatmadan sonra** uygulanır.

### 6.2 Play Protect paket doğrulayıcısı

Sideload edilmiş bir kurulum, Play Protect'in paket doğrulayıcısı tarafından
`INSTALL_FAILED_VERIFICATION_FAILURE` ile reddedilebilir. 3 yönlü bir anahtar:

- **Olduğu gibi bırak** (varsayılan) - yalnızca kurulum için kapalı, sonra **tam olarak** önceki
  durumuna geri yüklenir (açık bir değer yoksa yeniden silinir, çünkü hiçbir değer olmayan yerde bir
  `0`/`1` kendisi bir stealth cihazında ele veren bir işarettir).
- **Her zaman açık** - zorla aç ve tut.
- **Her zaman kapalı** - zorla kapat ve tut. WebUI uyarır: kapalı bırakmak bir stealth ipucudur ve her
  kurulum için bir kötü amaçlı yazılım taramasını devre dışı bırakır.

### 6.3 Developer Verification

Android'in 2026 Developer Verification özelliği, sertifikalı cihazlarda kayıtlı olmayan
geliştiricilerden uygulama kurmayı engeller, ancak bu Play Protect tarafından değil **ayrı bir hizmet**
tarafından uygulanır ve bir **root kurulumu zaten muaftır** (ADB kurulumlarının aldığı muafiyetin
aynısı). VDInstaller APK'lerinizi yine de kurar, bu yüzden bu anahtar **elinden gelenin en iyisini
yapan ve dürüsttür**: gerçek bir düğme yalnızca varsa uygular ve hiçbir şey yapmayan bir anahtarı
çevirdiğini asla iddia etmez.

### 6.4 Kurulum bayrakları

| Bayrak | Etki |
|---|---|
| **Tüm çalışma zamanı izinlerini ver** | kurulumda her çalışma zamanı iznini ver (`-g`). |
| **Test paketlerine izin ver** | yalnızca test olarak işaretlenmiş paketleri kur (`-t`). |
| **Düşük hedef SDK engelini atla** | çok eski bir `targetSdk` değerine sahip uygulamaları kur. |
| **Hedef kullanıcı** | kurulumun yapılacağı Android kullanıcı kimliği (varsayılan `0`). |

### 6.5 Gizli kalmak

Stealth için root yöneticinizi ve hassas uygulamalarınızı HMA-OSS ile gizlemeyi düşünün. VDInstaller
**HMA-OSS kurulumunuza asla dokunmaz** - bu ipucu yalnızca bir hatırlatmadır, değişikliği HMA-OSS
içinde kendiniz yaparsınız.

## 7. VDInstaller'ı bir yapay zeka asistanıyla kullanma

Motor, `scripts/helper.sh` üzerinden küçük bir JSON sözleşmesi konuşur, böylece bir ajan WebUI'nin
yapabildiği her işlemi yürütebilir. [AI-AGENTS](AI-AGENTS) bölümüne bakın. Sözleşmeyi kullanın, WebUI'yi
kazımayın.

## 8. Sorun giderme ve SSS

**`INSTALL_FAILED_VERIFICATION_FAILURE` alıyorum.** Bu, Play Protect'in paket doğrulayıcısıdır.
Doğrulayıcı anahtarı **Olduğu gibi bırak** (varsayılan) konumundayken VDInstaller onu kurulum için
kapatır ve geri yükler, böylece bu olmaz.

**Play Store kaynağını açtım ama uygulama hâlâ sideload edilmiş görünüyor.** Kurucu kısmı hemen
uygulanır, başlatıcı kısmı (`packages.xml`) **bir sonraki yeniden başlatmadan sonra** uygulanır.

**Google'ın Developer Verification özelliğini atlıyor mu?** Buna gerek yok - bir root kurulumu muaftır
(bkz. 6.3). Bunun için sahte bir anahtar yoktur.

**Yeniden başlatma gerektiriyor mu?** İsteğe bağlı başlatıcı taklidi dışında hayır.

**VDInstaller'ı kaldırmak kurduğum uygulamaları siler mi?** Hayır - bunlar sistemin sahip olduğu
gerçek kurulumlardır, modülü kaldırmak yalnızca VDInstaller'ın kendi durumunu temizler.

**Güvenli mi?** Seçtiğiniz APK'leri kurar ve doğrulayıcı kapalıyken bir kötü amaçlı yazılım taramasını
atlar - yalnızca güvendiğiniz APK'leri kurun. Hiçbir şeyi asla sessizce zayıflatmaz.

<!-- doc-footer -->

---

> _Bu belgeler Claude (Anthropic) ile oluşturulmuş olup VD171 tarafından yürütülmektedir. Düzeltmeler ve iyileştirmeler memnuniyetle karşılanır, bkz. [CONTRIBUTING.md](CONTRIBUTING.md)._
