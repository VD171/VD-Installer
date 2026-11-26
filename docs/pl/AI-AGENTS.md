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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · Polski · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# Agenci AI: bezgłowy kontrakt

VDInstaller jest sterowany jednym kontraktem powłoki. Agent (działający jako root, tak jak WebUI)
wywołuje:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

i odczytuje dokładnie jeden obiekt JSON na stdout. Powodzenie to `{"ok":true,...}`, niepowodzenie to
`{"ok":false,"code":"ERR_...","message":"..."}`. Długie operacje zwracają `opid`, który odpytujesz. Nie
zeskrobuj WebUI, używaj tego kontraktu.

## Czasowniki

| Czasownik | Argumenty (JSON) | Zwraca |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | obiekt konfiguracji |
| `config-set` | dowolne klucze konfiguracji do scalenia | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (odłączone) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (odłączone) |
| `progress` | base64 ciągu opid (nie JSON) | obiekt postępu na żywo; `done:true` po zakończeniu |
| `cancel` | base64 ciągu opid | `{cancelled}` |
| `verifier-status` | - | bieżące ustawienia weryfikatora |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | przycina nieaktualne logi |

## Tryby instalacji

| `mode` | przyjmuje | znaczenie |
|---|---|---|
| `single` | `path` | jeden `.apk` |
| `batch` | `dir` | folder niezależnych plików `.apk`, jedna instalacja każdy |
| `archive` | `path` | zgrupowane archiwum split (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | folder z luźnymi plikami `.apk` splitów jednej aplikacji |

## Opcje (per operacja w argumentach lub utrwalone przez `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Postęp

Odpytuj `progress` z `opid`. Obiekt niesie `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), opcjonalny `item`, a po zakończeniu
`done:true` z `result` (single/split), tablicą `results[]` (batch) lub `error`.

## Bariery bezpieczeństwa

- Przełącznik weryfikatora i edycja `packages.xml` są odwracalne i audytowane (`logs/audit.jsonl`).
- `install`/`uninstall` zmieniają stan urządzenia, potwierdź intencję przed wywołaniem, tak jak robi to
  WebUI.
- Nigdy nie zeskrobuj ani nie automatyzuj samego WebUI, tym wspieranym interfejsem jest ten kontrakt.

<!-- doc-footer -->

---

> _Ta dokumentacja została wygenerowana za pomocą Claude (Anthropic) i jest utrzymywana przez VD171. Poprawki i ulepszenia są mile widziane, zobacz [CONTRIBUTING.md](CONTRIBUTING.md)._
