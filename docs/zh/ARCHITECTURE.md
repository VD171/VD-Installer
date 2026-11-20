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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · 中文

---

# 架构

VDInstaller 是架设在一个 root shell 引擎之上的轻薄 WebUI。界面中没有任何部分拥有特权；每一个特权动作都是一次返回
单个 JSON 对象的 shell 调用。

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - 原生 JS WebUI（无框架），明/暗主题，22 种语言。它通过 KernelSU WebUI 桥接（`ksu.exec`）调用
  引擎并解析 JSON 回复。
- **`scripts/common.sh`** - 两个脚本都会引入的共享库：ABI/PATH 解析，`pm`/`dumpsys`/`fw` 包装器（干净的环境，
  使捆绑的 Termux 库永不遮蔽 ART 的库），JSON 与 `jq` 辅助函数，以及支持 ABX 的 `xml_edit`。
- **`scripts/helper.sh`** - WebUI 契约：每次调用一行 JSON。短 verb（version、config、browse、scan）内联运行；
  长 verb（install、uninstall）会分离出一个 worker 并返回一个 `opid`。
- **`scripts/worker.sh`** - 分离的安装引擎：四种安装模式、验证器开关、安装来源伪装，以及包管理器的会话 API。它把
  进度写入一个供 WebUI 轮询的文件，并在 WebUI 被关闭后仍然存活（`setsid`，并且它会逃离应用冻结器）。

## 要点

- **已是 root。** 没有"授予 su"提示，也不切换 `sucompat`；引擎以来自模块的 root 身份运行，并直接调用 `pm` /
  `settings`。
- **会话安装。** 所有模式都使用 `pm install-create` / `install-write` / `install-commit`，因此分拆应用能正确
  安装，而安装来源（`-i`）在会话时设置。
- **支持 ABX。** `packages.xml` 的发起方伪装会检查 `ABX\0` 二进制 XML 魔数，解码、编辑、重新编码、往返校验、
  逐字节备份并原子交换；只有在每一步都通过时才会触碰活动文件。
- **免重启。** 一个没有任何需要挂载内容的自包含 WebUI 模块：`customize.sh` 把它复制到活动的模块目录，因此它在被
  刷入的那一刻就能工作。
- **免刷更新。** 内置的 **VDLU** 引擎通过只下载改动过的、按内容寻址的、ed25519 签名的文件来更新模块 - 无需完整
  重刷。
- **分离运行。** 长操作在 webview 之外运行；关闭 WebUI 从不会中断它们。

## 兼容性保证

- 设备上的 POSIX `sh`（`sh -n` 通过；除 `local` 外没有 bashism；不依赖 `awk`）。
- `pm` / `dumpsys` / `settings` / `cmd` 是唯一使用的框架工具，全部经由 `/system/bin`。
- 捆绑的二进制文件（`jq`、`abx2xml`/`xml2abx`）对常规路径是可选的，并带有来源信息；当设备自身存在
  `/system/bin/abx2xml` 时，ABX 转换器会回退使用它。

<!-- doc-footer -->

---

> _本文档由 Claude (Anthropic) 生成，并由 VD171 维护。欢迎修正和改进；请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。_
