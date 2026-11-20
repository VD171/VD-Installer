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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · 中文

---

# 捆绑的二进制文件：来源与审计

## 原则

- 没有任何不透明的东西随附。每一个捆绑的二进制文件都是在**构建时从其官方 upstream** 获取的，绝不从设备中拉取，
  并且每个文件都携带一个 sha256，以便可以复现该载荷。
- 二进制文件为**全部四种 ABI**（`arm64-v8a`、`armeabi-v7a`、`x86`、`x86_64`）捆绑；刷入安装程序会裁剪到设备的
  那一种。
- 它们独立运行：每个二进制文件的共享库闭包都随附在旁，引擎将 `LD_LIBRARY_PATH` 设置为捆绑的 `lib/`，因此不依赖
  是否安装了 Termux。

## 随附内容及其来源

| 二进制文件 | 来自 | 为何 |
|---|---|---|
| `jq` (+ `lib/`) | Termux 软件包仓库（`packages.termux.dev/apt`），官方 `.deb` | 引擎使用 JSON 通信；`jq` 解析参数并构建回复。 |
| `abx2xml` / `xml2abx` | [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) 发行版 | 为 `packages.xml` 安装来源伪装解码/编码 Android 二进制 XML（ABX），用于设备缺少 `/system/bin/abx2xml` 的情况（A12 之前）。当设备自身的转换器存在时优先使用。 |
| `vdlu/verify/<abi>/ed25519-mini` | 规范的 [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) 引擎 | 在免刷（VDLU）更新上验证 ed25519 签名，无需 OpenSSL。 |

构建步骤是 `.github/scripts/build_bin.sh`：它解析 Termux 软件包及其传递依赖，解压这些 `.deb`，复制所需的二进制
文件以及每个文件所需的共享库闭包（用 `readelf` 解析），然后获取独立的 ABX 转换器。

## 设备上的清单：`PROVENANCE.json`

每个 `bin/<abi>/` 都携带一个 `PROVENANCE.json`，列出每个随附文件（路径、大小、sha256）以及每个文件的 upstream
来源（软件包、版本、URL、归档 sha256）。它在设备上的 ABI 裁剪后仍然保留，因此审计线索随模块本身一并提供。

## 如何验证

1. 在设备上或在可刷入的 zip 中打开 `bin/<abi>/PROVENANCE.json`。
2. 从它记录的 URL 重新获取每个固定的来源。
3. 解压并将每个文件的 sha256 与清单比对。

可刷入的 zip 还在每个随附文件旁携带一个 `.sha256` 伴随文件；`customize.sh` 会在刷入时验证它们，并在任何不匹配时
（损坏或被截断的 zip）**中止**。

## 报告

发现不匹配或对来源的疑虑？请私下报告 - 参见 [SECURITY.md](../SECURITY.md)。

<!-- doc-footer -->

---

> _本文档由 Claude (Anthropic) 生成，并由 VD171 维护。欢迎修正和改进；请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。_
