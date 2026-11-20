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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · Español · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Contribuir

Las contribuciones son bienvenidas - incidencias, pull requests, traducciones y documentacion. El proyecto
busca ser facil y acogedor para contribuir.

## Contribuidores con IA bienvenidos

Las contribuciones de IA y de agentes son bienvenidas con el mismo nivel de revision que las de cualquier
otra persona. El motor habla JSON sobre un contrato headless (`scripts/helper.sh <verb> <base64(JSON)>`);
consulta [docs/AI-AGENTS.md](docs/AI-AGENTS.md). Usa el contrato, no hagas scraping de la WebUI.

## Reglas de codigo

- **Banner completo por archivo** (SPDX + contactos) al inicio de cada archivo fuente. Nunca uno recortado.
- Codigo, identificadores, logs y comentarios en **ingles**. Comentarios solo cuando aportan algo.
- El shell es **POSIX sh** para el dispositivo (`sh -n` debe pasar; sin bashismos mas alla de `local`; sin dependencia de `jq` en rutas de codigo que deben ejecutarse antes de que el `jq` incluido este en el PATH).
- La WebUI es **JS puro**, sin framework; modo claro y oscuro en toda la interfaz.
- **Nunca** una raya larga ni corta; siempre un guion `-`.
- La compilacion es siempre **release**, nunca debug.
- **Nunca debilites un comportamiento real** para que algo pase, y nunca elimines contenido.

## Traducciones

Las cadenas de la WebUI viven en `module/webroot/lang/<code>.json` (claves planas, base en ingles en
`lang/en.js`); el README tiene un `README.<code>.md` por idioma. Agrega o corrige un idioma y abre un PR.

## Licencia

Al contribuir aceptas que tu contribucion se licencia bajo la GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Esta documentación se generó con Claude (Anthropic) y la mantiene VD171. Las correcciones y mejoras son bienvenidas; consulta [CONTRIBUTING.md](CONTRIBUTING.md)._
