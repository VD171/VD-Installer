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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · 한국어 · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# VDInstaller 사용자 가이드

## 목차

1. [VDInstaller란](#1-vdinstaller란)
2. [요구 사항](#2-요구-사항)
3. [설치 및 첫 실행](#3-설치-및-첫-실행)
4. [WebUI 둘러보기](#4-webui-둘러보기)
5. [APK 설치](#5-apk-설치)
6. [옵션](#6-옵션)
7. [AI 어시스턴트에서 VDInstaller 구동하기](#7-ai-어시스턴트에서-vdinstaller-구동하기)
8. [문제 해결 및 FAQ](#8-문제-해결-및-faq)

## 1. VDInstaller란

VDInstaller는 사이드로드한 APK를 루트 권한으로 마찰 없이 설치하는 KernelSU / APatch / Magisk
**WebUI 모듈** 입니다. "su 허용" 프롬프트도, 터미널도 없으며, Play Protect verifier와 씨름할 필요도
없습니다. 단일 APK, 폴더 전체를 한 번에, 그리고 분할 앱(`.xapk` / `.apkm` / `.apks` / `.zip` 또는 낱개의
분할 파일)을 처리하며, 설치 출처를 Play Store로 표시하여 앱이 사이드로드된 것처럼 보이지 않게 할 수
있습니다.

## 2. 요구 사항

- Android 8.0 이상(API 26+).
- WebUI를 지원하는 루트 솔루션: **KernelSU**, **APatch** 또는 **Magisk**.

## 3. 설치 및 첫 실행

1. [Releases](https://github.com/VD171/VD-Installer/releases) 페이지에서 최신
   `VD-Installer-vX.XX-universal.zip` 를 다운로드합니다.
2. 루트 관리자에서 모듈로 플래시합니다(*Modules -> Install from storage*).
3. VDInstaller는 **재부팅 없이** 활성화됩니다 - 자체 완결형(WebUI + 번들 바이너리)이므로 마운트할 것이
   없습니다.
4. 루트 관리자의 모듈 목록에서 **VDInstaller** WebUI를 엽니다.

플래시 시 설치 프로그램은 기기의 ABI만 남기고, 필수 `.sha256` 무결성 게이트를 실행합니다. 이 게이트는
zip이 손상되었거나 잘렸으면 **중단** 합니다. 설정은 `/data/adb/vdinstaller` 에 저장되며 업데이트 후에도
유지됩니다.

## 4. WebUI 둘러보기

세 개의 탭:

- **Install** - 모드를 고르고, APK나 폴더를 선택하고, 설치하고, 실시간 진행 상황을 봅니다.
- **Options** - 설치 출처, Play Protect verifier 토글, 설치 플래그. 모든 것이 자동으로 저장됩니다.
- **About** - 버전, 기능, 요구 사항, 링크, 라이선스.

## 5. APK 설치

모드는 **Install** 탭에서 고릅니다. VDInstaller는 결코 추측하지 않습니다.

| 모드 | 제공하는 것 | 일어나는 일 |
|---|---|---|
| **Single APK** | 하나의 `.apk` 파일 | 한 번의 설치 세션, 하나의 앱. |
| **Folder of APKs**(배치) | 독립된 `.apk` 파일의 폴더 | 각 APK가 개별로, 하나씩 차례로 설치됩니다. 부분적인 배치는 무엇이 왜 실패했는지 보고합니다. |
| **Split archive** | `.xapk` / `.apkm` / `.apks` / `.zip` | 추출된 뒤, `base.apk` + 분할이 하나의 앱으로 한 세션에 설치됩니다(XAPK OBB가 있으면 함께 배치됩니다). |
| **Split folder** | 한 앱의 낱개 분할 `.apk` 파일이 든 폴더 | 분할이 하나의 앱으로 한 세션에 설치됩니다. |

"분할(split)" 앱은 하나의 APK가 베이스와 밀도별 / ABI별 / 언어별 구성 APK로 나뉜 것입니다. 이들은 한
세션에서 **함께** 설치해야 하며, Split 모드가 그 일을 대신 해 줍니다.

### 5.1 Browse 대화상자

**Browse** 는 어떤 경로의 폴더와 설치 가능한 파일을 나열하는 파일 선택기를 엽니다:

- **폴더** 를 탭하여 안으로 들어갑니다. **Up** 으로 상위로 돌아갑니다.
- 파일 모드(Single APK / Split archive)에서는 **파일** 을 탭하여 선택합니다.
- 폴더 모드(Folder of APKs / Split folder)에서는 폴더 안으로 이동한 뒤 **Use this folder** 를 탭합니다.

경로를 직접 입력하거나 붙여 넣을 수도 있습니다(예: `/sdcard/Download/app.apk`).

### 5.2 진행 상황, 취소, 재개

설치는 **분리된 루트 프로세스** 로 실행됩니다. 진행 상황 카드가 단계를 보여줍니다. **Cancel** 로
멈춥니다. 설치 도중에 WebUI를 닫아도 설치는 계속 진행되며, 다시 열면 UI가 작업 ID로 재연결됩니다.

## 6. 옵션

여기의 모든 것은 자동으로 저장되며 다음 설치에 적용됩니다.

### 6.1 설치 출처

막 사이드로드한 앱은 그것을 읽는 모든 앱(그리고 증명)에게 사이드로드되었음을 알립니다. VDInstaller는
대신 출처를 Play Store로 표시할 수 있습니다.

- **Play Store를 설치 프로그램으로 표시**(기본값 켜짐) - `pm install-create -i com.android.vending` 를
  통해 `installerPackageName` 을 설정합니다. 즉시 적용됩니다.
- **initiator도 스푸핑**(기본값 켜짐) - `/data/system/packages.xml` 을 편집하여 `installInitiator` 와
  `packageSource` 를 설정합니다. 이는 **ABX 인식** 방식입니다(디코드 -> 편집 -> 재인코드, 바이트 단위로
  정확한 백업과 원자적 스왑 포함). 패키지 관리자가 `packages.xml` 을 캐시하므로 **다음 재부팅 후** 에
  적용됩니다.

### 6.2 Play Protect 패키지 verifier

사이드로드 설치는 Play Protect의 패키지 verifier에 의해 `INSTALL_FAILED_VERIFICATION_FAILURE` 로
거부될 수 있습니다. 3단계 토글:

- **원래대로 유지**(기본값) - 설치 동안만 끄고, 그 뒤 이전 상태로 **정확히** 복원합니다(명시적 값이
  없었다면 다시 삭제합니다. 왜냐하면 아무것도 없던 자리의 `0`/`1` 자체가 스텔스 기기에서 하나의
  단서이기 때문입니다).
- **항상 켜짐** - 강제로 켜고 유지합니다.
- **항상 꺼짐** - 강제로 끄고 유지합니다. WebUI가 경고합니다: 꺼둔 채로 두는 것은 스텔스 단서이며, 모든
  설치에서 멀웨어 검사를 비활성화합니다.

### 6.3 Developer Verification

Android의 2026년 Developer Verification은 인증된 기기에서 등록되지 않은 개발자의 앱 설치를 차단하지만,
이는 Play Protect가 아니라 **별도의 서비스** 가 강제하며, **루트 설치는 이미 면제** 되어 있습니다(ADB
설치가 받는 것과 동일한 면제). VDInstaller는 어쨌든 여러분의 APK를 설치하므로, 이 토글은 **최선의 노력,
그리고 정직** 합니다: 실제 노브가 존재할 때만 그것을 적용하며, 아무 일도 하지 않는 스위치를 켠 척하지
않습니다.

### 6.4 설치 플래그

| 플래그 | 효과 |
|---|---|
| **모든 런타임 권한 부여** | 설치 시 모든 런타임 권한을 부여합니다(`-g`). |
| **테스트 패키지 허용** | test-only로 표시된 패키지를 설치합니다(`-t`). |
| **낮은 타깃 SDK 차단 우회** | 매우 오래된 `targetSdk` 의 앱을 설치합니다. |
| **대상 사용자** | 설치 대상 Android 사용자 ID(기본값 `0`). |

### 6.5 숨은 채로 유지하기

스텔스를 위해, 루트 관리자와 민감한 앱을 HMA-OSS로 숨기는 것을 고려하세요. VDInstaller는 **여러분의
HMA-OSS 설정을 결코 건드리지 않습니다** - 이 힌트는 단지 알림일 뿐이며, 변경은 여러분이 직접 HMA-OSS에서
합니다.

## 7. AI 어시스턴트에서 VDInstaller 구동하기

엔진은 `scripts/helper.sh` 를 통해 작은 JSON 계약을 말하므로, 에이전트가 WebUI가 할 수 있는 모든 동작을
구동할 수 있습니다. [AI-AGENTS](AI-AGENTS) 를 참조하세요. WebUI를 스크레이핑하지 말고 계약을
구동하세요.

## 8. 문제 해결 및 FAQ

**`INSTALL_FAILED_VERIFICATION_FAILURE` 가 나옵니다.** 그것은 Play Protect의 패키지 verifier입니다.
verifier 토글을 **원래대로 유지**(기본값)로 두면, VDInstaller가 설치 동안 그것을 끄고 복원하므로 이
일은 일어나지 않습니다.

**Play Store 출처를 켰는데도 앱이 여전히 사이드로드된 것처럼 보입니다.** 설치 프로그램 부분은 즉시
적용됩니다. initiator 부분(`packages.xml`)은 **다음 재부팅 후** 에 적용됩니다.

**Google의 Developer Verification을 우회합니까?** 그럴 필요가 없습니다 - 루트 설치는 면제되어
있습니다(6.3 참조). 그것을 위한 가짜 스위치는 없습니다.

**재부팅이 필요합니까?** 아니요, 선택적인 initiator 스푸핑을 제외하면 필요 없습니다.

**VDInstaller를 제거하면 설치한 앱도 삭제됩니까?** 아니요 - 그것들은 시스템이 소유한 실제 설치입니다.
모듈을 제거해도 VDInstaller 자신의 상태만 정리됩니다.

**안전합니까?** 여러분이 고른 APK를 설치하며, verifier를 끄면 멀웨어 검사를 건너뜁니다 - 신뢰하는 APK만
설치하세요. 무언가를 조용히 약화시키는 일은 결코 없습니다.

<!-- doc-footer -->

---

> _이 문서는 Claude (Anthropic)로 생성되었으며 VD171이 유지 관리합니다. 수정 및 개선을 환영합니다. [CONTRIBUTING.md](CONTRIBUTING.md)를 참조하세요._
