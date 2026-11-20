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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · 한국어 · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# 기여하기

기여를 환영합니다 - 이슈, 풀 리퀘스트, 번역, 문서. 이 프로젝트는 기여하기 쉽고 참여를 환영하는 것을 목표로 합니다.

## AI 기여자 환영

AI 및 에이전트의 기여는 다른 모든 사람과 동일한 리뷰 기준으로 환영합니다. 엔진은 헤드리스 컨트랙트를 통해 JSON으로 통신합니다 (`scripts/helper.sh <verb> <base64(JSON)>`). [docs/AI-AGENTS.md](docs/AI-AGENTS.md)를 참고하세요. WebUI를 스크래핑하지 말고 컨트랙트를 구동하세요.

## 코드 규칙

- 모든 소스 파일 맨 위에 **파일별 완전한 배너** (SPDX + 연락처)를 둘 것. 축약된 것은 절대 안 됨.
- 코드, 식별자, 로그, 주석은 **영어**로. 주석은 무언가를 더할 때만.
- 기기용 셸은 **POSIX sh** (`sh -n`을 통과해야 함. `local`을 넘는 bashism 금지. 번들된 `jq`가 PATH에 올라오기 전에 실행되어야 하는 코드 경로에서는 `jq` 의존성 금지).
- WebUI는 프레임워크 없는 **바닐라 JS**. 모든 UI에서 라이트와 다크 지원.
- em 대시나 en 대시는 **절대** 쓰지 말고 항상 하이픈 `-`을 쓸 것.
- 빌드는 항상 **release**, 절대 debug 금지.
- 무언가를 통과시키려고 **실제 동작을 절대 약화시키지 말 것**, 그리고 콘텐츠를 절대 제거하지 말 것.

## 번역

WebUI 문자열은 `module/webroot/lang/<code>.json`에 있습니다 (플랫 키, 영어 베이스는 `lang/en.js`). README에는 언어별 `README.<code>.md`가 있습니다. 언어를 추가하거나 수정한 뒤 PR을 여세요.

## 라이선스

기여함으로써 귀하의 기여가 GNU AGPL-3.0-or-later로 라이선스되는 것에 동의합니다.

<!-- doc-footer -->

---

> _이 문서는 Claude (Anthropic)로 생성되었으며 VD171이 유지 관리합니다. 수정 및 개선을 환영합니다. [CONTRIBUTING.md](CONTRIBUTING.md)를 참조하세요._
