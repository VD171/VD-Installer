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

> **Languages:** [English](../../SECURITY.md) · [العربية](../ar/SECURITY.md) · [Čeština](../cs/SECURITY.md) · [Deutsch](../de/SECURITY.md) · [Español](../es/SECURITY.md) · [فارسی](../fa/SECURITY.md) · [Français](../fr/SECURITY.md) · हिन्दी · [Bahasa Indonesia](../id/SECURITY.md) · [Italiano](../it/SECURITY.md) · [日本語](../ja/SECURITY.md) · [한국어](../ko/SECURITY.md) · [Nederlands](../nl/SECURITY.md) · [Polski](../pl/SECURITY.md) · [Português](../pt/SECURITY.md) · [Русский](../ru/SECURITY.md) · [Svenska](../sv/SECURITY.md) · [ไทย](../th/SECURITY.md) · [Türkçe](../tr/SECURITY.md) · [Українська](../uk/SECURITY.md) · [Tiếng Việt](../vi/SECURITY.md) · [中文](../zh/SECURITY.md)

---

# सुरक्षा नीति

## एक पंक्ति में खतरा मॉडल

VDInstaller root के रूप में चलता है और उन APKs को install करता है जिन्हें उपयोगकर्ता स्पष्ट रूप से चुनता
है; किसी install के लिए Play Protect verifier बंद करना एक malware scan को निष्क्रिय कर देता है, इसलिए यह
"frictionless install" है, "safe install" नहीं - केवल उन्हीं APKs को install करें जिन पर आप भरोसा करते हैं।

## यह क्या करता है और क्या नहीं करता

- यह डिफ़ॉल्ट रूप से package verifier को उसकी ठीक पिछली स्थिति में बहाल करता है (जहाँ कोई मान नहीं था वहाँ `0`/`1` छोड़ना स्वयं एक tell है, इसलिए इसे फिर से हटा दिया जाता है)।
- यह आपके HMA-OSS setup को कभी नहीं छूता; apps को छिपाना एक अनुशंसा है जिस पर आप स्वयं कार्य करते हैं।
- `packages.xml` install-source संपादन ABX-aware है, किसी भी परिवर्तन से पहले live फ़ाइल का byte-exact backup लेता है, मान्य करने के लिए round-trip करता है, और किसी भी विफलता पर live फ़ाइल को अछूता छोड़ देता है।
- Bundled binaries build के समय उनके आधिकारिक upstream से लाए जाते हैं और एक `PROVENANCE.json` रखते हैं।

## किसी भेद्यता की रिपोर्ट करना

कृपया पहले निजी तौर पर रिपोर्ट करें। पुन: उत्पन्न करने के चरण, प्रभावित संस्करण, और प्रभाव शामिल करें।

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

> _यह दस्तावेज़ Claude (Anthropic) से तैयार किया गया है और इसे VD171 द्वारा अनुरक्षित किया जाता है। सुधार और संशोधन का स्वागत है; देखें [CONTRIBUTING.md](CONTRIBUTING.md)।_
