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

> **Languages:** English · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Frictionless root sideload installer - KernelSU / APatch / Magisk WebUI.

## Why

Installing a sideloaded APK on a rooted phone is noisier than it should be: Play Protect's package
verifier can throw `INSTALL_FAILED_VERIFICATION_FAILURE`, split apps (`.xapk` / `.apkm` / `.apks`)
need the session API by hand, and a freshly installed app announces itself as "sideloaded" to every
app that reads its install source. VDInstaller does all of that for you, already as root, with no
"grant su" prompt and no terminal.

## Features

- **Every shape of APK** - a single `.apk`, a whole folder of independent APKs (batch), a grouped
  split archive (`.xapk` / `.apkm` / `.apks` / `.zip`), or a folder of loose split APKs.
- **No verification wall** - a 3-way toggle for the Play Protect package verifier: keep it as it
  was (off only during the install, restored exactly), always on, or always off.
- **Honest about Developer Verification** - a root install is already exempt from Android's 2026
  Developer Verification; the toggle is best-effort and says so, never a fake switch.
- **Not "sideloaded"** - optionally presents the install source as the Play Store, both the
  installer (at install time) and the initiator (via an ABX-aware `packages.xml` edit).
- **Detached and resumable** - installs run as a detached root process; closing the WebUI never
  interrupts them, and the UI reattaches by operation id.
- **Your call** - test packages, grant all runtime permissions, target user, bypass the
  low-target-SDK block: all optional.
- **Offline, self-contained, reboot-free** - a WebUI module with its binaries bundled; usable the
  moment it is flashed.

## AI agents

This project welcomes AI and agent contributors. The engine speaks JSON over a small headless
contract (`scripts/helper.sh <verb> <base64(JSON)>`), documented in
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), so an agent can drive every action the WebUI can - do not
scrape the WebUI. Patches from AI are held to the same review bar as any other.

## Install

Flash the zip in KernelSU, APatch or Magisk and open the VDInstaller WebUI from your root manager.
The installer keeps only your device's ABI and runs the mandatory `.sha256` integrity gate
(aborts on a corrupted or truncated zip). Android 8.0 (API 26) or newer.

## Security

VDInstaller runs as root and installs APKs you choose; turning the package verifier off for an
install disables a malware scan, so install only APKs you trust. It never weakens device security
silently: the verifier is restored to its exact prior state by default, and it never touches your
HMA-OSS setup. Report issues per [SECURITY.md](SECURITY.md).

## Build

Always release, never debug. `.github/scripts/build_bin.sh` fetches `jq` from the Termux apt
repository (with its shared-library closure) and the standalone `abx2xml` / `xml2abx` converters,
for all four ABIs, each with a `PROVENANCE.json`. The release workflow assembles the flashable
zips, writes `.sha256` companions, fills `update.json` and publishes as `github-actions[bot]`.

## Documentation

Guides live in [docs/](docs/) and mirror to the GitHub wiki. See
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) for the headless contract.

## See also

- **[VDInfos](https://github.com/VD171/VD-Infos)**: a device method debugger that reads each item through every method that can read it and compares them side by side.
- **[VDGoogle](https://github.com/VD171/VD-Google)**: your Google services (RCS, Wallet, Play Integrity attestations), read on your device with no internet.
- **[COPG-VD](https://github.com/VD171/COPG-VD)**: a device spoofer that turns a fresh fingerprint into a coherent, consistent profile.
- **[VD-dropbear](https://github.com/VD171/VD-dropbear)**: a standalone rooted SSH daemon (Dropbear).
- **[VDBackup](https://github.com/VD171/VD-Backup)**: full app and data backup and restore as root, driven entirely from a WebUI.
- **[VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)**: a flashless, incremental self-update engine embedded into KernelSU/APatch/Magisk modules.

## Contacts

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/root-webui-v1-00-vd-installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## License

VDInstaller is licensed under the GNU AGPL-3.0-or-later. See [LICENSE](LICENSE). NETWORK COPYLEFT:
run a modified version, even as a service, and you must offer its source.

## Trademarks

Android, KernelSU, APatch, Magisk, Google Play and Play Protect belong to their respective owners.
This project is independent and not affiliated with or endorsed by them.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Join the channel: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
