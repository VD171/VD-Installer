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

> Trinh cai sideload qua root khong rao can - KernelSU / APatch / Magisk WebUI.

## Tai sao

Cai mot APK sideload tren dien thoai da root on ao hon muc can thiet: trinh xac minh goi cua Play Protect
co the nem ra `INSTALL_FAILED_VERIFICATION_FAILURE`, cac app chia nho (`.xapk` / `.apkm` / `.apks`)
can dung session API bang tay, va mot app vua cai se tu khai la "sideloaded" voi moi app doc nguon cai
dat cua no. VDInstaller lam tat ca nhung viec do thay ban, da san o che do root, khong co loi nhac
"grant su" va khong can terminal.

## Tinh nang

- **Moi hinh thuc APK** - mot `.apk` don le, ca mot thu muc cac APK doc lap (batch), mot archive chia
  nho theo nhom (`.xapk` / `.apkm` / `.apks` / `.zip`), hoac mot thu muc chua cac split APK roi roi.
- **Khong con buc tuong xac minh** - mot cong tac 3 trang thai cho trinh xac minh goi cua Play Protect:
  giu nguyen nhu cu (chi tat trong luc cai, roi khoi phuc chinh xac), luon bat, hoac luon tat.
- **Trung thuc ve Developer Verification** - mot ban cai qua root von da duoc mien tru khoi Developer
  Verification 2026 cua Android; cong tac nay la no-luc-toi-da va noi ro dieu do, khong bao gio la mot
  nut gia.
- **Khong phai "sideloaded"** - tuy chon trinh bay nguon cai dat la Play Store, ca phan trinh cai (luc
  cai) lan phan khoi tao (qua mot chinh sua `packages.xml` co nhan biet ABX).
- **Tach roi va co the tiep tuc** - cac ban cai chay nhu mot tien trinh root tach roi; dong WebUI khong
  bao gio lam gian doan chung, va giao dien gan ket lai theo operation id.
- **Ban quyet dinh** - ha cap, goi test, cap moi quyen runtime, nguoi dung dich, bo qua chan target
  SDK thap: tat ca deu tuy chon.
- **Offline, tu chua du, khong can khoi dong lai** - mot module WebUI voi cac binary dong kem; dung duoc
  ngay khi vua flash.

## Tac nhan AI

Du an nay chao don nhung nguoi dong gop la AI va tac nhan. Engine noi JSON qua mot hop dong headless nho
(`scripts/helper.sh <verb> <base64(JSON)>`), duoc mo ta trong
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), nen mot tac nhan co the dieu khien moi hanh dong ma WebUI lam
duoc - dung scrape WebUI. Cac ban va tu AI duoc danh gia theo cung tieu chuan review nhu bat ky dong gop
nao khac.

## Cai dat

Flash tep zip trong KernelSU, APatch hoac Magisk va mo WebUI cua VDInstaller tu trinh quan ly root cua
ban. Trinh cai chi giu lai ABI cua thiet bi ban va chay cong kiem tra toan ven `.sha256` bat buoc
(huy khi zip bi hong hoac bi cat cut). Android 8.0 (API 26) tro len.

## Bao mat

VDInstaller chay o che do root va cai nhung APK ban chon; tat trinh xac minh goi cho mot ban cai se vo
hieu hoa mot lan quet ma doc, nen chi cai nhung APK ban tin tuong. No khong bao gio am tham lam yeu di
bao mat thiet bi: theo mac dinh trinh xac minh duoc khoi phuc ve dung trang thai truoc do, va no khong
bao gio dong vao thiet lap HMA-OSS cua ban. Bao loi theo [SECURITY.md](SECURITY.md).

## Build

Luon release, khong bao gio debug. `.github/scripts/build_bin.sh` lay `jq` tu kho apt Termux (cung
voi be mat thu vien chia se cua no) va cac trinh chuyen doi `abx2xml` / `xml2abx` doc lap, cho ca bon
ABI, moi cai kem mot `PROVENANCE.json`. Workflow release lap rap cac zip flash duoc, ghi cac ban dong
hanh `.sha256`, dien `update.json` va phat hanh duoi danh nghia `github-actions[bot]`.

## Tai lieu

Cac huong dan nam trong [docs/](docs/) va duoc mirror sang GitHub wiki. Xem
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) de biet hop dong headless.

## Xem them

- [VDBackup](https://github.com/VD171/VD-Backup) - sao luu & khoi phuc toan bo app va du lieu, qua root.
- [VDInfos](https://github.com/VD171/VD-Infos) - doc moi thong tin thiet bi bang moi phuong phap, roi so sanh.
- [VDGoogle](https://github.com/VD171/VDGoogle) - doc RCS, Wallet va cac attestation qua root.
- [COPG-VD](https://github.com/VD171/COPG-VD) - module fingerprint va props Pixel.

## Lien he

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

## Giay phep

VDInstaller duoc cap phep theo GNU AGPL-3.0-or-later. Xem [LICENSE](LICENSE). NETWORK COPYLEFT:
chay mot phien ban da sua doi, ke ca duoi dang dich vu, va ban phai cung cap ma nguon cua no.

## Thuong hieu

Android, KernelSU, APatch, Magisk, Google Play va Play Protect thuoc ve chu so huu tuong ung cua chung.
Du an nay doc lap va khong lien ket voi hoac duoc ho chung thuc.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Tham gia kenh: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
