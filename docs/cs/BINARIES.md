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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · Čeština · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Přibalené binárky: provenience a audit

## Zásady

- Nic neprůhledného se nedodává. Každá přibalená binárka je získána **v době buildu z jejího oficiálního
  upstreamu**, nikdy stažena ze zařízení, a každý soubor nese sha256, takže payload lze reprodukovat.
- Binárky jsou přibaleny pro **všechny čtyři ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`); flash
  instalátor je ořeže na tu jednu zařízení.
- Běží samostatně: závěr sdílených knihoven každé binárky je dodán spolu s ní a engine nastaví
  `LD_LIBRARY_PATH` na přibalené `lib/`, takže není žádná závislost na nainstalovaném Termuxu.

## Co se dodává a odkud

| Binárka | Odkud | Proč |
|---|---|---|
| `jq` (+ `lib/`) | z repozitáře balíčků Termux (`packages.termux.dev/apt`), oficiální `.deb` | engine mluví JSON; `jq` parsuje argumenty a staví odpovědi. |
| `abx2xml` / `xml2abx` | z release [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | dekóduje/kóduje binární XML Androidu (ABX) pro podvrh zdroje instalace v `packages.xml` tam, kde zařízení postrádá `/system/bin/abx2xml` (před A12). Vlastní konvertor zařízení má přednost, je-li přítomen. |
| `vdlu/verify/<abi>/ed25519-mini` | z kanonického enginu [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | ověřuje podpis ed25519 u flashless (VDLU) aktualizací, bez OpenSSL. |

Krok buildu je `.github/scripts/build_bin.sh`: rozlišuje balíček Termux plus jeho tranzitivní závislosti,
extrahuje `.deb`y, kopíruje chtěné binárky a závěr sdílených knihoven, který každá potřebuje (vyřešeno
pomocí `readelf`), a poté stáhne samostatný ABX konvertor.

## Manifest na zařízení: `PROVENANCE.json`

Každý `bin/<abi>/` nese `PROVENANCE.json` uvádějící každý dodaný soubor (cesta, velikost, sha256) a
upstream zdroj každého z nich (balíček, verze, URL, sha256 archivu). Přežije ořez ABI na zařízení, takže
auditní stopa se dodává se samotným modulem.

## Jak ověřit

1. Otevřete `bin/<abi>/PROVENANCE.json` na zařízení nebo ve flashovatelném zipu.
2. Znovu stáhněte každý připnutý zdroj z URL, kterou zaznamenává.
3. Extrahujte a porovnejte sha256 každého souboru s manifestem.

Flashovatelný zip navíc nese `.sha256` společníka vedle každého dodaného souboru; `customize.sh` je ověří
při flashnutí a **přeruší** proces při jakékoli neshodě (poškozený nebo zkrácený zip).

## Hlášení

Našli jste neshodu nebo problém s proveniencí? Nahlaste jej soukromě - viz [SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Tato dokumentace byla vytvořena pomocí Claude (Anthropic) a spravuje ji VD171. Opravy a vylepšení jsou vítány; viz [CONTRIBUTING.md](CONTRIBUTING.md)._
