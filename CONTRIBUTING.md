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

# Contributing

Contributions are welcome - issues, pull requests, translations and docs. The project aims to be
easy and inviting to contribute to.

## AI contributors welcome

AI and agent contributions are welcome at the same review bar as everyone else. The engine speaks
JSON over a headless contract (`scripts/helper.sh <verb> <base64(JSON)>`); see
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Drive the contract, do not scrape the WebUI.

## Code rules

- **Complete per-file banner** (SPDX + contacts) at the top of every source file. Never a trimmed one.
- Code, identifiers, logs and comments in **English**. Comments only when they add something.
- Shell is **POSIX sh** for the device (`sh -n` must pass; no bashisms beyond `local`; no `jq` dependency in code paths that must run before the bundled `jq` is on PATH).
- WebUI is **vanilla JS**, no framework; light and dark in all UI.
- **Never** an em-dash or en-dash; always a hyphen `-`.
- Build is always **release**, never debug.
- **Never weaken a real behavior** to make something pass, and never remove content.

## Translations

The WebUI strings live in `module/webroot/lang/<code>.json` (flat keys, English base in
`lang/en.js`); the README has a `README.<code>.md` per language. Add or fix a language and open a PR.

## License

By contributing you agree your contribution is licensed under the GNU AGPL-3.0-or-later.
