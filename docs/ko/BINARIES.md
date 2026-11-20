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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · 한국어 · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# 번들 바이너리: 출처와 감사

## 원칙

- 불투명한 것은 아무것도 포함하지 않습니다. 모든 번들 바이너리는 **빌드 시점에 공식 업스트림에서** 가져오며,
  기기에서 뽑아내는 일은 결코 없습니다. 그리고 모든 파일은 sha256을 지니므로 페이로드를 재현할 수
  있습니다.
- 바이너리는 **네 가지 ABI 전부**(`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`)에 대해 번들됩니다. 플래시
  설치 프로그램이 기기의 하나로 추려냅니다.
- 이들은 독립 실행됩니다: 각 바이너리의 공유 라이브러리 클로저가 함께 제공되고, 엔진이 `LD_LIBRARY_PATH`
  를 번들된 `lib/` 로 설정하므로 Termux 설치에 의존하지 않습니다.

## 무엇이 포함되며, 어디서 오는가

| 바이너리 | 출처 | 이유 |
|---|---|---|
| `jq` (+ `lib/`) | Termux 패키지 저장소(`packages.termux.dev/apt`), 공식 `.deb` | 엔진은 JSON을 말합니다. `jq` 가 인자를 파싱하고 응답을 구성합니다. |
| `abx2xml` / `xml2abx` | [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) 릴리스 | `packages.xml` 설치 출처 스푸핑을 위해 Android 바이너리 XML(ABX)을 디코드/인코드합니다. 기기에 `/system/bin/abx2xml`(A12 이전)이 없는 경우에 사용합니다. 존재할 경우 기기 자체의 컨버터가 우선됩니다. |
| `vdlu/verify/<abi>/ed25519-mini` | 정본 [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) 엔진 | OpenSSL 없이 플래시리스(VDLU) 업데이트의 ed25519 서명을 검증합니다. |

빌드 단계는 `.github/scripts/build_bin.sh` 입니다: Termux 패키지와 그 전이 의존성을 해석하고, `.deb` 를
추출하고, 원하는 바이너리와 각각이 필요로 하는 공유 라이브러리 클로저(`readelf` 로 해석)를 복사한 뒤,
독립 실행 ABX 컨버터를 가져옵니다.

## 기기 내 매니페스트: `PROVENANCE.json`

각 `bin/<abi>/` 는 제공된 모든 파일(경로, 크기, sha256)과 각각의 업스트림 출처(패키지, 버전, URL,
아카이브 sha256)를 나열하는 `PROVENANCE.json` 을 지닙니다. 이는 기기 내 ABI 추려내기를 견디므로, 감사
추적이 모듈 자체와 함께 제공됩니다.

## 검증 방법

1. 기기 또는 플래시 가능한 zip 안의 `bin/<abi>/PROVENANCE.json` 을 엽니다.
2. 기록된 URL에서 고정된 각 출처를 다시 가져옵니다.
3. 추출하여 각 파일의 sha256을 매니페스트와 비교합니다.

플래시 가능한 zip은 제공된 각 파일 옆에 `.sha256` 동반 파일을 추가로 지닙니다. `customize.sh` 가 플래시
시점에 그것들을 검증하고, 어떤 불일치(손상되었거나 잘린 zip)에서도 **중단** 합니다.

## 신고

불일치나 출처에 관한 우려를 발견하셨나요? 비공개로 신고해 주세요 - [SECURITY.md](../SECURITY.md) 를
참조하세요.

<!-- doc-footer -->

---

> _이 문서는 Claude (Anthropic)로 생성되었으며 VD171이 유지 관리합니다. 수정 및 개선을 환영합니다. [CONTRIBUTING.md](CONTRIBUTING.md)를 참조하세요._
