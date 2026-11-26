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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · Tiếng Việt · [中文](../zh/AI-AGENTS.md)

---

# Tác nhân AI: hợp đồng không giao diện

VDInstaller được điều khiển bởi một hợp đồng shell duy nhất. Một tác nhân (chạy với quyền root, như
WebUI vẫn làm) gọi:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

và đọc đúng một đối tượng JSON trên stdout. Thành công là `{"ok":true,...}`, thất bại là
`{"ok":false,"code":"ERR_...","message":"..."}`. Các thao tác dài trả về một `opid` để bạn thăm dò.
Đừng cào WebUI, hãy dùng hợp đồng này.

## Các verb

| Verb | Đối số (JSON) | Trả về |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | đối tượng cấu hình |
| `config-set` | bất kỳ khóa cấu hình nào để hợp nhất | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (tách rời) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (tách rời) |
| `progress` | base64 của chuỗi opid (không phải JSON) | đối tượng tiến trình trực tiếp; `done:true` khi hoàn tất |
| `cancel` | base64 của chuỗi opid | `{cancelled}` |
| `verifier-status` | - | thiết lập trình xác minh hiện tại |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | tỉa các nhật ký cũ |

## Chế độ cài đặt

| `mode` | nhận | ý nghĩa |
|---|---|---|
| `single` | `path` | một `.apk` |
| `batch` | `dir` | một thư mục chứa các tập tin `.apk` độc lập, mỗi tập cài một lần |
| `archive` | `path` | một kho lưu trữ split gộp nhóm (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | một thư mục chứa các tập tin split `.apk` rời rạc của một ứng dụng |

## Tùy chọn (theo từng thao tác trong đối số, hoặc lưu bền qua `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Tiến trình

Thăm dò `progress` bằng `opid`. Đối tượng mang theo `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), một `item` tùy chọn, và khi hoàn
tất là `done:true` cùng một `result` (single/split), một mảng `results[]` (batch), hoặc một `error`.

## Hàng rào an toàn

- Công tắc trình xác minh và việc chỉnh sửa `packages.xml` đều có thể đảo ngược và được kiểm toán
  (`logs/audit.jsonl`).
- `install`/`uninstall` thay đổi trạng thái thiết bị, hãy xác nhận ý định trước khi gọi, như WebUI làm.
- Không bao giờ cào hoặc tự động hóa chính WebUI, hợp đồng này là bề mặt được hỗ trợ.

<!-- doc-footer -->

---

> _Tài liệu này được tạo bằng Claude (Anthropic) và được duy trì bởi VD171. Chúng tôi hoan nghênh các chỉnh sửa và cải tiến, xem [CONTRIBUTING.md](CONTRIBUTING.md)._
