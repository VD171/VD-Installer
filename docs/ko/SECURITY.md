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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · [हिन्दी](../hi/SECURITY.md) · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · 한국어 · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# 보안 정책

## 한 줄로 보는 위협 모델

VDInstaller는 root로 실행되며 사용자가 명시적으로 선택한 APK를 설치합니다. 설치를 위해 Play Protect 베리파이어를 끄면 멀웨어 검사가 비활성화되므로, 이것은 "안전한 설치"가 아니라 "마찰 없는 설치"입니다 - 신뢰하는 APK만 설치하세요.

## 하는 일과 하지 않는 일

- 기본적으로 패키지 베리파이어를 정확히 이전 상태로 복원합니다 (원래 없던 자리에 `0`/`1`을 남기는 것 자체가 단서(tell)이므로 다시 삭제합니다).
- 당신의 HMA-OSS 설정에는 절대 손대지 않습니다. 앱을 숨기는 것은 당신이 직접 실행하는 권장 사항입니다.
- `packages.xml`의 설치 소스 편집은 ABX를 인식하며, 어떤 변경 전에도 라이브 파일을 바이트 단위로 정확히 백업하고, 라운드트립으로 검증하며, 실패 시 라이브 파일을 손대지 않은 채로 둡니다.
- 번들된 바이너리는 빌드 시 공식 업스트림에서 가져오며 `PROVENANCE.json`을 포함합니다.

## 취약점 신고

먼저 비공개로 신고해 주세요. 재현 단계, 영향받는 버전, 영향 범위를 포함하세요.

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

> _이 문서는 Claude (Anthropic)로 생성되었으며 VD171이 유지 관리합니다. 수정 및 개선을 환영합니다. [CONTRIBUTING.md](CONTRIBUTING.md)를 참조하세요._
