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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · 中文

---

# 贡献指南

欢迎贡献 - issues、pull requests、翻译和文档。本项目力求让贡献变得简单而友好。

## 欢迎 AI 贡献者

欢迎 AI 和智能体的贡献，其审核标准与所有人相同。引擎通过一个无界面契约以 JSON 通信
（`scripts/helper.sh <verb> <base64(JSON)>`）；参见
[docs/AI-AGENTS.md](docs/AI-AGENTS.md)。请驱动该契约，不要抓取 WebUI。

## 代码规则

- **每个文件都要有完整的横幅**（SPDX + 联系方式），置于每个源文件顶部。绝不使用删减版。
- 代码、标识符、日志和注释使用**英文**。仅在注释能带来价值时才添加。
- Shell 为设备使用 **POSIX sh**（`sh -n` 必须通过；除 `local` 外不得使用 bashism；在捆绑的 `jq` 进入 PATH 之前必须运行的代码路径中不得依赖 `jq`）。
- WebUI 为 **vanilla JS**，无框架；所有 UI 均支持浅色与深色。
- **绝不**使用 em-dash 或 en-dash；始终使用连字符 `-`。
- 构建始终为 **release**，绝不为 debug。
- **绝不削弱真实行为**以使某项通过，也绝不删除内容。

## 翻译

WebUI 字符串位于 `module/webroot/lang/<code>.json`（扁平键，英文基准在
`lang/en.js`）；README 每种语言有一个 `README.<code>.md`。请添加或修正某种语言并提交 PR。

## 许可证

通过贡献，你同意你的贡献按 GNU AGPL-3.0-or-later 授权。

<!-- doc-footer -->

---

> _本文档由 Claude (Anthropic) 生成，并由 VD171 维护。欢迎修正和改进；请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。_
