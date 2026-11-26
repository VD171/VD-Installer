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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · Deutsch · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Architektur

VDInstaller ist eine dünne WebUI über einer Root-Shell-Engine. Nichts in der Oberfläche hat Privilegien;
jede privilegierte Aktion ist ein Shell-Aufruf, der ein JSON-Objekt zurückgibt.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - reine JS-WebUI (kein Framework), hell/dunkel, 22 Sprachen. Sie ruft die Engine über die
  KernelSU-WebUI-Brücke (`ksu.exec`) auf und parst die JSON-Antwort.
- **`scripts/common.sh`** - die geteilte Bibliothek, die von beiden Skripten geladen wird:
  ABI/PATH-Auflösung, die `pm`/`dumpsys`/`fw`-Wrapper (saubere Umgebung, damit die mitgelieferten
  Termux-Libs niemals ARTs Libs überdecken), die JSON- und `jq`-Helfer und das ABX-bewusste `xml_edit`.
- **`scripts/helper.sh`** - der WebUI-Vertrag: eine JSON-Zeile pro Aufruf. Kurze Verben (version, config,
  browse, scan) laufen inline, lange (install, uninstall) koppeln einen Worker ab und geben eine `opid`
  zurück.
- **`scripts/worker.sh`** - die abgekoppelte Installations-Engine: die vier Installationsmodi, der
  Verifizierer-Schalter, die Fälschung der Installationsquelle und die Session-API des Package-Managers.
  Sie schreibt den Fortschritt in eine Datei, die die WebUI abfragt, und übersteht das Schließen der WebUI
  (`setsid`, und sie entkommt dem App-Freezer).

## Kernpunkte

- **Bereits root.** Keine "grant su"-Abfrage und kein `sucompat`-Umschalten, die Engine läuft als root aus
  dem Modul und ruft `pm` / `settings` direkt auf.
- **Session-Installationen.** Alle Modi nutzen `pm install-create` / `install-write` / `install-commit`,
  sodass Split-Apps korrekt installiert werden und die Installationsquelle (`-i`) zur Session-Zeit gesetzt
  wird.
- **ABX-bewusst.** Die `packages.xml`-Initiator-Fälschung prüft auf das `ABX\0`-Binär-XML-Magic,
  dekodiert, bearbeitet, kodiert erneut, führt einen Round-Trip zur Validierung durch, sichert byte-genau
  und tauscht atomar, die Live-Datei wird nie angerührt, wenn nicht jeder Schritt gelingt.
- **Neustartfrei.** Ein eigenständiges WebUI-Modul mit nichts zu mounten: `customize.sh` kopiert es in das
  aktive Modulverzeichnis, sodass es in dem Moment funktioniert, in dem es geflasht wird.
- **Flashlose Updates.** Die mitgelieferte **VDLU**-Engine aktualisiert das Modul, indem sie nur die
  geänderten, inhaltsadressierten, ed25519-signierten Dateien herunterlädt - kein vollständiges
  Neu-Flashen.
- **Abgekoppelt.** Lange Operationen laufen außerhalb der Webview, das Schließen der WebUI unterbricht sie
  nie.

## Kompatibilitätsgarantie

- POSIX-`sh` auf dem Gerät (`sh -n` besteht, keine Bashismen über `local` hinaus, keine `awk`-Abhängigkeit).
- `pm` / `dumpsys` / `settings` / `cmd` sind die einzigen genutzten Framework-Tools, alle über
  `/system/bin`.
- Mitgelieferte Binaries (`jq`, `abx2xml`/`xml2abx`) sind für den gängigen Pfad optional und tragen ihre
  Herkunft, der ABX-Konverter fällt auf das geräteeigene `/system/bin/abx2xml` zurück, wo vorhanden.

<!-- doc-footer -->

---

> _Diese Dokumentation wurde mit Claude (Anthropic) erstellt und wird von VD171 gepflegt. Korrekturen und Verbesserungen sind willkommen, siehe [CONTRIBUTING.md](CONTRIBUTING.md)._
