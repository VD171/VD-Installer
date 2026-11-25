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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · हिन्दी · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> बिना झंझट के रूट साइडलोड इंस्टॉलर - KernelSU / APatch / Magisk WebUI।

## क्यों

रूट किए हुए फ़ोन पर साइडलोडेड APK इंस्टॉल करना जितना होना चाहिए उससे ज़्यादा झंझट भरा है: Play Protect का
पैकेज वेरिफ़ायर `INSTALL_FAILED_VERIFICATION_FAILURE` फेंक सकता है, स्प्लिट ऐप्स (`.xapk` / `.apkm` /
`.apks`) को हाथ से session API की ज़रूरत होती है, और अभी-अभी इंस्टॉल हुआ ऐप अपने आप को हर उस ऐप के सामने
"sideloaded" घोषित करता है जो उसका इंस्टॉल स्रोत पढ़ता है। VDInstaller यह सब आपके लिए करता है, पहले से ही
रूट के रूप में, बिना किसी "su दें" प्रॉम्प्ट और बिना टर्मिनल के।

## विशेषताएँ

- **APK के हर रूप** - एक अकेला `.apk`, स्वतंत्र APK का पूरा फ़ोल्डर (batch), एक समूहित स्प्लिट आर्काइव
  (`.xapk` / `.apkm` / `.apks` / `.zip`), या अलग-अलग स्प्लिट APK का फ़ोल्डर।
- **कोई वेरिफ़िकेशन दीवार नहीं** - Play Protect पैकेज वेरिफ़ायर के लिए 3-तरफ़ा टॉगल: जैसा था वैसा रखें
  (केवल इंस्टॉल के दौरान बंद, फिर ठीक वैसे ही बहाल), हमेशा चालू, या हमेशा बंद।
- **Developer Verification के बारे में ईमानदार** - एक रूट इंस्टॉल Android की 2026 Developer Verification से
  पहले से ही मुक्त है; यह टॉगल best-effort है और ऐसा कहता भी है, कभी नकली स्विच नहीं।
- **"sideloaded" नहीं** - वैकल्पिक रूप से इंस्टॉल स्रोत को Play Store के रूप में दिखाता है, इंस्टॉलर के रूप
  में भी (इंस्टॉल के समय) और इनिशिएटर के रूप में भी (ABX-सचेत `packages.xml` संपादन के ज़रिए)।
- **अलग और फिर से शुरू करने योग्य** - इंस्टॉल एक अलग रूट प्रक्रिया के रूप में चलते हैं; WebUI बंद करने से वे
  कभी बाधित नहीं होते, और UI ऑपरेशन id के ज़रिए फिर से जुड़ जाता है।
- **आपकी मर्ज़ी** - टेस्ट पैकेज, सभी रनटाइम अनुमतियाँ देना, टारगेट उपयोगकर्ता, कम-टारगेट-SDK
  ब्लॉक को बायपास करना: सब वैकल्पिक।
- **ऑफ़लाइन, आत्मनिर्भर, रीबूट-मुक्त** - अपने बाइनरी के साथ बंडल किया गया एक WebUI मॉड्यूल; फ़्लैश होते ही
  उपयोग करने योग्य।

## AI एजेंट

यह प्रोजेक्ट AI और एजेंट योगदानकर्ताओं का स्वागत करता है। engine एक छोटे headless कॉन्ट्रैक्ट
(`scripts/helper.sh <verb> <base64(JSON)>`) के ज़रिए JSON बोलता है, जो [docs/AI-AGENTS.md](docs/AI-AGENTS.md)
में प्रलेखित है, ताकि एक एजेंट हर वह क्रिया चला सके जो WebUI कर सकती है - WebUI को scrape न करें। AI से आई
पैच किसी भी अन्य की तरह समान समीक्षा मानक पर रखी जाती हैं।

## इंस्टॉल

zip को KernelSU, APatch या Magisk में फ़्लैश करें और अपने रूट मैनेजर से VDInstaller WebUI खोलें। इंस्टॉलर
केवल आपके डिवाइस का ABI रखता है और अनिवार्य `.sha256` इंटेग्रिटी गेट चलाता है (भ्रष्ट या कटे-छँटे zip पर रुक
जाता है)। Android 8.0 (API 26) या नया।

## सुरक्षा

