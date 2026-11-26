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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · Tiếng Việt · [中文](../zh/BINARIES.md)

---

# Các tệp nhị phân đi kèm: nguồn gốc và kiểm toán

## Nguyên tắc

- Không có gì mờ ám được đưa vào. Mỗi tệp nhị phân đi kèm được lấy **lúc build từ upstream chính thức
  của nó**, không bao giờ rút ra từ một thiết bị, và mỗi tập tin mang theo một sha256 để có thể tái tạo
  phần tải trọng.
- Các tệp nhị phân được đóng gói cho **cả bốn ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`);
  trình cài đặt flash tỉa xuống còn ABI duy nhất của thiết bị.
- Chúng chạy độc lập: bao đóng thư viện dùng chung của mỗi tệp nhị phân được đưa kèm, và engine đặt
  `LD_LIBRARY_PATH` trỏ tới `lib/` đi kèm, nên không phụ thuộc vào việc Termux có được cài đặt hay
  không.

## Những gì được đưa vào, và từ đâu

| Tệp nhị phân | Từ | Vì sao |
|---|---|---|
| `jq` (+ `lib/`) | kho gói Termux (`packages.termux.dev/apt`), `.deb` chính thức | engine giao tiếp bằng JSON; `jq` phân tích đối số và dựng phản hồi. |
| `abx2xml` / `xml2abx` | bản phát hành [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | giải mã/mã hóa XML nhị phân của Android (ABX) cho việc giả mạo nguồn cài đặt trong `packages.xml`, nơi thiết bị thiếu `/system/bin/abx2xml` (trước A12). Trình chuyển đổi của chính thiết bị được ưu tiên khi có. |
| `vdlu/verify/<abi>/ed25519-mini` | engine [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) chuẩn mực | xác minh chữ ký ed25519 trên các bản cập nhật không cần flash (VDLU), không dùng OpenSSL. |

Bước build là `.github/scripts/build_bin.sh`: nó phân giải gói Termux cùng các phụ thuộc bắc cầu, giải
nén các `.deb`, sao chép các tệp nhị phân mong muốn và bao đóng thư viện dùng chung mà mỗi tệp cần
(phân giải bằng `readelf`), rồi lấy trình chuyển đổi ABX độc lập.

## Bản kê khai trên thiết bị: `PROVENANCE.json`

Mỗi `bin/<abi>/` mang theo một `PROVENANCE.json` liệt kê mọi tập tin được đưa vào (đường dẫn, kích
thước, sha256) và nguồn upstream của mỗi tập tin (gói, phiên bản, URL, sha256 của kho lưu trữ). Nó tồn
tại qua việc tỉa ABX trên thiết bị, nên dấu vết kiểm toán được đưa đi kèm với chính mô-đun.

## Cách xác minh

1. Mở `bin/<abi>/PROVENANCE.json` trên thiết bị hoặc trong tập tin zip có thể flash.
2. Lấy lại từng nguồn đã ghim từ URL mà nó ghi lại.
3. Giải nén và so sánh sha256 của từng tập tin với bản kê khai.

Tập tin zip có thể flash còn mang kèm một tập đi kèm `.sha256` bên cạnh mỗi tập tin được đưa vào;
`customize.sh` xác minh chúng lúc flash và **hủy bỏ** khi có bất kỳ sự không khớp nào (một tập tin zip
bị hỏng hoặc bị cắt cụt).

## Báo cáo

Tìm thấy một sự không khớp hoặc một lo ngại về nguồn gốc? Hãy báo cáo riêng tư - xem
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Tài liệu này được tạo bằng Claude (Anthropic) và được duy trì bởi VD171. Chúng tôi hoan nghênh các chỉnh sửa và cải tiến, xem [CONTRIBUTING.md](CONTRIBUTING.md)._
