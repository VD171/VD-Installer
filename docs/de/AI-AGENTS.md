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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · Deutsch · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# KI-Agenten: der headless Vertrag

VDInstaller wird über einen einzigen Shell-Vertrag gesteuert. Ein Agent (der als root läuft, wie es die
WebUI tut) ruft auf:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

und liest genau ein JSON-Objekt auf stdout. Erfolg ist `{"ok":true,...}`; Fehlschlag ist
`{"ok":false,"code":"ERR_...","message":"..."}`. Lange Operationen geben eine `opid` zurück, die du
abfragst. Scrape nicht die WebUI; nutze diesen Vertrag.

## Verben

| Verb | Args (JSON) | Gibt zurück |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | das Konfigurationsobjekt |
| `config-set` | beliebige zu mergende Konfigurationsschlüssel | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (abgekoppelt) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (abgekoppelt) |
| `progress` | base64 des opid-Strings (nicht JSON) | das Live-Fortschrittsobjekt; `done:true` wenn abgeschlossen |
| `cancel` | base64 des opid-Strings | `{cancelled}` |
| `verifier-status` | - | die aktuellen Verifizierer-Einstellungen |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | bereinigt veraltete Logs |

## Installationsmodi

| `mode` | nimmt | Bedeutung |
|---|---|---|
| `single` | `path` | eine `.apk` |
| `batch` | `dir` | ein Ordner mit unabhängigen `.apk`-Dateien, eine Installation je Datei |
| `archive` | `path` | ein gruppiertes Split-Archiv (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | ein Ordner mit den losen Split-`.apk`-Dateien einer App |

## Optionen (pro Operation in den Args, oder dauerhaft über `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Fortschritt

Frage `progress` mit der `opid` ab. Das Objekt trägt `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), ein optionales `item` und bei
Abschluss `done:true` mit einem `result` (single/split), einem `results[]`-Array (batch) oder einem
`error`.

## Sicherheitsgeländer

- Der Verifizierer-Schalter und die `packages.xml`-Bearbeitung sind umkehrbar und auditiert
  (`logs/audit.jsonl`).
- `install`/`uninstall` ändern den Gerätezustand; bestätige die Absicht vor dem Aufruf, wie es die WebUI
  tut.
- Scrape oder automatisiere niemals die WebUI selbst; dieser Vertrag ist die unterstützte Oberfläche.

<!-- doc-footer -->

---

> _Diese Dokumentation wurde mit Claude (Anthropic) erstellt und wird von VD171 gepflegt. Korrekturen und Verbesserungen sind willkommen; siehe [CONTRIBUTING.md](CONTRIBUTING.md)._
