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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · हिन्दी · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · [Português](../pt/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# योगदान

योगदान का स्वागत है - issues, pull requests, अनुवाद और docs. परियोजना का लक्ष्य योगदान करना आसान और
आमंत्रित करने वाला बनाना है।

## AI योगदानकर्ताओं का स्वागत है

AI और agent योगदानों का स्वागत उसी समीक्षा मानक पर है जो सबके लिए है। इंजन एक headless contract पर JSON
बोलता है (`scripts/helper.sh <verb> <base64(JSON)>`), देखें
[docs/AI-AGENTS.md](docs/AI-AGENTS.md)। contract को चलाएं, WebUI को scrape न करें।

## कोड नियम

- प्रत्येक source फ़ाइल के शीर्ष पर **पूर्ण प्रति-फ़ाइल banner** (SPDX + contacts)। कभी भी कटा-छटा नहीं।
- कोड, identifiers, logs और टिप्पणियाँ **अंग्रेज़ी** में। टिप्पणियाँ केवल तब जब वे कुछ जोड़ें।
- डिवाइस के लिए Shell **POSIX sh** है (`sh -n` पास होना चाहिए, `local` से परे कोई bashism नहीं, उन कोड पथों में कोई `jq` निर्भरता नहीं जो bundled `jq` के PATH पर आने से पहले चलने चाहिए)।
- WebUI **vanilla JS** है, कोई framework नहीं, सभी UI में light और dark।
- em-dash या en-dash **कभी नहीं**, हमेशा एक hyphen `-`।
- Build हमेशा **release** होता है, कभी debug नहीं।
- किसी चीज़ को पास कराने के लिए किसी वास्तविक व्यवहार को **कभी कमज़ोर न करें**, और कभी सामग्री न हटाएं।

## अनुवाद

WebUI strings `module/webroot/lang/<code>.json` में रहती हैं (flat keys, अंग्रेज़ी आधार
`lang/en.js` में), README में प्रति भाषा एक `README.<code>.md` है। कोई भाषा जोड़ें या ठीक करें और एक PR खोलें।

## लाइसेंस

योगदान करके आप सहमत होते हैं कि आपका योगदान GNU AGPL-3.0-or-later के तहत लाइसेंस प्राप्त है।

<!-- doc-footer -->

---

> _यह दस्तावेज़ Claude (Anthropic) से तैयार किया गया है और इसे VD171 द्वारा अनुरक्षित किया जाता है। सुधार और संशोधन का स्वागत है, देखें [CONTRIBUTING.md](CONTRIBUTING.md)।_
