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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · Türkçe · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# Yapay zeka ajanları: başlıksız sözleşme

VDInstaller tek bir kabuk sözleşmesiyle yürütülür. Bir ajan (WebUI'nin yaptığı gibi root olarak
çalışan) şunu çağırır:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

ve stdout üzerinde tam olarak bir JSON nesnesi okur. Başarı `{"ok":true,...}`; başarısızlık
`{"ok":false,"code":"ERR_...","message":"..."}` şeklindedir. Uzun işlemler yokladığınız bir `opid`
döndürür. WebUI'yi kazımayın; bu sözleşmeyi kullanın.

## Fiiller

| Fiil | Argümanlar (JSON) | Döndürür |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | config nesnesi |
| `config-set` | birleştirilecek herhangi bir config anahtarı | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (ayrılmış) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (ayrılmış) |
| `progress` | opid dizesinin base64'ü (JSON değil) | canlı ilerleme nesnesi; bitince `done:true` |
| `cancel` | opid dizesinin base64'ü | `{cancelled}` |
| `verifier-status` | - | mevcut doğrulayıcı ayarları |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | eski günlükleri budar |

## Kurulum modları

| `mode` | alır | anlamı |
|---|---|---|
| `single` | `path` | bir `.apk` |
| `batch` | `dir` | bağımsız `.apk` dosyalarından oluşan bir klasör, her biri bir kurulum |
| `archive` | `path` | gruplanmış bir bölünmüş arşiv (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | tek bir uygulamanın dağınık bölünmüş `.apk` dosyalarını içeren bir klasör |

## Seçenekler (argümanlarda işlem başına veya `config-set` aracılığıyla kalıcı)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## İlerleme

`progress`'i `opid` ile yoklayın. Nesne `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), isteğe bağlı bir `item` ve
tamamlandığında bir `result` (single/split), bir `results[]` dizisi (batch) veya bir `error` ile
birlikte `done:true` taşır.

## Güvenlik korkulukları

- Doğrulayıcı anahtarı ve `packages.xml` düzenlemesi geri alınabilir ve denetlenir
  (`logs/audit.jsonl`).
- `install`/`uninstall` cihaz durumunu değiştirir; WebUI'nin yaptığı gibi, çağırmadan önce niyeti
  onaylayın.
- WebUI'nin kendisini asla kazımayın veya otomatikleştirmeyin; bu sözleşme, desteklenen yüzeydir.

<!-- doc-footer -->

---

> _Bu belgeler Claude (Anthropic) ile oluşturulmuş olup VD171 tarafından yürütülmektedir. Düzeltmeler ve iyileştirmeler memnuniyetle karşılanır; bkz. [CONTRIBUTING.md](CONTRIBUTING.md)._
