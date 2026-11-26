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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · Polski · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# Przewodnik użytkownika VDInstaller

## Spis treści

1. [Czym jest VDInstaller](#1-czym-jest-vdinstaller)
2. [Wymagania](#2-wymagania)
3. [Instalacja i pierwsze uruchomienie](#3-instalacja-i-pierwsze-uruchomienie)
4. [Przewodnik po WebUI](#4-przewodnik-po-webui)
5. [Instalowanie APK](#5-instalowanie-apk)
6. [Opcje](#6-opcje)
7. [Sterowanie VDInstaller z asystenta AI](#7-sterowanie-vdinstaller-z-asystenta-ai)
8. [Rozwiązywanie problemów i FAQ](#8-rozwiązywanie-problemów-i-faq)

## 1. Czym jest VDInstaller

VDInstaller to **moduł WebUI** dla KernelSU / APatch / Magisk, który instaluje pobrane z zewnątrz
pakiety APK jako root, bez żadnych przeszkód: bez okienka "przyznaj su", bez terminala i bez walki z
weryfikatorem Play Protect. Obsługuje pojedyncze pliki APK, cały folder naraz oraz aplikacje dzielone
(`.xapk` / `.apkm` / `.apks` / `.zip` lub luźne pliki split), a także potrafi przedstawić źródło
instalacji jako Play Store, dzięki czemu aplikacja nie wygląda na zainstalowaną spoza sklepu.

## 2. Wymagania

- Android 8.0 lub nowszy (API 26+).
- Rozwiązanie root z obsługą WebUI: **KernelSU**, **APatch** lub **Magisk**.

## 3. Instalacja i pierwsze uruchomienie

1. Pobierz najnowszy plik `VD-Installer-vX.XX-universal.zip` ze strony
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Zainstaluj go jako moduł w swoim menedżerze root (*Moduły -> Zainstaluj z pamięci*).
3. VDInstaller aktywuje się **bez restartu** - jest samowystarczalny (WebUI + dołączone binaria), więc
   nie ma nic do zamontowania.
4. Otwórz WebUI **VDInstaller** z listy modułów swojego menedżera root.

Podczas instalacji flashem instalator zachowuje tylko ABI twojego urządzenia i uruchamia obowiązkową
bramkę integralności `.sha256`, która **przerywa** proces, jeśli archiwum zip jest uszkodzone lub
niepełne. Ustawienia znajdują się w `/data/adb/vdinstaller` i przetrwają aktualizacje.

## 4. Przewodnik po WebUI

Trzy karty:

- **Install** - wybierz tryb, wskaż plik APK lub folder, zainstaluj, obserwuj postęp na żywo.
- **Options** - źródło instalacji, przełącznik weryfikatora Play Protect i flagi instalacji. Wszystko
  zapisuje się automatycznie.
- **About** - wersja, co robi, wymagania, linki i licencja.

## 5. Instalowanie APK

Tryb wybierasz na karcie **Install**, VDInstaller nigdy nie zgaduje.

| Tryb | Co podajesz | Co się dzieje |
|---|---|---|
| **Single APK** | plik `.apk` | jedna sesja instalacji, jedna aplikacja. |
| **Folder of APKs** (wsadowo) | folder niezależnych plików `.apk` | każdy APK jest instalowany osobno, jeden po drugim; częściowo udana partia zgłasza, które się nie powiodły i dlaczego. |
| **Split archive** | plik `.xapk` / `.apkm` / `.apks` / `.zip` | wypakowany, następnie `base.apk` + splity instalowane jako jedna aplikacja w jednej sesji (OBB z XAPK też jest umieszczane, jeśli obecne). |
| **Split folder** | folder z luźnymi plikami `.apk` splitów jednej aplikacji | splity instalowane jako jedna aplikacja w jednej sesji. |

Aplikacja "split" to jeden APK podzielony na bazę plus konfiguracyjne pakiety APK per gęstość / per ABI
/ per język, muszą być instalowane **razem** w jednej sesji, co tryby Split robią za ciebie.

### 5.1 Okno Browse

**Browse** otwiera selektor plików, który pokazuje foldery i instalowalne pliki w danej ścieżce:

- Dotknij **folder**, aby do niego wejść, **Up** przechodzi do katalogu nadrzędnego.
- W trybie plikowym (Single APK / Split archive) dotknij **plik**, aby go wybrać.
- W trybie folderowym (Folder of APKs / Split folder) wejdź do folderu i dotknij **Use this folder**.

Możesz też wpisać lub wkleić ścieżkę bezpośrednio (na przykład `/sdcard/Download/app.apk`).

### 5.2 Postęp, anulowanie, wznawianie

Instalacje działają jako **odłączony proces root**. Karta postępu pokazuje fazę, **Cancel** zatrzymuje
proces. Jeśli zamkniesz WebUI w trakcie instalacji, instalacja trwa dalej, a interfejs ponownie się do
niej podłącza po identyfikatorze operacji, gdy go znowu otworzysz.

## 6. Opcje

Wszystko tutaj zapisuje się automatycznie i obowiązuje przy następnej instalacji.

### 6.1 Źródło instalacji

Świeżo zainstalowana spoza sklepu aplikacja ogłasza każdej aplikacji, która to odczytuje (oraz
atestacji), że została zainstalowana sideloadem. VDInstaller może zamiast tego przedstawić źródło jako
Play Store.

- **Show the Play Store as installer** (domyślnie włączone) - ustawia `installerPackageName` przez
  `pm install-create -i com.android.vending`. Działa natychmiast.
- **Also spoof the initiator** (domyślnie włączone) - ustawia `installInitiator` i `packageSource`
  poprzez edycję `/data/system/packages.xml`. Jest to **świadome ABX** (dekoduj -> edytuj -> zakoduj
  ponownie, z kopią zapasową co do bajtu i atomową podmianą) i działa **po następnym restarcie**,
  ponieważ menedżer pakietów buforuje `packages.xml`.

### 6.2 Weryfikator pakietów Play Protect

Instalacja spoza sklepu może zostać odrzucona przez weryfikator pakietów Play Protect z błędem
`INSTALL_FAILED_VERIFICATION_FAILURE`. Przełącznik 3-stanowy:

- **Keep as it was** (domyślnie) - wyłączony tylko na czas instalacji, potem przywrócony do **dokładnie**
  poprzedniego stanu (ponownie usunięty, jeśli nie było jawnej wartości, ponieważ `0`/`1` tam, gdzie go
  nie było, samo w sobie zdradza urządzenie w trybie stealth).
- **Always on** - wymuś włączenie i zachowaj.
- **Always off** - wymuś wyłączenie i zachowaj. WebUI ostrzega: pozostawienie go wyłączonego zdradza
  tryb stealth i wyłącza skanowanie w poszukiwaniu złośliwego oprogramowania przy każdej instalacji.

### 6.3 Weryfikacja deweloperska

Weryfikacja deweloperska Androida z 2026 roku blokuje instalowanie aplikacji od niezarejestrowanych
deweloperów na certyfikowanych urządzeniach, ale jest egzekwowana przez **oddzielną usługę**, a nie
Play Protect, a **instalacja z roota jest już z niej zwolniona** (to samo zwolnienie, które dostają
instalacje przez ADB). VDInstaller instaluje twoje pliki APK niezależnie, więc ten przełącznik jest
**najlepszym możliwym i uczciwym podejściem**: stosuje realne ustawienie tylko wtedy, gdy takie
istnieje, i nigdy nie udaje, że przełącza coś, co nic nie robi.

### 6.4 Flagi instalacji

| Flaga | Efekt |
|---|---|
| **Grant all runtime permissions** | przyznaj każde uprawnienie runtime przy instalacji (`-g`). |
| **Allow test packages** | zainstaluj pakiety oznaczone jako tylko testowe (`-t`). |
| **Bypass low target SDK block** | zainstaluj aplikacje z bardzo starym `targetSdk`. |
| **Target user** | identyfikator użytkownika Androida, dla którego instalować (domyślnie `0`). |

### 6.5 Pozostawanie w ukryciu

Dla trybu stealth rozważ ukrycie menedżera root i wrażliwych aplikacji za pomocą HMA-OSS. VDInstaller
**nigdy nie dotyka twojej konfiguracji HMA-OSS** - wskazówka jest tylko przypomnieniem, zmianę
wprowadzasz sam w HMA-OSS.

## 7. Sterowanie VDInstaller z asystenta AI

Silnik mówi w małym kontrakcie JSON przez `scripts/helper.sh`, więc agent może wykonać każdą akcję,
którą potrafi WebUI. Zobacz [AI-AGENTS](AI-AGENTS). Steruj kontraktem, nie zeskrobuj WebUI.

## 8. Rozwiązywanie problemów i FAQ

**Dostaję `INSTALL_FAILED_VERIFICATION_FAILURE`.** To weryfikator pakietów Play Protect. Przy
przełączniku weryfikatora ustawionym na **Keep as it was** (domyślnie) VDInstaller wyłącza go na czas
instalacji i przywraca, więc to się nie dzieje.

**Włączyłem źródło Play Store, ale aplikacja nadal wygląda na zainstalowaną spoza sklepu.** Część
dotycząca instalatora działa natychmiast, część dotycząca inicjatora (`packages.xml`) działa **po
następnym restarcie**.

**Czy omija Weryfikację deweloperską Google?** Nie musi - instalacja z roota jest zwolniona (zobacz
6.3). Nie ma dla niej fałszywego przełącznika.

**Czy wymaga restartu?** Nie, poza opcjonalnym podszyciem się pod inicjatora.

**Czy odinstalowanie VDInstaller usunie zainstalowane przeze mnie aplikacje?** Nie - to są prawdziwe
instalacje należące do systemu, usunięcie modułu czyści tylko własny stan VDInstaller.

**Czy to bezpieczne?** Instaluje wybrane przez ciebie pliki APK i, przy wyłączonym weryfikatorze,
pomija skanowanie w poszukiwaniu złośliwego oprogramowania - instaluj tylko APK, którym ufasz. Nigdy
niczego nie osłabia po cichu.

<!-- doc-footer -->

---

> _Ta dokumentacja została wygenerowana za pomocą Claude (Anthropic) i jest utrzymywana przez VD171. Poprawki i ulepszenia są mile widziane, zobacz [CONTRIBUTING.md](CONTRIBUTING.md)._
