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

# AI agents: the headless contract

VDInstaller is driven by one shell contract. An agent (running as root, as the WebUI does) calls:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

and reads exactly one JSON object on stdout. Success is `{"ok":true,...}`; failure is
`{"ok":false,"code":"ERR_...","message":"..."}`. Long operations return an `opid` you poll. Do not
scrape the WebUI; use this contract.

## Verbs

| Verb | Args (JSON) | Returns |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | the config object |
| `config-set` | any config keys to merge | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (detached) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (detached) |
| `progress` | base64 of the opid string (not JSON) | the live progress object; `done:true` when finished |
| `cancel` | base64 of the opid string | `{cancelled}` |
| `verifier-status` | - | the current verifier settings |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | prunes stale logs |

## Install modes

| `mode` | takes | meaning |
|---|---|---|
| `single` | `path` | one `.apk` |
| `batch` | `dir` | a folder of independent `.apk` files, one install each |
| `archive` | `path` | a grouped split archive (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | a folder with the loose split `.apk` files of one app |

## Options (per-op in the args, or persisted via `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Progress

Poll `progress` with the `opid`. The object carries `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), an optional `item`, and on
completion `done:true` with a `result` (single/split), a `results[]` array (batch), or an `error`.

## Safety rails

- The verifier toggle and the `packages.xml` edit are reversible and audited (`logs/audit.jsonl`).
- `install`/`uninstall` change device state; confirm intent before calling, as the WebUI does.
- Never scrape or automate the WebUI itself; this contract is the supported surface.

<!-- doc-footer -->

---

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](../CONTRIBUTING.md)._