VDInstaller रूट के रूप में चलता है और आपके चुने हुए APK इंस्टॉल करता है; किसी इंस्टॉल के लिए पैकेज वेरिफ़ायर
बंद करने से एक मैलवेयर स्कैन निष्क्रिय हो जाता है, इसलिए केवल वही APK इंस्टॉल करें जिन पर आप भरोसा करते हैं।
यह कभी चुपचाप डिवाइस की सुरक्षा कमज़ोर नहीं करता: डिफ़ॉल्ट रूप से वेरिफ़ायर अपनी ठीक पिछली स्थिति में बहाल
कर दिया जाता है, और यह आपकी HMA-OSS सेटअप को कभी नहीं छूता। समस्याओं की रिपोर्ट [SECURITY.md](SECURITY.md)
के अनुसार करें।

## बिल्ड

हमेशा release, कभी debug नहीं। `.github/scripts/build_bin.sh` Termux apt रिपॉज़िटरी से `jq` (उसके
साझा-लाइब्रेरी क्लोज़र सहित) और स्टैंडअलोन `abx2xml` / `xml2abx` कन्वर्टर लाता है, चारों ABI के लिए, हर एक
`PROVENANCE.json` के साथ। release वर्कफ़्लो फ़्लैश करने योग्य zip जोड़ता है, `.sha256` साथी लिखता है,
`update.json` भरता है और `github-actions[bot]` के रूप में प्रकाशित करता है।

## प्रलेखन

गाइड [docs/](docs/) में रहते हैं और GitHub विकी पर मिरर होते हैं। headless कॉन्ट्रैक्ट के लिए
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) देखें।

## यह भी देखें

- **[COPG-VD](https://github.com/VD171/COPG-VD)**: डिवाइस fingerprint / Play Integrity का ग्लोबल स्पूफ़िंग, पूरे डिवाइस पर प्रति-ऐप स्कोप और एक WebUI के साथ।
- **[VDBackup](https://github.com/VD171/VD-Backup)**: रूट के रूप में ऐप और डेटा का पूर्ण बैकअप और रीस्टोर, पूरी तरह एक WebUI से संचालित।
- **[VD-dropbear](https://github.com/VD171/VD-dropbear)**: रूट के रूप में चलने वाला एक स्वतंत्र SSH डेमॉन (Dropbear)।
- **[VDGoogle](https://github.com/VD171/VD-Google)**: आपकी Google सेवाएँ (RCS, Wallet, Play Integrity प्रमाणन), आपके डिवाइस पर बिना इंटरनेट के पढ़ी गईं।
- **[VDInfos](https://github.com/VD171/VD-Infos)**: एक डिवाइस मेथड डिबगर जो हर आइटम को उसे पढ़ सकने वाले हर मेथड के ज़रिए पढ़ता है और उन्हें साथ-साथ तुलना करता है।
- **[VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)**: KernelSU/APatch/Magisk मॉड्यूल में एम्बेडेड एक फ्लैशलेस, इंक्रीमेंटल सेल्फ-अपडेट इंजन।
- **[VD-Modules](https://github.com/VD171/VD-Modules)**: हमारा MMRL/WebUI-X मॉड्यूल रिपॉज़िटरी (इन सभी को अपने root मैनेजर से इंस्टॉल करें)।
- **[@VictorGabriel7Dev/build.prop](https://github.com/VictorGabriel7Dev/build.prop)**: Pixel `build.prop` fingerprints का एक डेटासेट (@T3SL4 का फ़ोर्क)।
- **[@VictorGabriel7Dev/mtproto-store](https://github.com/VictorGabriel7Dev/mtproto-store)**: एक छोटे-से Go CLI से Telegram को ऑब्जेक्ट स्टोर के रूप में उपयोग करें।

## संपर्क

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/VD-Installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## लाइसेंस

VDInstaller GNU AGPL-3.0-or-later के तहत लाइसेंस प्राप्त है। [LICENSE](LICENSE) देखें। NETWORK COPYLEFT:
एक संशोधित संस्करण चलाएँ, यहाँ तक कि एक सेवा के रूप में भी, और आपको उसका स्रोत उपलब्ध कराना होगा।

## ट्रेडमार्क

Android, KernelSU, APatch, Magisk, Google Play और Play Protect अपने-अपने मालिकों के हैं। यह प्रोजेक्ट
स्वतंत्र है और उनसे संबद्ध या उनके द्वारा समर्थित नहीं है।

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> चैनल से जुड़ें: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
