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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · 日本語 · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# AI エージェント: ヘッドレスコントラクト

VDInstaller は 1 つのシェルコントラクトで操作されます。エージェント（WebUI と同じくルートとして実行）は
次を呼び出します:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

そして標準出力でちょうど 1 つの JSON オブジェクトを読みます。成功は `{"ok":true,...}`、失敗は
`{"ok":false,"code":"ERR_...","message":"..."}` です。長い操作は、ポーリングする `opid` を返します。
WebUI をスクレイピングせず、このコントラクトを使ってください。

## Verb

| Verb | 引数 (JSON) | 戻り値 |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | 設定オブジェクト |
| `config-set` | マージする任意の設定キー | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}`（type = apk \| archive） |
| `install` | `{mode, path \| dir, ...options}` | `{opid}`（デタッチ） |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}`（デタッチ） |
| `progress` | opid 文字列の base64（JSON ではない） | ライブの進行状況オブジェクト。完了時に `done:true` |
| `cancel` | opid 文字列の base64 | `{cancelled}` |
| `verifier-status` | - | 現在の verifier 設定 |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | 古いログを削除します |

## インストールモード

| `mode` | 取るもの | 意味 |
|---|---|---|
| `single` | `path` | 1 つの `.apk` |
| `batch` | `dir` | 独立した `.apk` ファイルのフォルダー、1 つずつインストール |
| `archive` | `path` | グループ化された分割アーカイブ（`.xapk` / `.apkm` / `.apks` / `.zip`） |
| `splitdir` | `dir` | 1 つのアプリのバラバラの分割 `.apk` ファイルが入ったフォルダー |

## オプション（引数内の操作ごと、または `config-set` で永続化）

`spoof_installer` (bool)、`spoof_installer_pkg` (string)、`deep_spoof` (bool)、
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`)、
`grant_all_perms`、`allow_test`、`bypass_low_target_sdk` (bool)、`target_user` (int)。

## 進行状況

`opid` で `progress` をポーリングします。オブジェクトは `percent`、`phase`
（`starting` / `extracting` / `installing` / `uninstalling` / `done`）、任意の `item`、そして完了時に
`result`（single/split）、`results[]` 配列（batch）、または `error` を伴う `done:true` を携えます。

## セーフティレール

- verifier のトグルと `packages.xml` の編集は可逆であり、監査されます（`logs/audit.jsonl`）。
- `install`/`uninstall` はデバイスの状態を変更します。WebUI がそうするように、呼び出す前に意図を確認して
  ください。
- WebUI 自体を決してスクレイピングまたは自動化しないでください。このコントラクトがサポートされる窓口
  です。

<!-- doc-footer -->

---

> _このドキュメントは Claude (Anthropic) で生成され、VD171 によって保守されています。修正や改善を歓迎します。[CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。_
