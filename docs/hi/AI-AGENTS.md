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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · हिन्दी · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · [Português](../pt/AI-AGENTS.md) · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# AI एजेंट: हेडलेस अनुबंध

VDInstaller को एक ही शेल अनुबंध द्वारा चलाया जाता है। एक एजेंट (root के रूप में चल रहा, जैसे WebUI चलता है)
कॉल करता है:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

और stdout पर ठीक एक JSON ऑब्जेक्ट पढ़ता है। सफलता `{"ok":true,...}` है, विफलता
`{"ok":false,"code":"ERR_...","message":"..."}` है। लंबे ऑपरेशन एक `opid` लौटाते हैं जिसे आप पोल करते हैं।
WebUI को स्क्रैप न करें, इस अनुबंध का उपयोग करें।

## Verb

| Verb | आर्ग्युमेंट (JSON) | लौटाता है |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | config ऑब्जेक्ट |
| `config-set` | मर्ज करने के लिए कोई भी config कुंजियाँ | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (अलग किया गया) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (अलग किया गया) |
| `progress` | opid स्ट्रिंग का base64 (JSON नहीं) | लाइव प्रगति ऑब्जेक्ट; समाप्त होने पर `done:true` |
| `cancel` | opid स्ट्रिंग का base64 | `{cancelled}` |
| `verifier-status` | - | वर्तमान वेरिफ़ायर सेटिंग्स |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | पुराने लॉग छाँटता है |

## इंस्टॉल मोड

| `mode` | लेता है | अर्थ |
|---|---|---|
| `single` | `path` | एक `.apk` |
| `batch` | `dir` | स्वतंत्र `.apk` फ़ाइलों का एक फ़ोल्डर, प्रत्येक के लिए एक इंस्टॉल |
| `archive` | `path` | एक समूहीकृत स्प्लिट आर्काइव (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | एक ऐप की अलग-अलग स्प्लिट `.apk` फ़ाइलों वाला एक फ़ोल्डर |

## विकल्प (आर्ग्युमेंट में प्रति-ऑपरेशन, या `config-set` के ज़रिए स्थायी)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int)।

## प्रगति

`opid` के साथ `progress` को पोल करें। ऑब्जेक्ट `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), एक वैकल्पिक `item`, और पूरा होने पर
एक `result` (single/split), एक `results[]` array (batch), या एक `error` के साथ `done:true` ले जाता है।

## सुरक्षा रेल

- वेरिफ़ायर टॉगल और `packages.xml` संपादन उलटे किए जा सकते हैं और ऑडिट किए जाते हैं
  (`logs/audit.jsonl`)।
- `install`/`uninstall` डिवाइस स्थिति बदलते हैं, कॉल करने से पहले मंशा की पुष्टि करें, जैसा WebUI करता है।
- WebUI को स्वयं कभी स्क्रैप या स्वचालित न करें, यह अनुबंध ही समर्थित सतह है।

<!-- doc-footer -->

---

> _यह दस्तावेज़ Claude (Anthropic) से तैयार किया गया है और इसे VD171 द्वारा अनुरक्षित किया जाता है। सुधार और संशोधन का स्वागत है, देखें [CONTRIBUTING.md](CONTRIBUTING.md)।_
