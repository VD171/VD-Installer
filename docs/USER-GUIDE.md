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

> **Languages:** English · [العربية](ar/USER-GUIDE.md) · [Čeština](cs/USER-GUIDE.md) · [Deutsch](de/USER-GUIDE.md) · [Español](es/USER-GUIDE.md) · [فارسی](fa/USER-GUIDE.md) · [Français](fr/USER-GUIDE.md) · [हिन्दी](hi/USER-GUIDE.md) · [Bahasa Indonesia](id/USER-GUIDE.md) · [Italiano](it/USER-GUIDE.md) · [日本語](ja/USER-GUIDE.md) · [한국어](ko/USER-GUIDE.md) · [Nederlands](nl/USER-GUIDE.md) · [Polski](pl/USER-GUIDE.md) · [Português](pt/USER-GUIDE.md) · [Русский](ru/USER-GUIDE.md) · [Svenska](sv/USER-GUIDE.md) · [ไทย](th/USER-GUIDE.md) · [Türkçe](tr/USER-GUIDE.md) · [Українська](uk/USER-GUIDE.md) · [Tiếng Việt](vi/USER-GUIDE.md) · [中文](zh/USER-GUIDE.md)

---

# VDInstaller user guide

## Table of contents

1. [What VDInstaller is](#1-what-vdinstaller-is)
2. [Requirements](#2-requirements)
3. [Install and first run](#3-install-and-first-run)
4. [The WebUI tour](#4-the-webui-tour)
5. [Installing APKs](#5-installing-apks)
6. [Options](#6-options)
7. [Driving VDInstaller from an AI assistant](#7-driving-vdinstaller-from-an-ai-assistant)
8. [Troubleshooting and FAQ](#8-troubleshooting-and-faq)

## 1. What VDInstaller is

VDInstaller is a KernelSU / APatch / Magisk **WebUI module** that installs sideloaded APKs as root
with no friction: no "grant su" prompt, no terminal, and no fighting the Play Protect verifier. It
handles single APKs, a whole folder at once, and split apps (`.xapk` / `.apkm` / `.apks` / `.zip` or
loose split files), and it can present the install source as the Play Store so an app does not look
sideloaded.

## 2. Requirements

- Android 8.0 or newer (API 26+).
- A root solution with WebUI support: **KernelSU**, **APatch** or **Magisk**.

## 3. Install and first run

1. Download the latest `VD-Installer-vX.XX-universal.zip` from the
   [Releases](https://github.com/VD171/VD-Installer/releases) page.
2. Flash it as a module in your root manager (*Modules -> Install from storage*).
3. VDInstaller activates **without a reboot** - it is self-contained (WebUI + bundled binaries), so
   there is nothing to mount.
4. Open the **VDInstaller** WebUI from your root manager's module list.

On flash the installer keeps only your device's ABI and runs a mandatory `.sha256` integrity gate
that **aborts** if the zip is corrupted or truncated. Settings live in `/data/adb/vdinstaller` and
survive updates.

## 4. The WebUI tour

Three tabs:

- **Install** - pick a mode, choose the APK or folder, install, watch live progress.
- **Options** - install source, the Play Protect verifier toggle, and install flags. Everything is
  saved automatically.
- **About** - version, what it does, requirements, links and license.

## 5. Installing APKs

You pick the mode on the **Install** tab; VDInstaller never guesses.

| Mode | You give | What happens |
|---|---|---|
| **Single APK** | a `.apk` file | one install session, one app. |
| **Folder of APKs** (batch) | a folder of independent `.apk` files | each APK is installed on its own, one after another; a partial batch reports which failed and why. |
| **Split archive** | a `.xapk` / `.apkm` / `.apks` / `.zip` | extracted, then `base.apk` + splits installed as one app in a single session (XAPK OBB is placed too, when present). |
| **Split folder** | a folder with the loose split `.apk` files of one app | the splits installed as one app in a single session. |

A "split" app is one APK divided into a base plus per-density / per-ABI / per-language config APKs;
they must be installed **together** in one session, which the Split modes do for you.

### 5.1 The Browse dialog

**Browse** opens a file picker that lists folders and installable files at a path:

- Tap a **folder** to go into it; **Up** goes to the parent.
- In a file mode (Single APK / Split archive), tap a **file** to select it.
- In a folder mode (Folder of APKs / Split folder), navigate into the folder and tap **Use this folder**.

You can also type or paste a path directly (for example `/sdcard/Download/app.apk`).

### 5.2 Progress, cancel, resume

Installs run as a **detached root process**. A progress card shows the phase; **Cancel** stops it.
If you close the WebUI mid-install, the install keeps going and the UI reattaches by operation id
when you reopen it.

## 6. Options

Everything here is saved automatically and applies to the next install.

### 6.1 Install source

A freshly sideloaded app announces to every app that reads it (and to attestation) that it was
sideloaded. VDInstaller can present the source as the Play Store instead.

- **Show the Play Store as installer** (default on) - sets `installerPackageName` via
  `pm install-create -i com.android.vending`. Applies immediately.
- **Also spoof the initiator** (default on) - sets `installInitiator` and `packageSource` by editing
  `/data/system/packages.xml`. This is **ABX-aware** (decode -> edit -> re-encode, with a byte-exact
  backup and an atomic swap) and applies **after the next reboot**, because the package manager
  caches `packages.xml`.

### 6.2 Play Protect package verifier

A sideloaded install can be rejected with `INSTALL_FAILED_VERIFICATION_FAILURE` by Play Protect's
package verifier. A 3-way toggle:

- **Keep as it was** (default) - off only for the install, then restored to its **exact** prior
  state (deleted again if there was no explicit value, since a `0`/`1` where there was none is itself
  a tell on a stealth device).
- **Always on** - force it on and keep it.
- **Always off** - force it off and keep it. The WebUI warns: leaving it off is a stealth tell and
  disables a malware scan for every install.

### 6.3 Developer Verification

Android's 2026 Developer Verification blocks installing apps from unregistered developers on
certified devices, but it is enforced by a **separate service**, not Play Protect, and a **root
install is already exempt** from it (the same exemption ADB installs get). VDInstaller installs your
APKs regardless, so this toggle is **best-effort and honest**: it applies a real knob only if one
exists and never pretends to flip a switch that does nothing.

### 6.4 Install flags

| Flag | Effect |
|---|---|
| **Grant all runtime permissions** | grant every runtime permission at install (`-g`). |
| **Allow test packages** | install packages marked test-only (`-t`). |
| **Bypass low target SDK block** | install apps with a very old `targetSdk`. |
| **Target user** | the Android user id to install for (default `0`). |

### 6.5 Staying hidden

For stealth, consider hiding your root manager and sensitive apps with HMA-OSS. VDInstaller **never
touches your HMA-OSS setup** - the hint is only a reminder; you make the change yourself in HMA-OSS.

## 7. Driving VDInstaller from an AI assistant

The engine speaks a small JSON contract over `scripts/helper.sh`, so an agent can drive every action
the WebUI can. See [AI-AGENTS](AI-AGENTS). Drive the contract, do not scrape the WebUI.

## 8. Troubleshooting and FAQ

**I get `INSTALL_FAILED_VERIFICATION_FAILURE`.** That is the Play Protect package verifier. With the
verifier toggle left at **Keep as it was** (the default), VDInstaller turns it off for the install and
restores it, so it does not happen.

**I turned on the Play Store source but the app still looks sideloaded.** The installer part applies
immediately; the initiator part (`packages.xml`) applies **after the next reboot**.

**Does it bypass Google's Developer Verification?** It does not need to - a root install is exempt
(see 6.3). There is no fake switch for it.

**Does it need a reboot?** No, except the optional initiator spoof.

**Will uninstalling VDInstaller remove the apps I installed?** No - those are real installs owned by
the system; removing the module only cleans up VDInstaller's own state.

**Is it safe?** It installs APKs you choose and, with the verifier off, skips a malware scan - install
only APKs you trust. It never weakens anything silently.

<!-- doc-footer -->

---

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](../CONTRIBUTING.md)._
