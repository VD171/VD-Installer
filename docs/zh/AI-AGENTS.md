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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · 中文

---

# AI 代理：无界面契约

VDInstaller 由一个 shell 契约驱动。一个代理（像 WebUI 一样以 root 身份运行）调用：

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

并在 stdout 上读取恰好一个 JSON 对象。成功是 `{"ok":true,...}`；失败是
`{"ok":false,"code":"ERR_...","message":"..."}`。长操作返回一个你需要轮询的 `opid`。不要抓取 WebUI；请使用
这个契约。

## Verb

| Verb | 参数（JSON） | 返回 |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | 配置对象 |
| `config-set` | 任意要合并的配置键 | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}`（type = apk \| archive） |
| `install` | `{mode, path \| dir, ...options}` | `{opid}`（分离） |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}`（分离） |
| `progress` | opid 字符串的 base64（非 JSON） | 实时进度对象；完成时为 `done:true` |
| `cancel` | opid 字符串的 base64 | `{cancelled}` |
| `verifier-status` | - | 当前验证器设置 |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | 清理过期日志 |

## 安装模式

| `mode` | 接受 | 含义 |
|---|---|---|
| `single` | `path` | 一个 `.apk` |
| `batch` | `dir` | 一个装有独立 `.apk` 文件的文件夹，每个各安装一次 |
| `archive` | `path` | 一个成组的分拆归档（`.xapk` / `.apkm` / `.apks` / `.zip`） |
| `splitdir` | `dir` | 一个装有某个应用散放分拆 `.apk` 文件的文件夹 |

## 选项（在参数中按操作提供，或通过 `config-set` 持久化）

`spoof_installer` (bool)、`spoof_installer_pkg` (string)、`deep_spoof` (bool)、
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`)、
`grant_all_perms`、`allow_test`、`bypass_low_target_sdk` (bool)、`target_user` (int)。

## 进度

用 `opid` 轮询 `progress`。该对象携带 `percent`、`phase`
（`starting` / `extracting` / `installing` / `uninstalling` / `done`）、一个可选的 `item`，并在完成时携带
`done:true` 以及一个 `result`（single/split）、一个 `results[]` 数组（batch），或一个 `error`。

## 安全护栏

- 验证器开关和 `packages.xml` 编辑都是可逆且经过审计的（`logs/audit.jsonl`）。
- `install`/`uninstall` 会改变设备状态；请在调用前确认意图，就像 WebUI 所做的那样。
- 永远不要抓取或自动化 WebUI 本身；这个契约才是受支持的接口。

<!-- doc-footer -->

---

> _本文档由 Claude (Anthropic) 生成，并由 VD171 维护。欢迎修正和改进；请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。_
