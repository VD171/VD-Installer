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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · 日本語 · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# アーキテクチャ

VDInstaller は、ルートシェルエンジンの上にかぶせた薄い WebUI です。UI 側には何の特権もありません。
あらゆる特権操作は、1 つの JSON オブジェクトを返す 1 回のシェル呼び出しです。

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - バニラ JS の WebUI（フレームワークなし）、ライト/ダーク、22 言語。KernelSU WebUI
  ブリッジ（`ksu.exec`）を介してエンジンを呼び出し、JSON の応答を解析します。
- **`scripts/common.sh`** - 両方のスクリプトが読み込む共有ライブラリ: ABI/PATH の解決、
  `pm`/`dumpsys`/`fw` のラッパー（同梱の Termux ライブラリが ART のものを決して覆い隠さないように
  クリーンな環境で）、JSON と `jq` のヘルパー、そして ABX 対応の `xml_edit`。
- **`scripts/helper.sh`** - WebUI コントラクト: 1 回の呼び出しにつき 1 行の JSON。短い verb（version、
  config、browse、scan）はインラインで実行され、長いもの（install、uninstall）はワーカーをデタッチ
  して `opid` を返します。
- **`scripts/worker.sh`** - デタッチされたインストールエンジン: 4 つのインストールモード、verifier の
  トグル、インストール元の偽装、そしてパッケージマネージャーのセッション API。WebUI がポーリングする
  ファイルに進行状況を書き込み、WebUI が閉じられても生き続けます（`setsid`、そしてアプリフリーザーから
  逃れます）。

## 要点

- **すでにルート。** 「su を許可」のプロンプトも `sucompat` の切り替えもありません。エンジンはモジュール
  からルートとして実行され、`pm` / `settings` を直接呼び出します。
- **セッションインストール。** すべてのモードが `pm install-create` / `install-write` / `install-commit`
  を使うので、分割アプリが正しくインストールされ、インストール元（`-i`）がセッション時に設定されます。
- **ABX 対応。** `packages.xml` の initiator 偽装は `ABX\0` のバイナリ XML マジックを確認し、デコード、
  編集、再エンコードし、ラウンドトリップで検証し、バイト単位で正確にバックアップしてアトミックに
  スワップします。すべてのステップが通らない限り、ライブファイルには決して触れません。
- **再起動不要。** マウントするものが何もない自己完結型の WebUI モジュール: `customize.sh` がそれを
  アクティブなモジュールディレクトリにコピーするので、フラッシュした瞬間に機能します。
- **フラッシュレス更新。** 同梱の **VDLU** エンジンが、変更された content-addressed かつ ed25519 署名
  付きのファイルだけをダウンロードしてモジュールを更新します。フルの再フラッシュはありません。
- **デタッチ。** 長い操作は webview の外で実行され、WebUI を閉じても決して中断されません。

## 互換性の保証

- デバイス上の POSIX `sh`（`sh -n` が通る。`local` を超える bashism なし。`awk` への依存なし）。
- `pm` / `dumpsys` / `settings` / `cmd` が唯一使われるフレームワークツールで、すべて `/system/bin`
  経由です。
- 同梱バイナリ（`jq`、`abx2xml`/`xml2abx`）は一般的な経路では任意であり、来歴を携えています。ABX
  コンバーターは、存在する場合はデバイス自身の `/system/bin/abx2xml` にフォールバックします。

<!-- doc-footer -->

---

> _このドキュメントは Claude (Anthropic) で生成され、VD171 によって保守されています。修正や改善を歓迎します。[CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。_
