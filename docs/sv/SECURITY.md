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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · Svenska · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# Säkerhetspolicy

## Hotmodell på en rad

VDInstaller körs som root och installerar APK:er som användaren uttryckligen väljer; att stänga av Play
Protect-verifieraren för en installation inaktiverar en malware-skanning, så det är "friktionsfri
installation", inte "säker installation" - installera endast APK:er du litar på.

## Vad det gör och inte gör

- Det återställer paketverifieraren till exakt dess tidigare tillstånd som standard (att lämna en `0`/`1`
  där det inte fanns någon är i sig en avslöjare, så den tas bort igen).
- Det rör aldrig din HMA-OSS-uppsättning; att dölja appar är en rekommendation du själv agerar på.
- `packages.xml`-redigeringen av installationskällan är ABX-medveten, säkerhetskopierar den aktiva filen
  byte-exakt före någon ändring, gör en round-trip för att validera, och lämnar den aktiva filen orörd vid varje fel.
- Medföljande binärer hämtas vid bygget från deras officiella uppström och bär en `PROVENANCE.json`.

## Rapportera en sårbarhet

Rapportera privat först. Inkludera steg för att återskapa, berörd version och påverkan.

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

> _Denna dokumentation genererades med Claude (Anthropic) och underhålls av VD171. Rättelser och förbättringar välkomnas; se [CONTRIBUTING.md](CONTRIBUTING.md)._
