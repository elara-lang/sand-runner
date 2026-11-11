#!/usr/bin/env bash
# Headless playtest for one or both targets. Usage: ./.make/test.sh [msx|trs80]
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
FRAMES="${FRAMES:-600}"
TARGET="${1:-}"

run_one() {
	local tgt="$1"
	echo "Headless $tgt (--frames $FRAMES)"
	elara8 --target "$tgt" run --headless --frames "$FRAMES" \
		"$ROOT_DIR/$tgt/main.ela"
}

case "$TARGET" in
"")
	run_one msx
	run_one trs80
	;;
msx|trs80)
	run_one "$TARGET"
	;;
*)
	echo "sand-runner: test: unknown target '$TARGET' (use msx|trs80 or omit for both)" >&2
	exit 2
	;;
esac
