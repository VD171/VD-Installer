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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · Español · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Arquitectura

VDInstaller es una WebUI ligera sobre un motor de shell root. Nada en la interfaz tiene privilegios;
cada acción privilegiada es una llamada de shell que devuelve un objeto JSON.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI en JS puro (sin framework), claro/oscuro, 22 idiomas. Llama al motor a través
  del puente WebUI de KernelSU (`ksu.exec`) y analiza la respuesta JSON.
- **`scripts/common.sh`** - la biblioteca compartida incluida por ambos scripts: resolución de ABI/PATH,
  los envoltorios de `pm`/`dumpsys`/`fw` (entorno limpio para que las libs de Termux incluidas nunca
  ensombrezcan las de ART), los ayudantes de JSON y `jq`, y el `xml_edit` compatible con ABX.
- **`scripts/helper.sh`** - el contrato de la WebUI: una línea JSON por llamada. Los verbos cortos
  (version, config, browse, scan) se ejecutan en línea; los largos (install, uninstall) desacoplan un
  worker y devuelven un `opid`.
- **`scripts/worker.sh`** - el motor de instalación desacoplado: los cuatro modos de instalación, el
  interruptor del verificador, el falseo del origen de instalación y la API de sesión del gestor de
  paquetes. Escribe el progreso en un archivo que la WebUI consulta, y sobrevive al cierre de la WebUI
  (`setsid`, y escapa del congelador de apps).

## Puntos clave

- **Ya es root.** Sin aviso de "conceder su" y sin alternar `sucompat`; el motor se ejecuta como root
  desde el módulo y llama a `pm` / `settings` directamente.
- **Instalaciones por sesión.** Todos los modos usan `pm install-create` / `install-write` /
  `install-commit`, de modo que las apps split se instalan correctamente y el origen de instalación
  (`-i`) se establece en el momento de la sesión.
- **Compatible con ABX.** El falseo del iniciador en `packages.xml` comprueba el número mágico de
  XML binario `ABX\0`, decodifica, edita, re-codifica, hace un round-trip para validar, respalda byte a
  byte e intercambia de forma atómica; el archivo en vivo nunca se toca a menos que cada paso pase.
- **Sin reinicio.** Un módulo WebUI autónomo sin nada que montar: `customize.sh` lo copia en el
  directorio de módulos activos para que funcione en el momento en que se flashea.
- **Actualizaciones sin flasheo.** El motor **VDLU** incluido actualiza el módulo descargando solo los
  archivos cambiados, direccionados por contenido y firmados con ed25519 - sin un reflasheo completo.
- **Desacoplado.** Las operaciones largas se ejecutan fuera del webview; cerrar la WebUI nunca las
  interrumpe.

## Garantía de compatibilidad

- `sh` POSIX en el dispositivo (`sh -n` pasa; sin bashismos más allá de `local`; sin dependencia de
  `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` son las únicas herramientas del framework usadas, todas a través
  de `/system/bin`.
- Los binarios incluidos (`jq`, `abx2xml`/`xml2abx`) son opcionales para el camino común y llevan
  procedencia; el convertidor ABX recurre al `/system/bin/abx2xml` propio del dispositivo cuando está
  presente.

<!-- doc-footer -->

---

> _Esta documentación se generó con Claude (Anthropic) y la mantiene VD171. Las correcciones y mejoras son bienvenidas; consulta [CONTRIBUTING.md](CONTRIBUTING.md)._
