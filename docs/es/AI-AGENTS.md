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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · Español · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# Agentes de IA: el contrato sin interfaz

VDInstaller se controla mediante un solo contrato de shell. Un agente (ejecutándose como root, igual que
la WebUI) llama a:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

y lee exactamente un objeto JSON en stdout. El éxito es `{"ok":true,...}`; el fallo es
`{"ok":false,"code":"ERR_...","message":"..."}`. Las operaciones largas devuelven un `opid` que
consultas. No raspes la WebUI; usa este contrato.

## Verbos

| Verbo | Args (JSON) | Devuelve |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | el objeto de configuración |
| `config-set` | cualquier clave de config a fusionar | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (desacoplado) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (desacoplado) |
| `progress` | base64 de la cadena opid (no JSON) | el objeto de progreso en vivo; `done:true` al terminar |
| `cancel` | base64 de la cadena opid | `{cancelled}` |
| `verifier-status` | - | los ajustes actuales del verificador |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | poda logs obsoletos |

## Modos de instalación

| `mode` | toma | significado |
|---|---|---|
| `single` | `path` | un `.apk` |
| `batch` | `dir` | una carpeta de archivos `.apk` independientes, una instalación cada uno |
| `archive` | `path` | un archivo split agrupado (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | una carpeta con los archivos `.apk` split sueltos de una app |

## Opciones (por operación en los args, o persistidas mediante `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Progreso

Consulta `progress` con el `opid`. El objeto lleva `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), un `item` opcional, y al
completarse `done:true` con un `result` (single/split), un array `results[]` (batch), o un `error`.

## Barandillas de seguridad

- El interruptor del verificador y la edición de `packages.xml` son reversibles y auditados
  (`logs/audit.jsonl`).
- `install`/`uninstall` cambian el estado del dispositivo; confirma la intención antes de llamar, como
  hace la WebUI.
- Nunca raspes ni automatices la propia WebUI; este contrato es la superficie soportada.

<!-- doc-footer -->

---

> _Esta documentación se generó con Claude (Anthropic) y la mantiene VD171. Las correcciones y mejoras son bienvenidas; consulta [CONTRIBUTING.md](CONTRIBUTING.md)._
