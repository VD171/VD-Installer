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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · Español · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Binarios incluidos: procedencia y auditoría

## Principios

- No se incluye nada opaco. Cada binario incluido se obtiene en **tiempo de compilación desde su upstream
  oficial**, nunca se extrae de un dispositivo, y cada archivo lleva un sha256 para que la carga pueda
  reproducirse.
- Los binarios se incluyen para las **cuatro ABIs** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`); el
  instalador de flasheo los recorta a la única del dispositivo.
- Se ejecutan de forma autónoma: el cierre de bibliotecas compartidas de cada binario se envía junto a él
  y el motor establece `LD_LIBRARY_PATH` al `lib/` incluido, así que no hay dependencia de que Termux esté
  instalado.

## Qué se incluye, y de dónde

| Binario | De | Por qué |
|---|---|---|
| `jq` (+ `lib/`) | el repositorio de paquetes de Termux (`packages.termux.dev/apt`), `.deb` oficial | el motor habla JSON; `jq` analiza los argumentos y construye las respuestas. |
| `abx2xml` / `xml2abx` | release de [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | decodificar/codificar el XML binario de Android (ABX) para el falseo del origen de instalación en `packages.xml`, donde el dispositivo carece de `/system/bin/abx2xml` (anterior a A12). Se prefiere el convertidor propio del dispositivo cuando está presente. |
| `vdlu/verify/<abi>/ed25519-mini` | el motor canónico [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | verificar la firma ed25519 en las actualizaciones sin flasheo (VDLU), sin OpenSSL. |

El paso de compilación es `.github/scripts/build_bin.sh`: resuelve el paquete de Termux más sus
dependencias transitivas, extrae los `.deb`, copia los binarios deseados y el cierre de bibliotecas
compartidas que cada uno necesita (resuelto con `readelf`), y luego obtiene el convertidor ABX
autónomo.

## El manifiesto en el dispositivo: `PROVENANCE.json`

Cada `bin/<abi>/` lleva un `PROVENANCE.json` que lista cada archivo enviado (ruta, tamaño, sha256) y el
origen upstream de cada uno (paquete, versión, URL, sha256 del archivo). Sobrevive al recorte de ABI en
el dispositivo, así que el rastro de auditoría se envía con el propio módulo.

## Cómo verificar

1. Abre `bin/<abi>/PROVENANCE.json` en el dispositivo o en el zip flasheable.
2. Vuelve a obtener cada origen fijado desde la URL que registra.
3. Extrae y compara el sha256 de cada archivo con el manifiesto.

El zip flasheable lleva además un acompañante `.sha256` junto a cada archivo enviado; `customize.sh` los
verifica en el momento del flasheo y **aborta** ante cualquier discrepancia (un zip corrupto o truncado).

## Informar

¿Encontraste una discrepancia o una preocupación de procedencia? Infórmala de forma privada - consulta
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Esta documentación se generó con Claude (Anthropic) y la mantiene VD171. Las correcciones y mejoras son bienvenidas; consulta [CONTRIBUTING.md](CONTRIBUTING.md)._
