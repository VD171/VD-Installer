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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · Tiếng Việt · [中文](../zh/USER-GUIDE.md)

---

# Hướng dẫn sử dụng VDInstaller

## Mục lục

1. [VDInstaller là gì](#1-vdinstaller-là-gì)
2. [Yêu cầu](#2-yêu-cầu)
3. [Cài đặt và chạy lần đầu](#3-cài-đặt-và-chạy-lần-đầu)
4. [Tham quan WebUI](#4-tham-quan-webui)
5. [Cài đặt APK](#5-cài-đặt-apk)
6. [Tùy chọn](#6-tùy-chọn)
7. [Điều khiển VDInstaller từ trợ lý AI](#7-điều-khiển-vdinstaller-từ-trợ-lý-ai)
8. [Khắc phục sự cố và câu hỏi thường gặp](#8-khắc-phục-sự-cố-và-câu-hỏi-thường-gặp)

## 1. VDInstaller là gì

VDInstaller là một **mô-đun WebUI** cho KernelSU / APatch / Magisk, cài đặt các APK sideload với quyền
root mà không gặp trở ngại: không có lời nhắc "cấp su", không cần terminal, và không phải vật lộn với
trình xác minh của Play Protect. Nó xử lý APK đơn lẻ, cả một thư mục cùng lúc, và các ứng dụng chia
tách (`.xapk` / `.apkm` / `.apks` / `.zip` hoặc các tập tin split rời rạc), đồng thời có thể trình bày
nguồn cài đặt là Play Store để một ứng dụng không trông giống như được sideload.

## 2. Yêu cầu

- Android 8.0 trở lên (API 26+).
- Một giải pháp root có hỗ trợ WebUI: **KernelSU**, **APatch** hoặc **Magisk**.

## 3. Cài đặt và chạy lần đầu

1. Tải xuống bản `VD-Installer-vX.XX-universal.zip` mới nhất từ trang
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Flash nó như một mô-đun trong trình quản lý root của bạn (*Modules -> Install from storage*).
3. VDInstaller kích hoạt **mà không cần khởi động lại** - nó khép kín (WebUI + các tệp nhị phân đi kèm),
   nên không có gì để mount.
4. Mở WebUI **VDInstaller** từ danh sách mô-đun trong trình quản lý root của bạn.

Khi flash, trình cài đặt chỉ giữ lại ABI của thiết bị bạn và chạy một cổng kiểm tra tính toàn vẹn
`.sha256` bắt buộc, cổng này sẽ **hủy bỏ** nếu tập tin zip bị hỏng hoặc bị cắt cụt. Cài đặt nằm trong
`/data/adb/vdinstaller` và tồn tại qua các lần cập nhật.

## 4. Tham quan WebUI

Ba thẻ:

- **Install** - chọn một chế độ, chọn APK hoặc thư mục, cài đặt, theo dõi tiến trình trực tiếp.
- **Options** - nguồn cài đặt, công tắc trình xác minh của Play Protect, và các cờ cài đặt. Mọi thứ
  được lưu tự động.
- **About** - phiên bản, nó làm gì, yêu cầu, liên kết và giấy phép.

## 5. Cài đặt APK

Bạn chọn chế độ trên thẻ **Install**, VDInstaller không bao giờ đoán.

| Chế độ | Bạn cung cấp | Điều gì xảy ra |
|---|---|---|
| **Single APK** | một tập tin `.apk` | một phiên cài đặt, một ứng dụng. |
| **Folder of APKs** (hàng loạt) | một thư mục chứa các tập tin `.apk` độc lập | mỗi APK được cài đặt riêng, lần lượt từng cái; một lô cài đặt một phần sẽ báo cáo cái nào thất bại và vì sao. |
| **Split archive** | một `.xapk` / `.apkm` / `.apks` / `.zip` | được giải nén, sau đó `base.apk` + các split được cài làm một ứng dụng trong một phiên duy nhất (OBB của XAPK cũng được đặt vào, khi có). |
| **Split folder** | một thư mục chứa các tập tin split `.apk` rời rạc của một ứng dụng | các split được cài làm một ứng dụng trong một phiên duy nhất. |

Một ứng dụng "split" là một APK được chia thành một bản base cộng với các APK cấu hình theo từng mật độ
/ từng ABI / từng ngôn ngữ, chúng phải được cài đặt **cùng nhau** trong một phiên, điều mà các chế độ
Split làm thay cho bạn.

### 5.1 Hộp thoại Browse

**Browse** mở trình chọn tập tin, liệt kê các thư mục và các tập tin có thể cài đặt tại một đường dẫn:

- Chạm vào một **thư mục** để đi vào trong đó, **Up** quay về thư mục cha.
- Trong chế độ tập tin (Single APK / Split archive), chạm vào một **tập tin** để chọn nó.
- Trong chế độ thư mục (Folder of APKs / Split folder), điều hướng vào thư mục rồi chạm
  **Use this folder**.

Bạn cũng có thể gõ hoặc dán một đường dẫn trực tiếp (ví dụ `/sdcard/Download/app.apk`).

### 5.2 Tiến trình, hủy, tiếp tục

Các lần cài đặt chạy như một **tiến trình root tách rời**. Một thẻ tiến trình hiển thị pha hiện tại;
**Cancel** dừng nó lại. Nếu bạn đóng WebUI giữa chừng cài đặt, việc cài đặt vẫn tiếp tục và giao diện
gắn lại theo id thao tác khi bạn mở lại.

## 6. Tùy chọn

Mọi thứ ở đây được lưu tự động và áp dụng cho lần cài đặt tiếp theo.

### 6.1 Nguồn cài đặt

Một ứng dụng vừa được sideload sẽ thông báo cho mọi ứng dụng đọc nó (và cho chứng thực) rằng nó đã được
sideload. VDInstaller có thể trình bày nguồn là Play Store thay vào đó.

- **Show the Play Store as installer** (mặc định bật) - đặt `installerPackageName` qua
  `pm install-create -i com.android.vending`. Áp dụng ngay lập tức.
- **Also spoof the initiator** (mặc định bật) - đặt `installInitiator` và `packageSource` bằng cách
  chỉnh sửa `/data/system/packages.xml`. Việc này **nhận biết ABX** (giải mã -> chỉnh sửa -> mã hóa
  lại, với một bản sao lưu chính xác từng byte và một lần hoán đổi nguyên tử) và áp dụng **sau lần khởi
  động lại kế tiếp**, vì trình quản lý gói lưu cache `packages.xml`.

### 6.2 Trình xác minh gói của Play Protect

Một lần cài đặt sideload có thể bị từ chối với `INSTALL_FAILED_VERIFICATION_FAILURE` bởi trình xác minh
gói của Play Protect. Một công tắc 3 trạng thái:

- **Keep as it was** (mặc định) - chỉ tắt cho lần cài đặt, sau đó khôi phục về trạng thái trước đó
  **chính xác** (lại bị xóa nếu trước đó không có giá trị rõ ràng, vì một `0`/`1` ở nơi vốn không có gì
  chính nó đã là một dấu hiệu lộ trên thiết bị ẩn danh).
- **Always on** - buộc bật và giữ nguyên.
- **Always off** - buộc tắt và giữ nguyên. WebUI cảnh báo: để nó tắt là một dấu hiệu lộ ẩn danh và vô
  hiệu hóa việc quét phần mềm độc hại cho mọi lần cài đặt.

### 6.3 Developer Verification

Developer Verification năm 2026 của Android chặn việc cài đặt ứng dụng từ các nhà phát triển chưa đăng
ký trên các thiết bị được chứng nhận, nhưng nó được thực thi bởi một **dịch vụ riêng**, không phải Play
Protect, và một lần cài đặt bằng root **đã được miễn** khỏi nó (cùng sự miễn trừ mà các lần cài đặt ADB
nhận được). VDInstaller cài các APK của bạn bất kể thế nào, nên công tắc này mang tính **cố gắng tối đa
và trung thực**: nó chỉ áp dụng một nút điều khiển thật sự nếu nút đó tồn tại và không bao giờ giả vờ
bật một công tắc chẳng làm gì.

### 6.4 Cờ cài đặt

| Cờ | Tác dụng |
|---|---|
| **Grant all runtime permissions** | cấp mọi quyền thời gian chạy khi cài đặt (`-g`). |
| **Allow test packages** | cài các gói được đánh dấu chỉ dành cho thử nghiệm (`-t`). |
| **Bypass low target SDK block** | cài các ứng dụng có `targetSdk` rất cũ. |
| **Target user** | id người dùng Android để cài đặt cho (mặc định `0`). |

### 6.5 Giữ ẩn

Để ẩn danh, hãy cân nhắc ẩn trình quản lý root và các ứng dụng nhạy cảm của bạn bằng HMA-OSS.
VDInstaller **không bao giờ đụng đến thiết lập HMA-OSS của bạn** - gợi ý chỉ là một lời nhắc, bạn tự
thực hiện thay đổi đó trong HMA-OSS.

## 7. Điều khiển VDInstaller từ trợ lý AI

Engine giao tiếp bằng một hợp đồng JSON nhỏ qua `scripts/helper.sh`, nên một tác nhân có thể điều khiển
mọi hành động mà WebUI có thể làm. Xem [AI-AGENTS](AI-AGENTS). Hãy điều khiển hợp đồng, đừng cào WebUI.

## 8. Khắc phục sự cố và câu hỏi thường gặp

**Tôi gặp `INSTALL_FAILED_VERIFICATION_FAILURE`.** Đó là trình xác minh gói của Play Protect. Với công
tắc trình xác minh để ở **Keep as it was** (mặc định), VDInstaller tắt nó cho lần cài đặt rồi khôi
phục, nên điều đó không xảy ra.

**Tôi đã bật nguồn Play Store nhưng ứng dụng vẫn trông giống được sideload.** Phần trình cài đặt áp dụng
ngay lập tức, phần trình khởi tạo (`packages.xml`) áp dụng **sau lần khởi động lại kế tiếp**.

**Nó có vượt qua Developer Verification của Google không?** Nó không cần - một lần cài đặt bằng root
được miễn (xem 6.3). Không có công tắc giả nào cho nó.

**Nó có cần khởi động lại không?** Không, trừ việc giả mạo trình khởi tạo tùy chọn.

**Gỡ cài đặt VDInstaller có xóa các ứng dụng tôi đã cài không?** Không - đó là những lần cài đặt thật sự
do hệ thống sở hữu, gỡ mô-đun chỉ dọn dẹp trạng thái riêng của VDInstaller.

**Nó có an toàn không?** Nó cài các APK mà bạn chọn và, khi tắt trình xác minh, bỏ qua một lần quét phần
mềm độc hại - chỉ cài những APK mà bạn tin tưởng. Nó không bao giờ âm thầm làm yếu bất cứ thứ gì.

<!-- doc-footer -->

---

> _Tài liệu này được tạo bằng Claude (Anthropic) và được duy trì bởi VD171. Chúng tôi hoan nghênh các chỉnh sửa và cải tiến, xem [CONTRIBUTING.md](CONTRIBUTING.md)._
