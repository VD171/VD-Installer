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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · Čeština · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Bezproblémový root instalátor pro sideload - KernelSU / APatch / Magisk WebUI.

## Proč

Instalace APK ze sideloadu na rootnutém telefonu je otravnější, než by měla být: ověřovač balíčků
Play Protect může vyhodit `INSTALL_FAILED_VERIFICATION_FAILURE`, rozdělené aplikace
(`.xapk` / `.apkm` / `.apks`) vyžadují ruční použití session API a čerstvě nainstalovaná aplikace se
každé aplikaci, která čte zdroj její instalace, hlásí jako "ze sideloadu". VDInstaller to všechno
udělá za tebe, už jako root, bez výzvy "udělit su" a bez terminálu.

## Funkce

- **Každá podoba APK** - jedno `.apk`, celá složka nezávislých APK (dávka), seskupený rozdělený archiv
  (`.xapk` / `.apkm` / `.apks` / `.zip`) nebo složka s volnými rozdělenými APK.
- **Žádná zeď ověřování** - trojpolohový přepínač pro ověřovač balíčků Play Protect: ponechat tak, jak
  byl (vypnutý jen během instalace, přesně obnovený), vždy zapnutý nebo vždy vypnutý.
- **Upřímnost ohledně Developer Verification** - root instalace je už z Androidí Developer
  Verification 2026 vyňatá; přepínač se o to snaží, jak nejlépe umí, a také to říká, nikdy to není
  falešné tlačítko.
- **Ne "ze sideloadu"** - volitelně vydává zdroj instalace za Play Store, jak instalátor (v okamžiku
  instalace), tak iniciátora (přes úpravu `packages.xml` s ohledem na ABX).
- **Odpojené a obnovitelné** - instalace běží jako odpojený root proces; zavření WebUI je nikdy
  nepřeruší a UI se znovu připojí podle ID operace.
- **Tvoje volba** - testovací balíčky, udělení všech runtime oprávnění, cílový uživatel,
  obejití blokace nízkého cílového SDK: vše volitelné.
- **Offline, soběstačný, bez restartu** - WebUI modul s přibalenými binárkami; použitelný ve chvíli,
  kdy je naflashován.

## AI agenti

Tento projekt vítá přispěvatele z řad AI a agentů. Engine mluví JSONem přes malou bezhlavou smlouvu
(`scripts/helper.sh <verb> <base64(JSON)>`), zdokumentovanou v
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), takže agent dokáže řídit každou akci, kterou zvládne WebUI -
WebUI prosím nescrapujte. Patche od AI podléhají stejné laťce recenze jako kterékoli jiné.

## Instalace

Naflashuj zip v KernelSU, APatch nebo Magisku a otevři VDInstaller WebUI ze svého root manažeru.
Instalátor ponechá jen ABI tvého zařízení a spustí povinnou kontrolu integrity `.sha256` (přeruší se
při poškozeném nebo zkráceném zipu). Android 8.0 (API 26) nebo novější.

## Bezpečnost

VDInstaller běží jako root a instaluje APK, která zvolíš; vypnutí ověřovače balíčků pro instalaci
deaktivuje sken malwaru, takže instaluj jen APK, kterým důvěřuješ. Nikdy neoslabuje zabezpečení
zařízení potichu: ověřovač se ve výchozím nastavení obnoví do přesně předchozího stavu a tvého nastavení
HMA-OSS se nikdy nedotkne. Problémy hlas podle [SECURITY.md](SECURITY.md).

## Build

Vždy release, nikdy debug. `.github/scripts/build_bin.sh` stáhne `jq` z apt repozitáře Termuxu (s jeho
uzávěrem sdílených knihoven) a samostatné konvertory `abx2xml` / `xml2abx`, pro všechny čtyři ABI,
každý s `PROVENANCE.json`. Release workflow sestaví flashovatelné zipy, zapíše společníky `.sha256`,
vyplní `update.json` a publikuje jako `github-actions[bot]`.

## Dokumentace

Návody jsou v [docs/](docs/) a zrcadlí se do GitHub wiki. Pro bezhlavou smlouvu viz
[docs/AI-AGENTS.md](docs/AI-AGENTS.md).

## Viz také

- [VDBackup](https://github.com/VD171/VD-Backup) - úplná záloha a obnova aplikací i dat, jako root.
- [VDInfos](https://github.com/VD171/VD-Infos) - přečti každou informaci o zařízení každou metodou, pak porovnej.
- [VDGoogle](https://github.com/VD171/VDGoogle) - čtení RCS, Wallet a atestací jako root.
- [COPG-VD](https://github.com/VD171/COPG-VD) - modul pro Pixel fingerprint a props.

## Kontakty

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/root-webui-v1-00-vd-installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## Licence

VDInstaller je licencován pod GNU AGPL-3.0-or-later. Viz [LICENSE](LICENSE). NETWORK COPYLEFT:
provozuješ-li upravenou verzi, i jako službu, musíš nabídnout její zdrojový kód.

## Ochranné známky

Android, KernelSU, APatch, Magisk, Google Play a Play Protect patří svým příslušným vlastníkům. Tento
projekt je nezávislý a není s nimi spojen ani jimi podporován.

## Tagy

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Přidej se ke kanálu: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
