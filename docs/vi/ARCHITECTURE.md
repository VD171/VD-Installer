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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · Tiếng Việt · [中文](../zh/ARCHITECTURE.md)

---

# Kiến trúc

VDInstaller là một WebUI mỏng nằm trên một engine shell root. Không phần nào trong giao diện có đặc
quyền, mọi hành động đặc quyền là một lệnh gọi shell trả về một đối tượng JSON duy nhất.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI bằng JS thuần (không framework), sáng/tối, 22 ngôn ngữ. Nó gọi engine qua cầu
  nối WebUI của KernelSU (`ksu.exec`) và phân tích phản hồi JSON.
- **`scripts/common.sh`** - thư viện dùng chung được cả hai script nạp vào: phân giải ABI/PATH, các lớp
  bọc `pm`/`dumpsys`/`fw` (môi trường sạch để các thư viện Termux đi kèm không bao giờ che khuất thư
  viện của ART), các hàm trợ giúp JSON và `jq`, và `xml_edit` nhận biết ABX.
- **`scripts/helper.sh`** - hợp đồng WebUI: một dòng JSON mỗi lệnh gọi. Các verb ngắn (version, config,
  browse, scan) chạy trực tiếp, các verb dài (install, uninstall) tách một worker và trả về một `opid`.
- **`scripts/worker.sh`** - engine cài đặt tách rời: bốn chế độ cài đặt, công tắc trình xác minh, việc
  giả mạo nguồn cài đặt, và API phiên của trình quản lý gói. Nó ghi tiến trình vào một tập tin mà WebUI
  thăm dò, và tồn tại khi WebUI bị đóng (`setsid`, và nó thoát khỏi bộ đóng băng ứng dụng).

## Những điểm chính

- **Đã là root.** Không có lời nhắc "cấp su" và không bật tắt `sucompat`, engine chạy với quyền root từ
  mô-đun và gọi trực tiếp `pm` / `settings`.
- **Cài đặt theo phiên.** Mọi chế độ dùng `pm install-create` / `install-write` / `install-commit`,
  nên các ứng dụng split cài đúng cách và nguồn cài đặt (`-i`) được đặt vào lúc phiên.
- **Nhận biết ABX.** Việc giả mạo trình khởi tạo trong `packages.xml` kiểm tra số kỳ diệu XML nhị phân
  `ABX\0`, giải mã, chỉnh sửa, mã hóa lại, đi vòng để xác thực, sao lưu chính xác từng byte và hoán đổi
  nguyên tử, tập tin đang hoạt động không bao giờ bị đụng đến trừ khi mọi bước đều qua.
- **Không cần khởi động lại.** Một mô-đun WebUI khép kín không có gì để mount: `customize.sh` sao chép
  nó vào thư mục mô-đun đang hoạt động nên nó hoạt động ngay khoảnh khắc được flash.
- **Cập nhật không cần flash.** Engine **VDLU** đi kèm cập nhật mô-đun bằng cách chỉ tải về các tập tin
  đã thay đổi, được định địa chỉ theo nội dung, ký bằng ed25519 - không cần reflash toàn bộ.
- **Tách rời.** Các thao tác dài chạy bên ngoài webview, đóng WebUI không bao giờ làm gián đoạn chúng.

## Bảo đảm tương thích

- POSIX `sh` trên thiết bị (`sh -n` qua được, không có bashism nào ngoài `local`, không phụ thuộc
  `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` là các công cụ framework duy nhất được dùng, tất cả qua
  `/system/bin`.
- Các tệp nhị phân đi kèm (`jq`, `abx2xml`/`xml2abx`) là tùy chọn cho đường đi thông thường và mang
  theo nguồn gốc, trình chuyển đổi ABX quay về dùng `/system/bin/abx2xml` của chính thiết bị khi có.

<!-- doc-footer -->

---

> _Tài liệu này được tạo bằng Claude (Anthropic) và được duy trì bởi VD171. Chúng tôi hoan nghênh các chỉnh sửa và cải tiến, xem [CONTRIBUTING.md](CONTRIBUTING.md)._
