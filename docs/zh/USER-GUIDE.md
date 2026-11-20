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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · 中文

---

# VDInstaller 用户指南

## 目录

1. [VDInstaller 是什么](#1-vdinstaller-是什么)
2. [要求](#2-要求)
3. [安装与首次运行](#3-安装与首次运行)
4. [WebUI 导览](#4-webui-导览)
5. [安装 APK](#5-安装-apk)
6. [选项](#6-选项)
7. [通过 AI 助手驱动 VDInstaller](#7-通过-ai-助手驱动-vdinstaller)
8. [故障排除与常见问题](#8-故障排除与常见问题)

## 1. VDInstaller 是什么

VDInstaller 是一个用于 KernelSU / APatch / Magisk 的 **WebUI 模块**，它以 root 身份安装旁加载的 APK，且毫无阻碍：
没有"授予 su"提示，没有终端，也不必与 Play Protect 验证器较劲。它可以处理单个 APK、一次处理整个文件夹，以及分拆
（split）应用（`.xapk` / `.apkm` / `.apks` / `.zip` 或散放的分拆文件），并且能够把安装来源呈现为 Play Store，
使应用看起来不像是旁加载的。

## 2. 要求

- Android 8.0 或更新版本（API 26+）。
- 一个支持 WebUI 的 root 方案：**KernelSU**、**APatch** 或 **Magisk**。

## 3. 安装与首次运行

1. 从 [Releases](https://github.com/VD171/VD-Installer/releases) 页面下载最新的
   `VD-Installer-vX.XX-universal.zip`。
2. 在你的 root 管理器中将其作为模块刷入（*Modules -> Install from storage*）。
3. VDInstaller **无需重启**即可激活 - 它是自包含的（WebUI + 捆绑的二进制文件），因此没有任何需要挂载的东西。
4. 从你的 root 管理器的模块列表中打开 **VDInstaller** WebUI。

刷入时，安装程序只保留你设备的 ABI，并运行一道强制的 `.sha256` 完整性校验，如果 zip 损坏或被截断，它会**中止**。
设置保存在 `/data/adb/vdinstaller` 中，并在更新后保留。

## 4. WebUI 导览

三个标签页：

- **Install** - 选择一种模式，选取 APK 或文件夹，进行安装，观看实时进度。
- **Options** - 安装来源、Play Protect 验证器开关，以及安装标志。一切都会自动保存。
- **About** - 版本、功能说明、要求、链接和许可证。

## 5. 安装 APK

你在 **Install** 标签页上选择模式；VDInstaller 从不猜测。

| 模式 | 你提供 | 发生什么 |
|---|---|---|
| **Single APK** | 一个 `.apk` 文件 | 一个安装会话，一个应用。 |
| **Folder of APKs**（批量） | 一个装有独立 `.apk` 文件的文件夹 | 每个 APK 各自单独安装，一个接一个；部分批量会报告哪些失败以及原因。 |
| **Split archive** | 一个 `.xapk` / `.apkm` / `.apks` / `.zip` | 先解压，然后 `base.apk` + 各分拆在单个会话中作为一个应用安装（存在 XAPK OBB 时也会一并放置）。 |
| **Split folder** | 一个装有某个应用散放分拆 `.apk` 文件的文件夹 | 各分拆在单个会话中作为一个应用安装。 |

"分拆"应用是指一个被划分为基础包加上按密度 / 按 ABI / 按语言的配置 APK 的 APK；它们必须在一个会话中**一起**安装，
而 Split 模式会替你完成这件事。

### 5.1 Browse 对话框

**Browse** 打开一个文件选择器，它在某个路径下列出文件夹和可安装的文件：

- 点按一个**文件夹**进入其中；**Up** 回到上一级。
- 在文件模式（Single APK / Split archive）中，点按一个**文件**来选中它。
- 在文件夹模式（Folder of APKs / Split folder）中，进入该文件夹并点按 **Use this folder**。

你也可以直接输入或粘贴一个路径（例如 `/sdcard/Download/app.apk`）。

### 5.2 进度、取消、恢复

安装以**分离的 root 进程**运行。进度卡片显示当前阶段；**Cancel** 可停止它。如果你在安装途中关闭 WebUI，安装会继续
进行，当你重新打开时界面会按操作 id 重新接上。

## 6. 选项

这里的一切都会自动保存，并应用于下一次安装。

### 6.1 安装来源

一个刚旁加载的应用会向每个读取它的应用（以及向证明机制）宣告它是被旁加载的。VDInstaller 可以改为把来源呈现为
Play Store。

- **Show the Play Store as installer**（默认开启） - 通过 `pm install-create -i com.android.vending` 设置
  `installerPackageName`。立即生效。
- **Also spoof the initiator**（默认开启） - 通过编辑 `/data/system/packages.xml` 设置 `installInitiator` 和
  `packageSource`。这是**支持 ABX 的**（解码 -> 编辑 -> 重新编码，带有逐字节精确的备份和一次原子交换），并在**下次
  重启之后**生效，因为包管理器会缓存 `packages.xml`。

### 6.2 Play Protect 包验证器

旁加载安装可能被 Play Protect 的包验证器以 `INSTALL_FAILED_VERIFICATION_FAILURE` 拒绝。这是一个三态开关：

- **Keep as it was**（默认） - 仅在安装期间关闭，之后恢复到其**精确的**先前状态（如果原本没有明确的值，则再次删除，
  因为在本无任何值的地方留下 `0`/`1` 本身在隐身设备上就是一个破绽）。
- **Always on** - 强制开启并保持。
- **Always off** - 强制关闭并保持。WebUI 会警告：让它保持关闭是一个隐身破绽，并会对每次安装都禁用恶意软件扫描。

### 6.3 Developer Verification

Android 2026 的 Developer Verification 会在已认证设备上阻止安装来自未注册开发者的应用，但它由一个**独立的服务**
执行，而非 Play Protect，并且 root 安装**已经免除**于它（与 ADB 安装得到的免除相同）。VDInstaller 无论如何都会
安装你的 APK，因此这个开关是**尽力而为且诚实的**：只有当确实存在真正的开关时它才应用，绝不假装去拨动一个毫无作用的
开关。

### 6.4 安装标志

| 标志 | 作用 |
|---|---|
| **Grant all runtime permissions** | 在安装时授予每一项运行时权限（`-g`）。 |
| **Allow test packages** | 安装被标记为仅测试的包（`-t`）。 |
| **Bypass low target SDK block** | 安装 `targetSdk` 非常旧的应用。 |
| **Target user** | 要为其安装的 Android 用户 id（默认 `0`）。 |

### 6.5 保持隐藏

为了隐身，考虑用 HMA-OSS 隐藏你的 root 管理器和敏感应用。VDInstaller **绝不触碰你的 HMA-OSS 设置** - 这个提示
只是一个提醒；更改由你自己在 HMA-OSS 中进行。

## 7. 通过 AI 助手驱动 VDInstaller

引擎通过 `scripts/helper.sh` 使用一个小型 JSON 契约通信，因此代理可以驱动 WebUI 能做的每一个动作。参见
[AI-AGENTS](AI-AGENTS)。请驱动该契约，不要抓取 WebUI。

## 8. 故障排除与常见问题

**我遇到 `INSTALL_FAILED_VERIFICATION_FAILURE`。** 那是 Play Protect 的包验证器。当验证器开关保持在
**Keep as it was**（默认）时，VDInstaller 会在安装期间关闭它并随后恢复，因此不会发生这种情况。

**我开启了 Play Store 来源，但应用看起来仍像是旁加载的。** 安装程序部分会立即生效；发起方部分（`packages.xml`）
在**下次重启之后**生效。

**它会绕过 Google 的 Developer Verification 吗？** 它不需要 - root 安装已被免除（见 6.3）。并没有为它准备的
假开关。

**它需要重启吗？** 不需要，除了可选的发起方伪装。

**卸载 VDInstaller 会删除我安装的应用吗？** 不会 - 那些是由系统拥有的真实安装；移除模块只会清理 VDInstaller
自身的状态。

**它安全吗？** 它安装你选择的 APK，并且在关闭验证器时会跳过一次恶意软件扫描 - 只安装你信任的 APK。它从不悄悄地
削弱任何东西。

<!-- doc-footer -->

---

> _本文档由 Claude (Anthropic) 生成，并由 VD171 维护。欢迎修正和改进；请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。_
