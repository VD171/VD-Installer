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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · Polski · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Architektura

VDInstaller to cienki WebUI nad silnikiem powłoki działającym jako root. Nic w interfejsie nie ma
uprawnień; każda uprzywilejowana akcja to jedno wywołanie powłoki, które zwraca jeden obiekt JSON.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI w czystym JS (bez frameworka), jasny/ciemny, 22 języki. Wywołuje silnik przez
  mostek WebUI KernelSU (`ksu.exec`) i parsuje odpowiedź JSON.
- **`scripts/common.sh`** - współdzielona biblioteka dołączana przez oba skrypty: rozwiązywanie ABI/PATH,
  nakładki `pm`/`dumpsys`/`fw` (czyste środowisko, aby dołączone biblioteki Termux nigdy nie przesłaniały
  bibliotek ART), pomocniki JSON i `jq` oraz świadome ABX `xml_edit`.
- **`scripts/helper.sh`** - kontrakt WebUI: jedna linia JSON na wywołanie. Krótkie czasowniki (version,
  config, browse, scan) działają w miejscu; długie (install, uninstall) odłączają workera i zwracają
  `opid`.
- **`scripts/worker.sh`** - odłączony silnik instalacji: cztery tryby instalacji, przełącznik
  weryfikatora, podszycie się pod źródło instalacji oraz API sesji menedżera pakietów. Zapisuje postęp do
  pliku, który odpytuje WebUI, i przeżywa zamknięcie WebUI (`setsid`, i wymyka się zamrażaczowi
  aplikacji).

## Kluczowe punkty

- **Już root.** Brak okienka "przyznaj su" i brak przełączania `sucompat`; silnik działa jako root z
  modułu i wywołuje `pm` / `settings` bezpośrednio.
- **Instalacje sesyjne.** Wszystkie tryby używają `pm install-create` / `install-write` /
  `install-commit`, więc aplikacje dzielone instalują się poprawnie, a źródło instalacji (`-i`) jest
  ustawiane w czasie sesji.
- **Świadomość ABX.** Podszycie się pod inicjatora w `packages.xml` sprawdza magiczną sygnaturę binarnego
  XML `ABX\0`, dekoduje, edytuje, koduje ponownie, wykonuje obieg tam i z powrotem w celu walidacji,
  tworzy kopię zapasową co do bajtu i podmienia atomowo; żywy plik nigdy nie jest dotykany, chyba że każdy
  krok się powiedzie.
- **Bez restartu.** Samowystarczalny moduł WebUI bez niczego do zamontowania: `customize.sh` kopiuje go do
  katalogu aktywnych modułów, więc działa w chwili zainstalowania flashem.
- **Aktualizacje bez flashowania.** Dołączony silnik **VDLU** aktualizuje moduł, pobierając tylko
  zmienione, adresowane treścią, podpisane ed25519 pliki - bez pełnego ponownego flashowania.
- **Odłączone.** Długie operacje działają poza widokiem webview; zamknięcie WebUI nigdy ich nie przerywa.

## Gwarancja kompatybilności

- POSIX `sh` na urządzeniu (`sh -n` przechodzi; brak bashizmów poza `local`; brak zależności od `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` to jedyne używane narzędzia frameworka, wszystkie przez
  `/system/bin`.
- Dołączone binaria (`jq`, `abx2xml`/`xml2abx`) są opcjonalne dla typowej ścieżki i niosą pochodzenie;
  konwerter ABX wraca do własnego `/system/bin/abx2xml` urządzenia tam, gdzie jest obecny.

<!-- doc-footer -->

---

> _Ta dokumentacja została wygenerowana za pomocą Claude (Anthropic) i jest utrzymywana przez VD171. Poprawki i ulepszenia są mile widziane; zobacz [CONTRIBUTING.md](CONTRIBUTING.md)._
