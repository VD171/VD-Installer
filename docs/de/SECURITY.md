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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · Deutsch · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# Sicherheitsrichtlinie

## Bedrohungsmodell in einem Satz

VDInstaller läuft als root und installiert APKs, die der Benutzer ausdrücklich auswählt; das
Abschalten des Play-Protect-Verifiers für eine Installation deaktiviert einen Malware-Scan, daher
ist es eine "reibungslose Installation", keine "sichere Installation" - installiere nur APKs, denen
du vertraust.

## Was es tut und was nicht

- Es stellt den Paket-Verifier standardmäßig in seinen exakten vorherigen Zustand zurück (ein
  `0`/`1` dort zu hinterlassen, wo keines war, ist selbst ein verräterisches Zeichen, daher wird
  es wieder gelöscht).
- Es rührt niemals dein HMA-OSS-Setup an; das Verbergen von Apps ist eine Empfehlung, die du selbst umsetzt.
- Die Bearbeitung der Installationsquelle in `packages.xml` ist ABX-fähig, sichert die Live-Datei
  byte-genau vor jeder Änderung, macht einen Round-Trip zur Validierung und lässt die Live-Datei
  bei jedem Fehler unberührt.
- Mitgelieferte Binärdateien werden beim Build von ihrem offiziellen Upstream bezogen und tragen eine `PROVENANCE.json`.

## Eine Schwachstelle melden

Bitte zuerst privat melden. Füge Schritte zur Reproduktion, die betroffene Version und die Auswirkung bei.

- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me
- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)

<!-- doc-footer -->

---

> _Diese Dokumentation wurde mit Claude (Anthropic) erstellt und wird von VD171 gepflegt. Korrekturen und Verbesserungen sind willkommen; siehe [CONTRIBUTING.md](CONTRIBUTING.md)._
