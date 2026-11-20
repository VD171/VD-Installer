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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · हिन्दी · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# बंडल की गई बाइनरी: प्रामाणिकता और ऑडिट

## सिद्धांत

- कुछ भी अपारदर्शी शिप नहीं होता। हर बंडल की गई बाइनरी **बिल्ड के समय अपने आधिकारिक अपस्ट्रीम से** प्राप्त की
  जाती है, कभी किसी डिवाइस से नहीं निकाली जाती, और हर फ़ाइल एक sha256 ले जाती है ताकि payload को फिर से बनाया
  जा सके।
- बाइनरी **चारों ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`) के लिए बंडल की जाती हैं; फ़्लैश
  इंस्टॉलर उन्हें डिवाइस वाली एक तक छाँट देता है।
- वे स्वतंत्र रूप से चलती हैं: प्रत्येक बाइनरी का साझा-लाइब्रेरी क्लोज़र साथ में शिप होता है और इंजन
  `LD_LIBRARY_PATH` को बंडल किए गए `lib/` पर सेट करता है, इसलिए Termux के इंस्टॉल होने पर कोई निर्भरता नहीं
  है।

## क्या शिप होता है, और कहाँ से

| बाइनरी | किससे | क्यों |
|---|---|---|
| `jq` (+ `lib/`) | Termux पैकेज रिपॉज़िटरी (`packages.termux.dev/apt`), आधिकारिक `.deb` | इंजन JSON बोलता है; `jq` आर्ग्युमेंट पार्स करता है और उत्तर बनाता है। |
| `abx2xml` / `xml2abx` | [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) रिलीज़ | `packages.xml` इंस्टॉल-स्रोत स्पूफ़ के लिए Android बाइनरी XML (ABX) को डिकोड/एनकोड करता है, जहाँ डिवाइस में `/system/bin/abx2xml` नहीं है (A12 से पहले)। मौजूद होने पर डिवाइस का अपना कनवर्टर प्राथमिकता पाता है। |
| `vdlu/verify/<abi>/ed25519-mini` | कैनोनिकल [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) इंजन | OpenSSL के बिना, फ़्लैशलेस (VDLU) अपडेट पर ed25519 हस्ताक्षर सत्यापित करता है। |

बिल्ड चरण `.github/scripts/build_bin.sh` है: यह Termux पैकेज और उसकी ट्रांज़िटिव निर्भरताओं को हल करता है,
`.deb` निकालता है, वांछित बाइनरी और प्रत्येक को आवश्यक साझा-लाइब्रेरी क्लोज़र (`readelf` से हल किया गया) कॉपी
करता है, फिर स्वतंत्र ABX कनवर्टर प्राप्त करता है।

## डिवाइस-पर मैनिफ़ेस्ट: `PROVENANCE.json`

प्रत्येक `bin/<abi>/` एक `PROVENANCE.json` ले जाता है जो हर शिप की गई फ़ाइल (पथ, आकार, sha256) और प्रत्येक के
अपस्ट्रीम स्रोत (पैकेज, संस्करण, URL, आर्काइव sha256) को सूचीबद्ध करता है। यह डिवाइस-पर ABI छँटाई के बाद भी
बना रहता है, इसलिए ऑडिट ट्रेल मॉड्यूल के साथ ही शिप होता है।

## सत्यापन कैसे करें

1. डिवाइस पर या फ़्लैश करने योग्य zip में `bin/<abi>/PROVENANCE.json` खोलें।
2. प्रत्येक पिन किए गए स्रोत को उस URL से फिर से प्राप्त करें जो वह रिकॉर्ड करता है।
3. प्रत्येक फ़ाइल के sha256 को निकालें और मैनिफ़ेस्ट से तुलना करें।

फ़्लैश करने योग्य zip अतिरिक्त रूप से हर शिप की गई फ़ाइल के बगल में एक `.sha256` साथी ले जाता है;
`customize.sh` उन्हें फ़्लैश के समय सत्यापित करता है और किसी भी बेमेल (एक भ्रष्ट या अधूरा zip) पर **रद्द**
कर देता है।

## रिपोर्टिंग

कोई बेमेल या प्रामाणिकता संबंधी चिंता मिली? इसे निजी तौर पर रिपोर्ट करें - देखें
[SECURITY.md](../SECURITY.md)।

<!-- doc-footer -->

---

> _यह दस्तावेज़ Claude (Anthropic) से तैयार किया गया है और इसे VD171 द्वारा अनुरक्षित किया जाता है। सुधार और संशोधन का स्वागत है; देखें [CONTRIBUTING.md](CONTRIBUTING.md)।_
