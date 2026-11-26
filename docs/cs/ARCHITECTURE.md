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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · Čeština · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Architektura

VDInstaller je tenká WebUI nad root shell enginem. Nic v rozhraní nemá oprávnění, každá privilegovaná akce
je jedno shell volání, které vrací jeden JSON objekt.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - čisté JS WebUI (bez frameworku), světlé/tmavé, 22 jazyků. Volá engine přes most
  KernelSU WebUI (`ksu.exec`) a parsuje JSON odpověď.
- **`scripts/common.sh`** - sdílená knihovna načítaná oběma skripty: rozlišení ABI/PATH, obaly
  `pm`/`dumpsys`/`fw` (čisté prostředí, aby přibalené Termux knihovny nikdy nezastínily knihovny ART),
  pomocníci pro JSON a `jq` a ABX-aware `xml_edit`.
- **`scripts/helper.sh`** - WebUI smlouva: jeden JSON řádek na volání. Krátká slovesa (version, config,
  browse, scan) běží inline, dlouhá (install, uninstall) oddělí workera a vrátí `opid`.
- **`scripts/worker.sh`** - oddělený instalační engine: čtyři instalační režimy, přepínač verifikátoru,
  podvrh zdroje instalace a session API správce balíčků. Zapisuje průběh do souboru, který WebUI dotazuje,
  a přežije zavření WebUI (`setsid`, a uniká zmrazovači aplikací).

## Klíčové body

- **Už jako root.** Žádná výzva "grant su" ani přepínání `sucompat`, engine běží jako root z modulu a volá
  `pm` / `settings` přímo.
- **Session instalace.** Všechny režimy používají `pm install-create` / `install-write` /
  `install-commit`, takže rozdělené aplikace se instalují správně a zdroj instalace (`-i`) se nastaví v
  čase session.
- **ABX-aware.** Podvrh iniciátora v `packages.xml` kontroluje binární XML magic `ABX\0`, dekóduje,
  upravuje, znovu zakóduje, provede round-trip pro ověření, zálohuje přesně po bajtech a vymění atomicky;
  živý soubor se nikdy nedotkne, pokud neprojde každý krok.
- **Bez restartu.** Soběstačný WebUI modul, u kterého není co mountovat: `customize.sh` jej zkopíruje do
  adresáře aktivních modulů, takže funguje v okamžiku, kdy je flashnut.
- **Flashless aktualizace.** Přibalený engine **VDLU** aktualizuje modul stažením pouze změněných,
  obsahově adresovaných, ed25519 podepsaných souborů - bez plného přeflashnutí.
- **Oddělené.** Dlouhé operace běží mimo webview, zavření WebUI je nikdy nepřeruší.

## Záruka kompatibility

- POSIX `sh` na zařízení (`sh -n` projde, žádné bashismy nad rámec `local`, žádná závislost na `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` jsou jediné použité framework nástroje, všechny přes `/system/bin`.
- Přibalené binárky (`jq`, `abx2xml`/`xml2abx`) jsou pro běžnou cestu volitelné a nesou provenienci, ABX
  konvertor se vrací k vlastnímu `/system/bin/abx2xml` zařízení tam, kde je přítomen.

<!-- doc-footer -->

---

> _Tato dokumentace byla vytvořena pomocí Claude (Anthropic) a spravuje ji VD171. Opravy a vylepšení jsou vítány, viz [CONTRIBUTING.md](CONTRIBUTING.md)._
