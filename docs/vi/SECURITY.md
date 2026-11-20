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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · Tiếng Việt · [中文](../zh/SECURITY.md)

---

# Chính sách bảo mật

## Mô hình mối đe dọa trong một dòng

VDInstaller chạy với quyền root và cài đặt các APK mà người dùng chọn một cách rõ ràng; việc tắt bộ xác
minh Play Protect cho một lần cài đặt sẽ vô hiệu hóa việc quét phần mềm độc hại, nên đây là "cài đặt không
ma sát", chứ không phải "cài đặt an toàn" - chỉ cài những APK mà bạn tin tưởng.

## Những gì nó làm và không làm

- Theo mặc định, nó khôi phục bộ xác minh gói về đúng trạng thái trước đó (để lại một `0`/`1` ở nơi vốn
  không có gì tự nó đã là một dấu hiệu, nên nó bị xóa lại).
- Nó không bao giờ động đến thiết lập HMA-OSS của bạn; việc ẩn ứng dụng là một khuyến nghị mà bạn tự thực hiện.
- Việc chỉnh sửa nguồn cài đặt trong `packages.xml` nhận biết ABX, sao lưu tệp đang hoạt động chính xác
  từng byte trước bất kỳ thay đổi nào, thực hiện round-trip để xác thực, và để nguyên tệp đang hoạt động khi có bất kỳ lỗi nào.
- Các tệp nhị phân đi kèm được tải về lúc build từ upstream chính thức của chúng và mang theo một `PROVENANCE.json`.

## Báo cáo lỗ hổng

Vui lòng báo cáo riêng tư trước. Hãy bao gồm các bước tái hiện, phiên bản bị ảnh hưởng và tác động.

- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me
- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)

<!-- doc-footer -->

---

> _Tài liệu này được tạo bằng Claude (Anthropic) và được duy trì bởi VD171. Chúng tôi hoan nghênh các chỉnh sửa và cải tiến; xem [CONTRIBUTING.md](CONTRIBUTING.md)._
