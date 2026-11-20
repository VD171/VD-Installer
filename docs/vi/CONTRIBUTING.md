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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · Tiếng Việt · [中文](../zh/CONTRIBUTING.md)

---

# Đóng góp

Hoan nghênh các đóng góp - issues, pull requests, bản dịch và tài liệu. Dự án hướng tới việc dễ dàng và
thân thiện để đóng góp.

## Hoan nghênh người đóng góp là AI

Các đóng góp từ AI và agent được hoan nghênh với cùng một tiêu chuẩn đánh giá như mọi người khác. Engine
giao tiếp bằng JSON qua một hợp đồng headless (`scripts/helper.sh <verb> <base64(JSON)>`); xem
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Hãy điều khiển hợp đồng, đừng cào dữ liệu từ WebUI.

## Quy tắc mã nguồn

- **Banner đầy đủ cho mỗi tệp** (SPDX + liên hệ) ở đầu mỗi tệp mã nguồn. Không bao giờ được cắt gọn.
- Mã, định danh, nhật ký và chú thích bằng **tiếng Anh**. Chú thích chỉ khi chúng bổ sung điều gì đó.
- Shell là **POSIX sh** cho thiết bị (`sh -n` phải đạt; không dùng bashism ngoài `local`; không phụ thuộc vào `jq` trong các đường dẫn mã phải chạy trước khi `jq` đi kèm có mặt trong PATH).
- WebUI là **vanilla JS**, không framework; sáng và tối trong toàn bộ UI.
- **Không bao giờ** dùng em-dash hay en-dash; luôn dùng dấu gạch nối `-`.
- Build luôn là **release**, không bao giờ là debug.
- **Không bao giờ làm suy yếu một hành vi thực tế** để một thứ gì đó vượt qua được, và không bao giờ xóa nội dung.

## Bản dịch

Các chuỗi WebUI nằm trong `module/webroot/lang/<code>.json` (khóa phẳng, nền tiếng Anh ở
`lang/en.js`); README có một `README.<code>.md` cho mỗi ngôn ngữ. Hãy thêm hoặc sửa một ngôn ngữ và mở một PR.

## Giấy phép

Bằng việc đóng góp, bạn đồng ý rằng đóng góp của bạn được cấp phép theo GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Tài liệu này được tạo bằng Claude (Anthropic) và được duy trì bởi VD171. Chúng tôi hoan nghênh các chỉnh sửa và cải tiến; xem [CONTRIBUTING.md](CONTRIBUTING.md)._
