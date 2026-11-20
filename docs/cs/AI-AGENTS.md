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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · Čeština · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# AI agenti: headless smlouva

VDInstaller je řízen jedinou shell smlouvou. Agent (běžící jako root, jako to dělá WebUI) volá:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

a čte přesně jeden JSON objekt na stdout. Úspěch je `{"ok":true,...}`; selhání je
`{"ok":false,"code":"ERR_...","message":"..."}`. Dlouhé operace vracejí `opid`, který dotazujete.
Nescrapujte WebUI; použijte tuto smlouvu.

## Slovesa

| Sloveso | Args (JSON) | Vrací |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | konfigurační objekt |
| `config-set` | libovolné konfigurační klíče ke sloučení | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (oddělené) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (oddělené) |
| `progress` | base64 řetězce opid (ne JSON) | živý objekt průběhu; `done:true` po dokončení |
| `cancel` | base64 řetězce opid | `{cancelled}` |
| `verifier-status` | - | aktuální nastavení verifikátoru |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | prořízne zastaralé logy |

## Instalační režimy

| `mode` | bere | význam |
|---|---|---|
| `single` | `path` | jedno `.apk` |
| `batch` | `dir` | složka nezávislých souborů `.apk`, jedna instalace na soubor |
| `archive` | `path` | seskupený split archiv (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | složka s volnými soubory splitů `.apk` jedné aplikace |

## Možnosti (per-op v args, nebo trvale přes `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Průběh

Dotazujte `progress` s `opid`. Objekt nese `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), volitelné `item` a při dokončení
`done:true` s `result` (single/split), polem `results[]` (batch) nebo `error`.

## Bezpečnostní zábradlí

- Přepínač verifikátoru a úprava `packages.xml` jsou vratné a auditované (`logs/audit.jsonl`).
- `install`/`uninstall` mění stav zařízení; potvrďte záměr před voláním, jako to dělá WebUI.
- Nikdy nescrapujte ani neautomatizujte samotnou WebUI; tato smlouva je podporovaný povrch.

<!-- doc-footer -->

---

> _Tato dokumentace byla vytvořena pomocí Claude (Anthropic) a spravuje ji VD171. Opravy a vylepšení jsou vítány; viz [CONTRIBUTING.md](CONTRIBUTING.md)._
