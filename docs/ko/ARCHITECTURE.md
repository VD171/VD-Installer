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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · 한국어 · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# 아키텍처

VDInstaller는 루트 셸 엔진 위에 얹힌 얇은 WebUI입니다. UI에는 아무런 권한도 없습니다. 모든 권한 동작은
하나의 JSON 객체를 반환하는 한 번의 셸 호출입니다.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - 바닐라 JS WebUI(프레임워크 없음), 라이트/다크, 22개 언어. KernelSU WebUI
  브리지(`ksu.exec`)를 통해 엔진을 호출하고 JSON 응답을 파싱합니다.
- **`scripts/common.sh`** - 두 스크립트가 모두 소스하는 공유 라이브러리: ABI/PATH 해석,
  `pm`/`dumpsys`/`fw` 래퍼(번들된 Termux 라이브러리가 ART의 것을 절대 가리지 않도록 깨끗한 환경에서),
  JSON 및 `jq` 헬퍼, 그리고 ABX 인식 `xml_edit`.
- **`scripts/helper.sh`** - WebUI 계약: 호출당 한 줄의 JSON. 짧은 verb(version, config, browse, scan)는
  인라인으로 실행되고, 긴 것(install, uninstall)은 워커를 분리하고 `opid` 를 반환합니다.
- **`scripts/worker.sh`** - 분리된 설치 엔진: 네 가지 설치 모드, verifier 토글, 설치 출처 스푸핑, 그리고
  패키지 관리자 세션 API. WebUI가 폴링하는 파일에 진행 상황을 기록하며, WebUI가 닫혀도 살아남습니다
  (`setsid`, 그리고 앱 프리저에서 벗어납니다).

## 핵심 포인트

- **이미 루트.** "su 허용" 프롬프트도, `sucompat` 토글링도 없습니다. 엔진은 모듈에서 루트로 실행되며 `pm`
  / `settings` 를 직접 호출합니다.
- **세션 설치.** 모든 모드가 `pm install-create` / `install-write` / `install-commit` 를 사용하므로 분할
  앱이 올바르게 설치되고, 설치 출처(`-i`)가 세션 시점에 설정됩니다.
- **ABX 인식.** `packages.xml` initiator 스푸핑은 `ABX\0` 바이너리 XML 매직을 확인하고, 디코드하고,
  편집하고, 재인코드하고, 라운드트립으로 검증하고, 바이트 단위로 정확히 백업하여 원자적으로 스왑합니다.
  모든 단계가 통과하지 않는 한 라이브 파일은 결코 건드리지 않습니다.
- **재부팅 불필요.** 마운트할 것이 없는 자체 완결형 WebUI 모듈: `customize.sh` 가 그것을 활성 모듈
  디렉터리로 복사하므로 플래시되는 순간 동작합니다.
- **플래시리스 업데이트.** 번들된 **VDLU** 엔진이 변경된, content-addressed, ed25519 서명 파일만
  다운로드하여 모듈을 업데이트합니다 - 전체 재플래시가 없습니다.
- **분리됨.** 긴 작업은 webview 밖에서 실행되며, WebUI를 닫아도 결코 중단되지 않습니다.

## 호환성 보장

- 기기의 POSIX `sh`(`sh -n` 통과. `local` 을 넘는 bashism 없음. `awk` 의존성 없음).
- `pm` / `dumpsys` / `settings` / `cmd` 가 사용되는 유일한 프레임워크 도구이며, 모두 `/system/bin` 을
  경유합니다.
- 번들 바이너리(`jq`, `abx2xml`/`xml2abx`)는 일반 경로에서는 선택 사항이며 출처를 지닙니다. ABX
  컨버터는 존재할 경우 기기 자체의 `/system/bin/abx2xml` 로 폴백합니다.

<!-- doc-footer -->

---

> _이 문서는 Claude (Anthropic)로 생성되었으며 VD171이 유지 관리합니다. 수정 및 개선을 환영합니다. [CONTRIBUTING.md](CONTRIBUTING.md)를 참조하세요._
