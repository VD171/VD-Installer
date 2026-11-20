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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · 日本語 · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# 貢献について

貢献を歓迎します - issue、プルリクエスト、翻訳、ドキュメント。本プロジェクトは、貢献しやすく参加を歓迎する場を目指しています。

## AI 貢献者を歓迎します

AI およびエージェントによる貢献は、他の全員と同じレビュー基準で歓迎します。エンジンはヘッドレスなコントラクト上で JSON をやり取りします (`scripts/helper.sh <verb> <base64(JSON)>`)。[docs/AI-AGENTS.md](docs/AI-AGENTS.md) を参照してください。WebUI をスクレイピングせず、コントラクトを駆動してください。

## コード規約

- すべてのソースファイルの先頭に **ファイルごとの完全なバナー** (SPDX + 連絡先) を置くこと。省略版は決して使わないこと。
- コード、識別子、ログ、コメントは **英語** で。コメントは何かを付け加えるときのみ。
- デバイス向けのシェルは **POSIX sh** (`sh -n` が通ること。`local` を超える bashism は禁止。バンドルされた `jq` が PATH に載る前に実行されなければならないコードパスでは `jq` への依存を持たないこと)。
- WebUI は **バニラ JS** でフレームワークなし。すべての UI でライトとダークの両方に対応。
- em ダッシュや en ダッシュは **決して** 使わず、常にハイフン `-` を使うこと。
- ビルドは常に **release** で、debug は決して使わないこと。
- 何かを通すために **実際の挙動を決して弱めない** こと、またコンテンツを決して削除しないこと。

## 翻訳

WebUI の文字列は `module/webroot/lang/<code>.json` にあります (フラットなキー、英語のベースは `lang/en.js`)。README には言語ごとに `README.<code>.md` があります。言語を追加または修正して PR を開いてください。

## ライセンス

貢献することで、あなたの貢献が GNU AGPL-3.0-or-later の下でライセンスされることに同意したものとします。

<!-- doc-footer -->

---

> _このドキュメントは Claude (Anthropic) で生成され、VD171 によって保守されています。修正や改善を歓迎します。[CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。_
