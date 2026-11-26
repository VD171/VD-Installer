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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · Español · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# Politica de seguridad

## Modelo de amenazas en una linea

VDInstaller se ejecuta como root e instala APKs que el usuario elige explicitamente, apagar el verificador
de Play Protect para una instalacion desactiva un analisis de malware, por lo que es "instalacion sin
friccion", no "instalacion segura" - instala solo APKs en los que confies.

## Lo que hace y lo que no hace

- Restaura el verificador de paquetes a su estado previo exacto por defecto (dejar un `0`/`1` donde no habia
  ninguno es en si mismo una senal, por eso se borra de nuevo).
- Nunca toca tu configuracion de HMA-OSS, ocultar apps es una recomendacion que tu mismo aplicas.
- La edicion del origen de instalacion en `packages.xml` reconoce ABX, respalda el archivo en vivo byte a
  byte antes de cualquier cambio, hace un ida y vuelta para validar y deja el archivo en vivo intacto ante
  cualquier fallo.
- Los binarios incluidos se descargan en la compilacion desde su upstream oficial y llevan un `PROVENANCE.json`.

## Reportar una vulnerabilidad

Por favor, reporta primero en privado. Incluye los pasos para reproducir, la version afectada y el impacto.

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

> _Esta documentación se generó con Claude (Anthropic) y la mantiene VD171. Las correcciones y mejoras son bienvenidas, consulta [CONTRIBUTING.md](CONTRIBUTING.md)._
