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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · 한국어 · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# AI 에이전트: 헤드리스 계약

VDInstaller는 하나의 셸 계약으로 구동됩니다. 에이전트(WebUI처럼 루트로 실행)는 다음을 호출합니다:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

그리고 표준 출력에서 정확히 하나의 JSON 객체를 읽습니다. 성공은 `{"ok":true,...}`, 실패는
`{"ok":false,"code":"ERR_...","message":"..."}` 입니다. 긴 작업은 폴링할 `opid` 를 반환합니다. WebUI를
스크레이핑하지 말고 이 계약을 사용하세요.

## Verb

| Verb | 인자 (JSON) | 반환 |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | 설정 객체 |
| `config-set` | 병합할 임의의 설정 키 | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (분리됨) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (분리됨) |
| `progress` | opid 문자열의 base64(JSON 아님) | 라이브 진행 상황 객체. 완료 시 `done:true` |
| `cancel` | opid 문자열의 base64 | `{cancelled}` |
| `verifier-status` | - | 현재 verifier 설정 |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | 오래된 로그를 정리합니다 |

## 설치 모드

| `mode` | 받는 것 | 의미 |
|---|---|---|
| `single` | `path` | 하나의 `.apk` |
| `batch` | `dir` | 독립된 `.apk` 파일의 폴더, 각각 하나씩 설치 |
| `archive` | `path` | 묶인 분할 아카이브(`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | 한 앱의 낱개 분할 `.apk` 파일이 든 폴더 |

## 옵션(인자 내 작업별, 또는 `config-set` 로 영속화)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## 진행 상황

`opid` 로 `progress` 를 폴링합니다. 객체는 `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), 선택적 `item`, 그리고 완료 시
`result`(single/split), `results[]` 배열(batch), 또는 `error` 를 동반한 `done:true` 를 지닙니다.

## 안전 가드레일

- verifier 토글과 `packages.xml` 편집은 가역적이며 감사됩니다(`logs/audit.jsonl`).
- `install`/`uninstall` 는 기기 상태를 변경합니다. WebUI가 그렇게 하듯, 호출하기 전에 의도를 확인하세요.
- WebUI 자체를 결코 스크레이핑하거나 자동화하지 마세요. 이 계약이 지원되는 표면입니다.

<!-- doc-footer -->

---

> _이 문서는 Claude (Anthropic)로 생성되었으며 VD171이 유지 관리합니다. 수정 및 개선을 환영합니다. [CONTRIBUTING.md](CONTRIBUTING.md)를 참조하세요._
