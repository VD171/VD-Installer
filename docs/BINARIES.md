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

> **Languages:** English · [العربية](ar/BINARIES.md) · [Čeština](cs/BINARIES.md) · [Deutsch](de/BINARIES.md) · [Español](es/BINARIES.md) · [فارسی](fa/BINARIES.md) · [Français](fr/BINARIES.md) · [हिन्दी](hi/BINARIES.md) · [Bahasa Indonesia](id/BINARIES.md) · [Italiano](it/BINARIES.md) · [日本語](ja/BINARIES.md) · [한국어](ko/BINARIES.md) · [Nederlands](nl/BINARIES.md) · [Polski](pl/BINARIES.md) · [Português](pt/BINARIES.md) · [Русский](ru/BINARIES.md) · [Svenska](sv/BINARIES.md) · [ไทย](th/BINARIES.md) · [Türkçe](tr/BINARIES.md) · [Українська](uk/BINARIES.md) · [Tiếng Việt](vi/BINARIES.md) · [中文](zh/BINARIES.md)

---

# Bundled binaries: provenance and auditing

## Principles

- Nothing opaque ships. Every bundled binary is fetched at **build time from its official upstream**,
  never pulled from a device, and every file carries a sha256 so the payload can be reproduced.
- Binaries are bundled for **all four ABIs** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`); the flash
  installer prunes to the device's one.
- They run standalone: each binary's shared-library closure is shipped alongside and the engine sets
  `LD_LIBRARY_PATH` to the bundled `lib/`, so there is no dependency on Termux being installed.

## What ships, and from where

| Binary | From | Why |
|---|---|---|
| `jq` (+ `lib/`) | the Termux package repository (`packages.termux.dev/apt`), official `.deb` | the engine speaks JSON; `jq` parses args and builds replies. |
| `abx2xml` / `xml2abx` | [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) release | decode/encode Android binary XML (ABX) for the `packages.xml` install-source spoof, where the device lacks `/system/bin/abx2xml` (pre-A12). The device's own converter is preferred when present. |
| `vdlu/verify/<abi>/ed25519-mini` | the canonical [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) engine | verify the ed25519 signature on flashless (VDLU) updates, without OpenSSL. |

The build step is `.github/scripts/build_bin.sh`: it resolves the Termux package plus its transitive
dependencies, extracts the `.deb`s, copies the wanted binaries and the shared-library closure each one
needs (resolved with `readelf`), then fetches the standalone ABX converter.

## The on-device manifest: `PROVENANCE.json`

Each `bin/<abi>/` carries a `PROVENANCE.json` listing every shipped file (path, size, sha256) and the
upstream source of each (package, version, URL, archive sha256). It survives the on-device ABI prune,
so the audit trail ships with the module itself.

## How to verify

1. Open `bin/<abi>/PROVENANCE.json` on the device or in the flashable zip.
2. Re-fetch each pinned source from the URL it records.
3. Extract and compare the sha256 of each file against the manifest.

The flashable zip additionally carries a `.sha256` companion next to every shipped file; `customize.sh`
verifies them at flash time and **aborts** on any mismatch (a corrupted or truncated zip).

## Reporting

Found a mismatch or a provenance concern? Report it privately - see [SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](../CONTRIBUTING.md)._
