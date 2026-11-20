#!/bin/sh
# gen-sha256.sh - write a <file>.sha256 companion next to every file in a flashable payload (STANDARDS 8).
# Run at build, after assembling the module payload and BEFORE zipping.
# Run it on the FINAL per-variant tree (after any ABI pruning) so each companion matches the files
# that variant actually ships. vdlu-pack excludes *.sha256, so companions never enter the VDLU feed:
# committed-binary modules may track them; CI-built modules (gitignored binaries) keep them gitignored
# and zip-only. Either way the companions ride only in the flashable zip (and this tool skips *.sha256,
# so no recursion).
# Each companion holds `sha256sum <basename>` output, so `sha256sum -c <basename>.sha256` verifies it.
# Redundant with module/vdlu/baseline.json by design (owner's call): an extra, human-checkable fail-safe;
# the installer MAY verify these at flash. Note: in-zip hashes catch accidental corruption, not tampering
# (an attacker edits the file AND its .sha256) - signed integrity stays the VDLU manifest's job.
# Usage: gen-sha256.sh [--check] <payload-dir> [...]
#   (no flag) generate/refresh companions ; --check verify them. Idempotent.
set -eu

mode=gen
[ "${1:-}" = "--check" ] && { mode=check; shift; }
[ "$#" -ge 1 ] || { echo "usage: gen-sha256.sh [--check] <payload-dir> [...]" >&2; exit 2; }
command -v sha256sum >/dev/null 2>&1 || { echo "gen-sha256: sha256sum required" >&2; exit 2; }

rc=0
for dir; do
	[ -d "$dir" ] || { echo "gen-sha256: not a directory: $dir" >&2; rc=2; continue; }
	if [ "$mode" = gen ]; then
		find "$dir" -type f ! -name '*.sha256' -exec sh -c '
			for f; do ( cd "$(dirname "$f")" && sha256sum "$(basename "$f")" >"$(basename "$f").sha256" ); done
		' _ {} +
		echo "gen-sha256: $dir -> $(find "$dir" -type f -name '*.sha256' | wc -l | tr -d ' ') companions"
	else
		find "$dir" -type f -name '*.sha256' -exec sh -c '
			for s; do ( cd "$(dirname "$s")" && sha256sum -c "$(basename "$s")" >/dev/null ) || { echo "MISMATCH: $s" >&2; exit 1; }; done
		' _ {} + || rc=1
		[ "$rc" = 0 ] && echo "gen-sha256: $dir -> all companions verified"
	fi
done
exit "$rc"
