# Third-Party Notices

VDInstaller is distributed under the GNU AGPL-3.0-or-later. It also bundles and
distributes third-party software, acknowledged below with its author, license,
and source. Each component remains under its own license.

## jq

VDInstaller bundles `jq` (and its shared-library closure), built from the official
Termux package repository, so the engine can parse arguments and build JSON replies.

- **Project:** jq
- **License:** MIT
- **Source:** https://jqlang.github.io/jq/ (bundled from https://packages.termux.dev/apt)

## Oniguruma (libonig)

jq links against Oniguruma for its regular-expression engine; VDInstaller bundles
the `libonig.so` closure built from the official Termux package repository.

- **Project:** Oniguruma
- **License:** BSD-2-Clause
- **Source:** https://github.com/kkos/oniguruma (bundled from https://packages.termux.dev/apt)

## Android binary XML converter (abx2xml / xml2abx)

VDInstaller bundles the standalone `abx2xml` / `xml2abx` binaries as a fallback for
decoding and encoding Android binary XML (ABX), used by the `packages.xml`
install-source spoof where the device lacks `/system/bin/abx2xml`.

- **Project:** android-xml-converter
- **Author:** rhythmcache
- **Source:** https://github.com/rhythmcache/android-xml-converter

## ed25519-mini (VDLU update verifier)

The vendored VDLU flashless-update engine bundles the `ed25519-mini` signature
verifier, from the canonical VDLiveUpdate engine, to check ed25519 signatures on
updates without OpenSSL.

- **Project:** VDLiveUpdate
- **Author:** VD171
- **Source:** https://github.com/VD171/VDLiveUpdate

Each bundled binary is listed with its version and provenance in
[docs/BINARIES.md](docs/BINARIES.md), and every `bin/<abi>/` carries a `PROVENANCE.json`.
