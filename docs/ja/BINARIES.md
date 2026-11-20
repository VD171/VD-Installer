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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · 日本語 · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# 同梱バイナリ: 来歴と監査

## 原則

- 不透明なものは一切同梱しません。すべての同梱バイナリは **ビルド時に公式のアップストリームから** 取得
  され、デバイスから抜き出すことは決してありません。そしてすべてのファイルは sha256 を携えているので、
  ペイロードを再現できます。
- バイナリは **4 つの ABI すべて**（`arm64-v8a`、`armeabi-v7a`、`x86`、`x86_64`）向けに同梱されます。
  フラッシュインストーラーがデバイスの 1 つに絞り込みます。
- これらはスタンドアロンで実行されます: 各バイナリの共有ライブラリのクロージャが一緒に同梱され、
  エンジンが `LD_LIBRARY_PATH` を同梱の `lib/` に設定するので、Termux がインストールされていることへの
  依存はありません。

## 何が同梱され、どこから来るか

| バイナリ | 由来 | 理由 |
|---|---|---|
| `jq` (+ `lib/`) | Termux パッケージリポジトリ（`packages.termux.dev/apt`）、公式の `.deb` | エンジンは JSON を話します。`jq` が引数を解析し、応答を組み立てます。 |
| `abx2xml` / `xml2abx` | [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) のリリース | `packages.xml` のインストール元偽装のために Android バイナリ XML（ABX）をデコード/エンコードします。デバイスに `/system/bin/abx2xml`（A12 以前）がない場合に使います。存在する場合はデバイス自身のコンバーターが優先されます。 |
| `vdlu/verify/<abi>/ed25519-mini` | 正統な [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) エンジン | OpenSSL なしで、フラッシュレス（VDLU）更新の ed25519 署名を検証します。 |

ビルドステップは `.github/scripts/build_bin.sh` です: Termux パッケージとその推移的依存関係を解決し、
`.deb` を展開し、求めるバイナリと、それぞれが必要とする共有ライブラリのクロージャ（`readelf` で解決）を
コピーし、それからスタンドアロンの ABX コンバーターを取得します。

## デバイス上のマニフェスト: `PROVENANCE.json`

各 `bin/<abi>/` は、同梱されたすべてのファイル（パス、サイズ、sha256）と、それぞれのアップストリーム
由来（パッケージ、バージョン、URL、アーカイブの sha256）を一覧する `PROVENANCE.json` を携えています。
これはデバイス上の ABI 絞り込みを生き延びるので、監査証跡はモジュール自体とともに同梱されます。

## 検証方法

1. デバイス上またはフラッシュ可能な zip 内の `bin/<abi>/PROVENANCE.json` を開きます。
2. 記録された URL から、固定された各ソースを再取得します。
3. 展開し、各ファイルの sha256 をマニフェストと比較します。

フラッシュ可能な zip は、同梱された各ファイルの隣に `.sha256` のコンパニオンを追加で携えています。
`customize.sh` がフラッシュ時にそれらを検証し、いずれかの不一致（破損または切り詰められた zip）で
**中止** します。

## 報告

不一致や来歴に関する懸念を見つけましたか? 非公開で報告してください - [SECURITY.md](../SECURITY.md) を
参照してください。

<!-- doc-footer -->

---

> _このドキュメントは Claude (Anthropic) で生成され、VD171 によって保守されています。修正や改善を歓迎します。[CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。_
