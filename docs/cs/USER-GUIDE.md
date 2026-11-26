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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · Čeština · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# Uživatelská příručka VDInstaller

## Obsah

1. [Co je VDInstaller](#1-co-je-vdinstaller)
2. [Požadavky](#2-požadavky)
3. [Instalace a první spuštění](#3-instalace-a-první-spuštění)
4. [Prohlídka WebUI](#4-prohlídka-webui)
5. [Instalace APK](#5-instalace-apk)
6. [Možnosti](#6-možnosti)
7. [Ovládání VDInstaller z AI asistenta](#7-ovládání-vdinstaller-z-ai-asistenta)
8. [Řešení problémů a FAQ](#8-řešení-problémů-a-faq)

## 1. Co je VDInstaller

VDInstaller je **WebUI modul** pro KernelSU / APatch / Magisk, který instaluje sideloadované APK jako root
bez tření: žádná výzva "grant su", žádný terminál a žádný boj s verifikátorem Play Protect. Zvládá
jednotlivé APK, celou složku najednou i rozdělené aplikace (`.xapk` / `.apkm` / `.apks` / `.zip` nebo
volné soubory splitů) a dokáže prezentovat zdroj instalace jako Play Store, aby aplikace nevypadala
sideloadovaně.

## 2. Požadavky

- Android 8.0 nebo novější (API 26+).
- Root řešení s podporou WebUI: **KernelSU**, **APatch** nebo **Magisk**.

## 3. Instalace a první spuštění

1. Stáhněte nejnovější `VD-Installer-vX.XX-universal.zip` ze stránky
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Flashněte jej jako modul ve svém root manageru (*Moduly -> Instalovat z úložiště*).
3. VDInstaller se aktivuje **bez restartu** - je soběstačný (WebUI + přibalené binárky), takže není co
   mountovat.
4. Otevřete WebUI **VDInstaller** ze seznamu modulů svého root manageru.

Při flashnutí si instalátor ponechá pouze ABI vašeho zařízení a provede povinnou kontrolu integrity
`.sha256`, která **přeruší** proces, pokud je zip poškozený nebo zkrácený. Nastavení žije v
`/data/adb/vdinstaller` a přežívá aktualizace.

## 4. Prohlídka WebUI

Tři záložky:

- **Install** - vyberte režim, zvolte APK nebo složku, nainstalujte, sledujte živý průběh.
- **Options** - zdroj instalace, přepínač verifikátoru Play Protect a instalační příznaky. Vše se ukládá
  automaticky.
- **About** - verze, co to dělá, požadavky, odkazy a licence.

## 5. Instalace APK

Režim vybíráte na záložce **Install**, VDInstaller nikdy nehádá.

| Režim | Zadáte | Co se stane |
|---|---|---|
| **Single APK** | soubor `.apk` | jedna instalační relace, jedna aplikace. |
| **Folder of APKs** (dávka) | složka nezávislých souborů `.apk` | každé APK se instaluje samostatně, jedno po druhém; částečná dávka nahlásí, které selhaly a proč. |
| **Split archive** | `.xapk` / `.apkm` / `.apks` / `.zip` | rozbalí se, poté se `base.apk` + splity nainstalují jako jedna aplikace v jedné relaci (XAPK OBB se umístí také, je-li přítomno). |
| **Split folder** | složka s volnými soubory splitů `.apk` jedné aplikace | splity se nainstalují jako jedna aplikace v jedné relaci. |

"Split" aplikace je jedno APK rozdělené na základ plus konfigurační APK pro jednotlivé hustoty / ABI /
jazyky, musí se nainstalovat **společně** v jedné relaci, což za vás režimy Split dělají.

### 5.1 Dialog Browse

**Browse** otevře výběr souborů, který na dané cestě zobrazuje složky a instalovatelné soubory:

- Klepnutím na **složku** do ní vejdete, **Up** jde do nadřazené složky.
- V souborovém režimu (Single APK / Split archive) klepnutím na **soubor** jej vyberete.
- Ve složkovém režimu (Folder of APKs / Split folder) přejděte do složky a klepněte na **Use this folder**.

Cestu můžete také přímo napsat nebo vložit (například `/sdcard/Download/app.apk`).

### 5.2 Průběh, zrušení, pokračování

Instalace běží jako **oddělený root proces**. Karta průběhu zobrazuje fázi, **Cancel** ji zastaví. Pokud
WebUI uprostřed instalace zavřete, instalace běží dál a rozhraní se po opětovném otevření znovu připojí
podle ID operace.

## 6. Možnosti

Vše zde se ukládá automaticky a platí pro příští instalaci.

### 6.1 Zdroj instalace

Čerstvě sideloadovaná aplikace oznamuje každé aplikaci, která ji čte (a atestaci), že byla sideloadovaná.
VDInstaller může místo toho prezentovat zdroj jako Play Store.

- **Zobrazit Play Store jako instalátor** (ve výchozím stavu zapnuto) - nastaví `installerPackageName`
  přes `pm install-create -i com.android.vending`. Platí okamžitě.
- **Také podvrhnout iniciátora** (ve výchozím stavu zapnuto) - nastaví `installInitiator` a
  `packageSource` úpravou `/data/system/packages.xml`. Toto je **ABX-aware** (dekódovat -> upravit ->
  znovu zakódovat, se zálohou přesně po bajtech a atomickou výměnou) a platí **po příštím restartu**,
  protože správce balíčků `packages.xml` kešuje.

### 6.2 Verifikátor balíčků Play Protect

Sideloadovaná instalace může být odmítnuta s `INSTALL_FAILED_VERIFICATION_FAILURE` verifikátorem balíčků
Play Protect. Třístavový přepínač:

- **Ponechat tak, jak bylo** (výchozí) - vypnuto jen pro instalaci, poté obnoveno do **přesného**
  předchozího stavu (znovu smazáno, pokud nebyla žádná explicitní hodnota, protože `0`/`1` tam, kde žádná
  nebyla, je sama o sobě prozrazením na stealth zařízení).
- **Vždy zapnuto** - vynutit zapnuto a ponechat.
- **Vždy vypnuto** - vynutit vypnuto a ponechat. WebUI varuje: ponechat to vypnuté je stealth prozrazení a
  vypíná kontrolu malwaru pro každou instalaci.

### 6.3 Developer Verification

Developer Verification Androidu z roku 2026 blokuje instalaci aplikací od neregistrovaných vývojářů na
certifikovaných zařízeních, ale je vynucována **samostatnou službou**, nikoli Play Protect, a **root
instalace je z ní již vyňata** (stejné vynětí, které dostávají instalace přes ADB). VDInstaller instaluje
vaše APK bez ohledu na to, takže tento přepínač je **best-effort a čestný**: skutečný ovladač použije jen
tehdy, pokud nějaký existuje, a nikdy nepředstírá přepnutí přepínače, který nic nedělá.

### 6.4 Instalační příznaky

| Příznak | Účinek |
|---|---|
| **Udělit všechna runtime oprávnění** | udělit každé runtime oprávnění při instalaci (`-g`). |
| **Povolit testovací balíčky** | nainstalovat balíčky označené jako pouze testovací (`-t`). |
| **Obejít blokaci nízkého target SDK** | nainstalovat aplikace s velmi starým `targetSdk`. |
| **Cílový uživatel** | ID uživatele Androidu, pro kterého se instaluje (výchozí `0`). |

### 6.5 Zůstat skrytý

Pro stealth zvažte skrytí svého root manageru a citlivých aplikací pomocí HMA-OSS. VDInstaller **nikdy
nesahá na vaše nastavení HMA-OSS** - nápověda je jen připomínka, změnu provedete sami v HMA-OSS.

## 7. Ovládání VDInstaller z AI asistenta

Engine mluví malou JSON smlouvou přes `scripts/helper.sh`, takže agent může ovládat každou akci, kterou
umí WebUI. Viz [AI-AGENTS](AI-AGENTS). Řiďte smlouvu, nescrapujte WebUI.

## 8. Řešení problémů a FAQ

**Dostávám `INSTALL_FAILED_VERIFICATION_FAILURE`.** To je verifikátor balíčků Play Protect. S přepínačem
verifikátoru ponechaným na **Ponechat tak, jak bylo** (výchozí) jej VDInstaller pro instalaci vypne a
obnoví, takže se to nestane.

**Zapnul jsem zdroj Play Store, ale aplikace stále vypadá sideloadovaně.** Část instalátoru platí
okamžitě, část iniciátora (`packages.xml`) platí **po příštím restartu**.

**Obchází to Developer Verification od Googlu?** Nemusí - root instalace je vyňata (viz 6.3). Není pro to
žádný falešný přepínač.

**Vyžaduje to restart?** Ne, kromě volitelného podvrhu iniciátora.

**Odstraní odinstalace VDInstaller aplikace, které jsem nainstaloval?** Ne - to jsou skutečné instalace
vlastněné systémem, odstranění modulu pouze uklidí vlastní stav VDInstaller.

**Je to bezpečné?** Instaluje APK, která zvolíte, a s vypnutým verifikátorem přeskakuje kontrolu malwaru -
instalujte jen APK, kterým důvěřujete. Nikdy nic tiše neoslabuje.

<!-- doc-footer -->

---

> _Tato dokumentace byla vytvořena pomocí Claude (Anthropic) a spravuje ji VD171. Opravy a vylepšení jsou vítány, viz [CONTRIBUTING.md](CONTRIBUTING.md)._
