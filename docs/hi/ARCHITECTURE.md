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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · हिन्दी · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# आर्किटेक्चर

VDInstaller एक root शेल इंजन के ऊपर एक पतला WebUI है। UI में किसी भी चीज़ के पास विशेषाधिकार नहीं है, हर
विशेषाधिकार वाली क्रिया एक शेल कॉल है जो एक JSON ऑब्जेक्ट लौटाती है।

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - वनीला JS WebUI (कोई फ़्रेमवर्क नहीं), हल्का/गहरा, 22 भाषाएँ। यह इंजन को KernelSU WebUI
  ब्रिज (`ksu.exec`) के ज़रिए कॉल करता है और JSON उत्तर को पार्स करता है।
- **`scripts/common.sh`** - दोनों स्क्रिप्ट द्वारा सोर्स की गई साझा लाइब्रेरी: ABI/PATH समाधान,
  `pm`/`dumpsys`/`fw` रैपर (साफ़ environment ताकि बंडल की गई Termux लाइब्रेरी कभी ART की लाइब्रेरी को न
  ढकें), JSON और `jq` हेल्पर, और ABX-aware `xml_edit`।
- **`scripts/helper.sh`** - WebUI अनुबंध: प्रति कॉल एक JSON पंक्ति। छोटे verb (version, config, browse,
  scan) इनलाइन चलते हैं, लंबे वाले (install, uninstall) एक worker को अलग कर देते हैं और एक `opid` लौटाते
  हैं।
- **`scripts/worker.sh`** - अलग किया गया इंस्टॉल इंजन: चार इंस्टॉल मोड, वेरिफ़ायर टॉगल, इंस्टॉल-स्रोत स्पूफ़,
  और पैकेज-मैनेजर सत्र API। यह प्रगति को एक फ़ाइल में लिखता है जिसे WebUI पोल करता है, और WebUI के बंद होने के
  बावजूद चलता रहता है (`setsid`, और यह ऐप फ़्रीज़र से बच निकलता है)।

## मुख्य बिंदु

- **पहले से root।** न कोई "grant su" संकेत और न `sucompat` को टॉगल करना, इंजन मॉड्यूल से root के रूप में
  चलता है और सीधे `pm` / `settings` को कॉल करता है।
- **सत्र इंस्टॉल।** सभी मोड `pm install-create` / `install-write` / `install-commit` का उपयोग करते हैं,
  इसलिए स्प्लिट ऐप सही ढंग से इंस्टॉल होते हैं और इंस्टॉल स्रोत (`-i`) सत्र के समय सेट होता है।
- **ABX-aware।** `packages.xml` आरंभकर्ता स्पूफ़ `ABX\0` बाइनरी-XML मैजिक की जाँच करता है, डिकोड करता है,
  संपादित करता है, पुनः एनकोड करता है, सत्यापित करने के लिए राउंड-ट्रिप करता है, बाइट-सटीक बैकअप लेता है और
  परमाणु रूप से स्वैप करता है, जब तक हर चरण पास न हो, जीवित फ़ाइल को कभी नहीं छुआ जाता।
- **रिबूट-मुक्त।** माउंट करने के लिए कुछ भी नहीं वाला एक स्वयं-निहित WebUI मॉड्यूल: `customize.sh` इसे सक्रिय
  मॉड्यूल डायरेक्टरी में कॉपी कर देता है ताकि यह फ़्लैश होते ही काम करे।
- **फ़्लैशलेस अपडेट।** वेंडर किया गया **VDLU** इंजन केवल बदली हुई, कंटेंट-एड्रेस्ड, ed25519-हस्ताक्षरित
  फ़ाइलें डाउनलोड करके मॉड्यूल को अपडेट करता है - कोई पूर्ण रीफ़्लैश नहीं।
- **अलग किया गया।** लंबे ऑपरेशन webview के बाहर चलते हैं, WebUI बंद करने से वे कभी बाधित नहीं होते।

## संगतता गारंटी

- डिवाइस पर POSIX `sh` (`sh -n` पास होता है, `local` से परे कोई bashism नहीं, `awk` पर कोई निर्भरता नहीं)।
- `pm` / `dumpsys` / `settings` / `cmd` ही एकमात्र फ़्रेमवर्क उपकरण हैं जिनका उपयोग होता है, सभी
  `/system/bin` के ज़रिए।
- बंडल की गई बाइनरी (`jq`, `abx2xml`/`xml2abx`) सामान्य पथ के लिए वैकल्पिक हैं और अपनी प्रामाणिकता ले जाती
  हैं, ABX कनवर्टर मौजूद होने पर डिवाइस के अपने `/system/bin/abx2xml` पर वापस गिर जाता है।

<!-- doc-footer -->

---

> _यह दस्तावेज़ Claude (Anthropic) से तैयार किया गया है और इसे VD171 द्वारा अनुरक्षित किया जाता है। सुधार और संशोधन का स्वागत है, देखें [CONTRIBUTING.md](CONTRIBUTING.md)।_
