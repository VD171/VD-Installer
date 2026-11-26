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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · Español · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# Guía de usuario de VDInstaller

## Tabla de contenidos

1. [Qué es VDInstaller](#1-qué-es-vdinstaller)
2. [Requisitos](#2-requisitos)
3. [Instalación y primer uso](#3-instalación-y-primer-uso)
4. [Recorrido por la WebUI](#4-recorrido-por-la-webui)
5. [Instalar APKs](#5-instalar-apks)
6. [Opciones](#6-opciones)
7. [Controlar VDInstaller desde un asistente de IA](#7-controlar-vdinstaller-desde-un-asistente-de-ia)
8. [Resolución de problemas y preguntas frecuentes](#8-resolución-de-problemas-y-preguntas-frecuentes)

## 1. Qué es VDInstaller

VDInstaller es un **módulo WebUI** de KernelSU / APatch / Magisk que instala APKs cargados de forma
lateral (sideload) como root sin fricción: sin aviso de "conceder su", sin terminal y sin pelear con el
verificador de Play Protect. Gestiona APKs individuales, una carpeta entera a la vez y apps divididas
(split) (`.xapk` / `.apkm` / `.apks` / `.zip` o archivos split sueltos), y puede presentar el origen de
instalación como la Play Store para que una app no parezca cargada de forma lateral.

## 2. Requisitos

- Android 8.0 o posterior (API 26+).
- Una solución de root con soporte WebUI: **KernelSU**, **APatch** o **Magisk**.

## 3. Instalación y primer uso

1. Descarga el `VD-Installer-vX.XX-universal.zip` más reciente desde la página de
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Flashéalo como módulo en tu gestor de root (*Módulos -> Instalar desde almacenamiento*).
3. VDInstaller se activa **sin reinicio** - es autónomo (WebUI + binarios incluidos), así que no hay
   nada que montar.
4. Abre la WebUI de **VDInstaller** desde la lista de módulos de tu gestor de root.

Al flashear, el instalador conserva solo la ABI de tu dispositivo y ejecuta una comprobación de
integridad obligatoria `.sha256` que **aborta** si el zip está corrupto o truncado. Los ajustes viven en
`/data/adb/vdinstaller` y sobreviven a las actualizaciones.

## 4. Recorrido por la WebUI

Tres pestañas:

- **Install** - elige un modo, selecciona el APK o la carpeta, instala y observa el progreso en vivo.
- **Options** - origen de instalación, el interruptor del verificador de Play Protect y los flags de
  instalación. Todo se guarda automáticamente.
- **About** - versión, qué hace, requisitos, enlaces y licencia.

## 5. Instalar APKs

Eliges el modo en la pestaña **Install**, VDInstaller nunca adivina.

| Modo | Lo que proporcionas | Qué ocurre |
|---|---|---|
| **APK individual** | un archivo `.apk` | una sesión de instalación, una app. |
| **Carpeta de APKs** (batch) | una carpeta de archivos `.apk` independientes | cada APK se instala por su cuenta, uno tras otro; un batch parcial informa cuáles fallaron y por qué. |
| **Archivo split** | un `.xapk` / `.apkm` / `.apks` / `.zip` | se extrae, luego `base.apk` + los splits se instalan como una app en una sola sesión (el OBB del XAPK también se coloca, cuando existe). |
| **Carpeta split** | una carpeta con los archivos `.apk` split sueltos de una app | los splits se instalan como una app en una sola sesión. |

Una app "split" es un APK dividido en una base más APKs de configuración por densidad / por ABI / por
idioma, deben instalarse **juntos** en una sola sesión, que es lo que hacen por ti los modos Split.

### 5.1 El diálogo Browse

**Browse** abre un selector de archivos que lista carpetas y archivos instalables en una ruta:

- Toca una **carpeta** para entrar en ella, **Up** va al directorio superior.
- En un modo de archivo (APK individual / Archivo split), toca un **archivo** para seleccionarlo.
- En un modo de carpeta (Carpeta de APKs / Carpeta split), navega hasta la carpeta y toca **Use this folder**.

También puedes escribir o pegar una ruta directamente (por ejemplo `/sdcard/Download/app.apk`).

### 5.2 Progreso, cancelar, reanudar

Las instalaciones se ejecutan como un **proceso root desacoplado**. Una tarjeta de progreso muestra la
fase, **Cancel** la detiene. Si cierras la WebUI a mitad de la instalación, esta continúa y la interfaz
se reconecta por id de operación cuando la vuelves a abrir.

## 6. Opciones

Todo aquí se guarda automáticamente y se aplica a la siguiente instalación.

### 6.1 Origen de instalación

Una app recién cargada de forma lateral anuncia a cada app que lo lee (y a la atestación) que fue
cargada de forma lateral. VDInstaller puede presentar el origen como la Play Store en su lugar.

- **Mostrar la Play Store como instalador** (activado por defecto) - establece `installerPackageName`
  mediante `pm install-create -i com.android.vending`. Se aplica de inmediato.
- **Falsear también el iniciador** (activado por defecto) - establece `installInitiator` y
  `packageSource` editando `/data/system/packages.xml`. Esto es **compatible con ABX** (decodificar ->
  editar -> re-codificar, con una copia de seguridad byte a byte y un intercambio atómico) y se aplica
  **tras el siguiente reinicio**, porque el gestor de paquetes mantiene `packages.xml` en caché.

### 6.2 Verificador de paquetes de Play Protect

Una instalación cargada de forma lateral puede ser rechazada con
`INSTALL_FAILED_VERIFICATION_FAILURE` por el verificador de paquetes de Play Protect. Un interruptor de
3 posiciones:

- **Mantener como estaba** (por defecto) - desactivado solo durante la instalación, luego restaurado a
  su estado **exacto** anterior (borrado de nuevo si no había un valor explícito, ya que un `0`/`1` donde
  no había ninguno es en sí mismo una pista en un dispositivo sigiloso).
- **Siempre activado** - fuérzalo activado y mantenlo.
- **Siempre desactivado** - fuérzalo desactivado y mantenlo. La WebUI advierte: dejarlo desactivado es
  una pista de sigilo y desactiva un escaneo de malware en cada instalación.

### 6.3 Developer Verification

La Developer Verification de 2026 de Android bloquea la instalación de apps de desarrolladores no
registrados en dispositivos certificados, pero la aplica un **servicio aparte**, no Play Protect, y una
**instalación root ya está exenta** de ella (la misma exención que obtienen las instalaciones por ADB).
VDInstaller instala tus APKs de todos modos, así que este interruptor es **el mejor esfuerzo y honesto**:
aplica una perilla real solo si existe y nunca finge accionar un interruptor que no hace nada.

### 6.4 Flags de instalación

| Flag | Efecto |
|---|---|
| **Conceder todos los permisos en tiempo de ejecución** | concede cada permiso en tiempo de ejecución al instalar (`-g`). |
| **Permitir paquetes de prueba** | instala paquetes marcados como solo de prueba (`-t`). |
| **Omitir el bloqueo por targetSdk bajo** | instala apps con un `targetSdk` muy antiguo. |
| **Usuario destino** | el id de usuario de Android para el que instalar (por defecto `0`). |

### 6.5 Mantenerse oculto

Para el sigilo, considera ocultar tu gestor de root y las apps sensibles con HMA-OSS. VDInstaller
**nunca toca tu configuración de HMA-OSS** - la sugerencia es solo un recordatorio, el cambio lo haces tú
mismo en HMA-OSS.

## 7. Controlar VDInstaller desde un asistente de IA

El motor habla un pequeño contrato JSON a través de `scripts/helper.sh`, así que un agente puede
controlar cada acción que puede hacer la WebUI. Consulta [AI-AGENTS](AI-AGENTS). Controla el contrato, no
raspes la WebUI.

## 8. Resolución de problemas y preguntas frecuentes

**Obtengo `INSTALL_FAILED_VERIFICATION_FAILURE`.** Ese es el verificador de paquetes de Play Protect.
Con el interruptor del verificador en **Mantener como estaba** (el valor por defecto), VDInstaller lo
desactiva durante la instalación y lo restaura, así que no ocurre.

**Activé el origen Play Store pero la app sigue pareciendo cargada de forma lateral.** La parte del
instalador se aplica de inmediato, la parte del iniciador (`packages.xml`) se aplica **tras el siguiente
reinicio**.

**¿Evita la Developer Verification de Google?** No lo necesita - una instalación root está exenta
(ver 6.3). No hay ningún interruptor falso para ella.

**¿Necesita reinicio?** No, salvo el falseo opcional del iniciador.

**¿Desinstalar VDInstaller elimina las apps que instalé?** No - esas son instalaciones reales propiedad
del sistema, quitar el módulo solo limpia el propio estado de VDInstaller.

**¿Es seguro?** Instala los APKs que elijas y, con el verificador desactivado, se salta un escaneo de
malware - instala solo APKs en los que confíes. Nunca debilita nada de forma silenciosa.

<!-- doc-footer -->

---

> _Esta documentación se generó con Claude (Anthropic) y la mantiene VD171. Las correcciones y mejoras son bienvenidas, consulta [CONTRIBUTING.md](CONTRIBUTING.md)._
