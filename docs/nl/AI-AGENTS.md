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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · Nederlands · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# AI-agents: het headless contract

VDInstaller wordt aangestuurd door een shell-contract. Een agent (draaiend als root, zoals de WebUI doet)
roept aan:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

en leest precies een JSON-object op stdout. Succes is `{"ok":true,...}`, mislukking is
`{"ok":false,"code":"ERR_...","message":"..."}`. Lange bewerkingen geven een `opid` terug die je pollt.
Scrape de WebUI niet, gebruik dit contract.

## Verbs

| Verb | Args (JSON) | Geeft terug |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | het config-object |
| `config-set` | eventuele config-sleutels om samen te voegen | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (losgekoppeld) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (losgekoppeld) |
| `progress` | base64 van de opid-string (geen JSON) | het live voortgangsobject; `done:true` wanneer klaar |
| `cancel` | base64 van de opid-string | `{cancelled}` |
| `verifier-status` | - | de huidige verifier-instellingen |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | snoeit verouderde logs |

## Installatiemodi

| `mode` | neemt | betekenis |
|---|---|---|
| `single` | `path` | een `.apk` |
| `batch` | `dir` | een map met onafhankelijke `.apk`-bestanden, een installatie per stuk |
| `archive` | `path` | een gegroepeerd split-archief (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | een map met de losse split-`.apk`-bestanden van een app |

## Opties (per-op in de args, of persistent via `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Voortgang

Poll `progress` met de `opid`. Het object draagt `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), een optionele `item`, en bij
voltooiing `done:true` met een `result` (single/split), een `results[]`-array (batch), of een `error`.

## Veiligheidsrails

- De verifier-schakelaar en de `packages.xml`-bewerking zijn omkeerbaar en geaudit (`logs/audit.jsonl`).
- `install`/`uninstall` wijzigen de apparaatstaat, bevestig de bedoeling voor het aanroepen, zoals de
  WebUI doet.
- Scrape of automatiseer de WebUI zelf nooit, dit contract is het ondersteunde oppervlak.

<!-- doc-footer -->

---

> _Deze documentatie is gegenereerd met Claude (Anthropic) en wordt onderhouden door VD171. Correcties en verbeteringen zijn welkom, zie [CONTRIBUTING.md](CONTRIBUTING.md)._
