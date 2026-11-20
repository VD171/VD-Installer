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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · Tiếng Việt · [中文](README.zh.md)

# VDInstaller

> Trình cài sideload qua root không rào cản - KernelSU / APatch / Magisk WebUI.

## Tại sao

Cài một APK sideload trên điện thoại đã root ồn ào hơn mức cần thiết: trình xác minh gói của Play Protect
có thể ném ra `INSTALL_FAILED_VERIFICATION_FAILURE`, các app chia nhỏ (`.xapk` / `.apkm` / `.apks`)
cần dùng session API bằng tay, và một app vừa cài sẽ tự khai là "sideloaded" với mọi app đọc nguồn cài
đặt của nó. VDInstaller làm tất cả những việc đó thay bạn, đã sẵn ở chế độ root, không có lời nhắc
"grant su" và không cần terminal.

## Tính năng

- **Mọi hình thức APK** - một `.apk` đơn lẻ, cả một thư mục các APK độc lập (batch), một archive chia
  nhỏ theo nhóm (`.xapk` / `.apkm` / `.apks` / `.zip`), hoặc một thư mục chứa các split APK rời rạc.
- **Không còn bức tường xác minh** - một công tắc 3 trạng thái cho trình xác minh gói của Play Protect:
  giữ nguyên như cũ (chỉ tắt trong lúc cài, rồi khôi phục chính xác), luôn bật, hoặc luôn tắt.
- **Trung thực về Developer Verification** - một bản cài qua root vốn đã được miễn trừ khỏi Developer
  Verification 2026 của Android; công tắc này chỉ là nỗ lực tối đa và nói rõ điều đó, không bao giờ là một
  nút giả.
- **Không phải "sideloaded"** - tùy chọn trình bày nguồn cài đặt là Play Store, cả phần trình cài (lúc
  cài) lẫn phần khởi tạo (qua một chỉnh sửa `packages.xml` có nhận biết ABX).
- **Tách rời và có thể tiếp tục** - các bản cài chạy như một tiến trình root tách rời; đóng WebUI không
  bao giờ làm gián đoạn chúng, và giao diện gắn kết lại theo operation id.
- **Bạn quyết định** - hạ cấp, gói test, cấp mọi quyền runtime, người dùng đích, bỏ qua chặn target
  SDK thấp: tất cả đều tùy chọn.
- **Offline, tự chứa đủ, không cần khởi động lại** - một module WebUI với các binary đóng kèm; dùng được
  ngay khi vừa flash.

## Tác nhân AI

Dự án này chào đón những người đóng góp là AI và tác nhân. Engine nói JSON qua một hợp đồng headless nhỏ
(`scripts/helper.sh <verb> <base64(JSON)>`), được mô tả trong
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), nên một tác nhân có thể điều khiển mọi hành động mà WebUI làm
được - đừng scrape WebUI. Các bản vá từ AI được đánh giá theo cùng tiêu chuẩn review như bất kỳ đóng góp
nào khác.

## Cài đặt

Flash tệp zip trong KernelSU, APatch hoặc Magisk và mở WebUI của VDInstaller từ trình quản lý root của
bạn. Trình cài chỉ giữ lại ABI của thiết bị bạn và chạy cổng kiểm tra toàn vẹn `.sha256` bắt buộc
(hủy khi zip bị hỏng hoặc bị cắt cụt). Android 8.0 (API 26) trở lên.

## Bảo mật

VDInstaller chạy ở chế độ root và cài những APK bạn chọn; tắt trình xác minh gói cho một bản cài sẽ vô
hiệu hóa một lần quét mã độc, nên chỉ cài những APK bạn tin tưởng. Nó không bao giờ âm thầm làm yếu đi
bảo mật thiết bị: theo mặc định trình xác minh được khôi phục về đúng trạng thái trước đó, và nó không
bao giờ động vào thiết lập HMA-OSS của bạn. Báo lỗi theo [SECURITY.md](SECURITY.md).

## Build

Luôn release, không bao giờ debug. `.github/scripts/build_bin.sh` lấy `jq` từ kho apt Termux (cùng
với bề mặt thư viện chia sẻ của nó) và các trình chuyển đổi `abx2xml` / `xml2abx` độc lập, cho cả bốn
ABI, mỗi cái kèm một `PROVENANCE.json`. Workflow release lắp ráp các zip flash được, ghi các bản đồng
hành `.sha256`, điền `update.json` và phát hành dưới danh nghĩa `github-actions[bot]`.

## Tài liệu

Các hướng dẫn nằm trong [docs/](docs/) và được mirror sang GitHub wiki. Xem
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) để biết hợp đồng headless.

## Xem thêm

- [VDBackup](https://github.com/VD171/VD-Backup) - sao lưu & khôi phục toàn bộ app và dữ liệu, qua root.
- [VDInfos](https://github.com/VD171/VD-Infos) - đọc mọi thông tin thiết bị bằng mọi phương pháp, rồi so sánh.
- [VDGoogle](https://github.com/VD171/VDGoogle) - đọc RCS, Wallet và các attestation qua root.
- [COPG-VD](https://github.com/VD171/COPG-VD) - module fingerprint và props Pixel.

## Liên hệ

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/root-webui-v1-00-vd-installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## Giấy phép

VDInstaller được cấp phép theo GNU AGPL-3.0-or-later. Xem [LICENSE](LICENSE). NETWORK COPYLEFT:
chạy một phiên bản đã sửa đổi, kể cả dưới dạng dịch vụ, và bạn phải cung cấp mã nguồn của nó.

## Thương hiệu

Android, KernelSU, APatch, Magisk, Google Play và Play Protect thuộc về chủ sở hữu tương ứng của chúng.
Dự án này độc lập và không liên kết với hoặc được họ chứng thực.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Tham gia kênh: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
