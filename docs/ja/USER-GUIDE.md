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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · 日本語 · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# VDInstaller ユーザーガイド

## 目次

1. [VDInstaller とは](#1-vdinstaller-とは)
2. [動作要件](#2-動作要件)
3. [インストールと初回起動](#3-インストールと初回起動)
4. [WebUI ツアー](#4-webui-ツアー)
5. [APK のインストール](#5-apk-のインストール)
6. [オプション](#6-オプション)
7. [AI アシスタントから VDInstaller を操作する](#7-ai-アシスタントから-vdinstaller-を操作する)
8. [トラブルシューティングと FAQ](#8-トラブルシューティングと-faq)

## 1. VDInstaller とは

VDInstaller は、サイドロードした APK をルート権限で摩擦なくインストールする KernelSU / APatch / Magisk の
**WebUI モジュール** です。「su を許可」のプロンプトも、ターミナルも不要で、Play Protect の verifier と
格闘する必要もありません。単体の APK、フォルダー内のすべてをまとめて、そして分割アプリ（`.xapk` /
`.apkm` / `.apks` / `.zip` またはバラバラの分割ファイル）を扱い、インストール元を Play Store として
提示できるので、アプリがサイドロードされたように見えません。

## 2. 動作要件

- Android 8.0 以降（API 26+）。
- WebUI 対応のルートソリューション: **KernelSU**、**APatch**、または **Magisk**。

## 3. インストールと初回起動

1. [Releases](https://github.com/VD171/VD-Installer/releases) ページから最新の
   `VD-Installer-vX.XX-universal.zip` をダウンロードします。
2. ルートマネージャーでモジュールとしてフラッシュします（*Modules -> Install from storage*）。
3. VDInstaller は **再起動なし** で有効になります。自己完結型（WebUI + 同梱バイナリ）なので、マウント
   するものは何もありません。
4. ルートマネージャーのモジュール一覧から **VDInstaller** WebUI を開きます。

フラッシュ時、インストーラーはデバイスの ABI だけを残し、必須の `.sha256` 整合性ゲートを実行します。
これは zip が破損または切り詰められていると **中止** します。設定は `/data/adb/vdinstaller` に保存され、
更新後も残ります。

## 4. WebUI ツアー

3 つのタブ:

- **Install** - モードを選び、APK かフォルダーを選択し、インストールして、進行状況をリアルタイムで見ます。
- **Options** - インストール元、Play Protect verifier のトグル、インストールフラグ。すべて自動的に
  保存されます。
- **About** - バージョン、機能、動作要件、リンク、ライセンス。

## 5. APK のインストール

モードは **Install** タブで選びます。VDInstaller は決して推測しません。

| モード | 与えるもの | 何が起こるか |
|---|---|---|
| **Single APK** | 1 つの `.apk` ファイル | 1 回のインストールセッション、1 つのアプリ。 |
| **Folder of APKs**（バッチ） | 独立した `.apk` ファイルのフォルダー | 各 APK が個別に、1 つずつ順番にインストールされます。部分的なバッチでは、どれがなぜ失敗したかを報告します。 |
| **Split archive** | `.xapk` / `.apkm` / `.apks` / `.zip` | 展開され、`base.apk` + 分割が 1 つのアプリとして 1 セッションでインストールされます（XAPK OBB があれば一緒に配置されます）。 |
| **Split folder** | 1 つのアプリのバラバラの分割 `.apk` ファイルが入ったフォルダー | 分割が 1 つのアプリとして 1 セッションでインストールされます。 |

「分割（split）」アプリとは、1 つの APK がベースと、密度ごと / ABI ごと / 言語ごとの設定 APK に
分けられたものです。これらは 1 セッションで **一緒に** インストールする必要があり、Split モードが
それを代わりに行います。

### 5.1 Browse ダイアログ

**Browse** は、あるパスのフォルダーとインストール可能なファイルを一覧するファイルピッカーを開きます:

- **フォルダー** をタップして中に入ります。**Up** で親に戻ります。
- ファイルモード（Single APK / Split archive）では、**ファイル** をタップして選択します。
- フォルダーモード（Folder of APKs / Split folder）では、フォルダーの中に移動して
  **Use this folder** をタップします。

パスを直接入力または貼り付けることもできます（例: `/sdcard/Download/app.apk`）。

### 5.2 進行状況、キャンセル、再開

インストールは **デタッチされたルートプロセス** として実行されます。進行状況カードがフェーズを
表示します。**Cancel** で停止します。インストールの途中で WebUI を閉じても、インストールは続行され、
再び開いたときに UI は操作 ID で再接続します。

## 6. オプション

ここのすべては自動的に保存され、次のインストールに適用されます。

### 6.1 インストール元

サイドロードしたばかりのアプリは、それを読み取るすべてのアプリ（および認証）に、サイドロードされた
ことを知らせます。VDInstaller は代わりにインストール元を Play Store として提示できます。

- **Play Store をインストーラーとして表示**（デフォルトはオン） - `pm install-create -i com.android.vending`
  で `installerPackageName` を設定します。すぐに適用されます。
- **initiator も偽装する**（デフォルトはオン） - `/data/system/packages.xml` を編集して `installInitiator`
  と `packageSource` を設定します。これは **ABX 対応** です（デコード -> 編集 -> 再エンコード、バイト単位で
  正確なバックアップとアトミックなスワップを伴う）。パッケージマネージャーが `packages.xml` を
  キャッシュするため、**次の再起動後** に適用されます。

### 6.2 Play Protect パッケージ verifier

サイドロードのインストールは、Play Protect のパッケージ verifier によって
`INSTALL_FAILED_VERIFICATION_FAILURE` で拒否されることがあります。3 択のトグル:

- **元のままにする**（デフォルト） - インストールの間だけオフにし、その後 **正確に** 以前の状態へ
  復元します（明示的な値がなかった場合は再び削除します。なぜなら、何もなかったところの `0`/`1` 自体が
  ステルスデバイスでの手がかりになるからです）。
- **常にオン** - 強制的にオンにして保持します。
- **常にオフ** - 強制的にオフにして保持します。WebUI は警告します: オフのままにするのはステルスの
  手がかりであり、すべてのインストールでマルウェアスキャンを無効にします。

### 6.3 Developer Verification

Android の 2026 年の Developer Verification は、認証済みデバイスで未登録の開発者からのアプリの
インストールをブロックしますが、これは Play Protect ではなく **別のサービス** によって強制され、
**ルートインストールはすでに免除** されています（ADB インストールが得るのと同じ免除）。VDInstaller は
いずれにせよあなたの APK をインストールするので、このトグルは **ベストエフォートで正直** です: 実際の
ノブが存在する場合にのみそれを適用し、何もしないスイッチを切り替えるふりは決してしません。

### 6.4 インストールフラグ

| フラグ | 効果 |
|---|---|
| **すべてのランタイム権限を付与** | インストール時にすべてのランタイム権限を付与します（`-g`）。 |
| **テストパッケージを許可** | test-only とマークされたパッケージをインストールします（`-t`）。 |
| **低ターゲット SDK ブロックを回避** | 非常に古い `targetSdk` のアプリをインストールします。 |
| **対象ユーザー** | インストール先の Android ユーザー ID（デフォルト `0`）。 |

### 6.5 隠れたままでいる

ステルスのために、ルートマネージャーや機密性の高いアプリを HMA-OSS で隠すことを検討してください。
VDInstaller は **あなたの HMA-OSS 設定に決して触れません** - このヒントはあくまでリマインダーで、
変更はあなた自身が HMA-OSS で行います。

## 7. AI アシスタントから VDInstaller を操作する

エンジンは `scripts/helper.sh` を介して小さな JSON コントラクトを話すので、エージェントは WebUI が
できるすべてのアクションを操作できます。[AI-AGENTS](AI-AGENTS) を参照してください。WebUI を
スクレイピングするのではなく、コントラクトを操作してください。

## 8. トラブルシューティングと FAQ

**`INSTALL_FAILED_VERIFICATION_FAILURE` が出る。** それは Play Protect のパッケージ verifier です。
verifier トグルを **元のままにする**（デフォルト）にしておくと、VDInstaller はインストールの間それを
オフにして復元するので、これは起こりません。

**Play Store のソースをオンにしたのに、アプリがまだサイドロードされたように見える。** インストーラー
部分はすぐに適用されます。initiator 部分（`packages.xml`）は **次の再起動後** に適用されます。

**Google の Developer Verification をバイパスしますか?** その必要はありません - ルートインストールは
免除されています（6.3 を参照）。それ用の偽のスイッチはありません。

**再起動は必要ですか?** いいえ、オプションの initiator 偽装を除いて。

**VDInstaller をアンインストールすると、インストールしたアプリも削除されますか?** いいえ - それらは
システムが所有する実際のインストールです。モジュールを削除しても、VDInstaller 自身の状態が片付けられる
だけです。

**安全ですか?** あなたが選んだ APK をインストールし、verifier をオフにするとマルウェアスキャンを
スキップします - 信頼できる APK だけをインストールしてください。何かをひそかに弱めることは決して
ありません。

<!-- doc-footer -->

---

> _このドキュメントは Claude (Anthropic) で生成され、VD171 によって保守されています。修正や改善を歓迎します。[CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。_
