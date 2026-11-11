#!/usr/bin/env bash
# Export one or both targets to build/. Usage: ./.make/build.sh [msx|trs80]
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build"
TARGET="${1:-}"

mkdir -p "$BUILD_DIR"

export_one() {
	local tgt="$1"
	local out
	case "$tgt" in
	msx) out="$BUILD_DIR/sand-runner.rom" ;;
	trs80) out="$BUILD_DIR/sand-runner.cmd" ;;
	*)
		echo "sand-runner: build: unknown target '$tgt'" >&2
		exit 2
		;;
	esac
	echo "Exporting $tgt → $out"
	elara8 --target "$tgt" build -o "$out" "$ROOT_DIR/$tgt/main.ela"
}

case "$TARGET" in
"")
	export_one msx
	export_one trs80
	;;
msx|trs80)
	export_one "$TARGET"
	;;
*)
	echo "sand-runner: build: unknown target '$TARGET' (use msx|trs80 or omit for both)" >&2
	exit 2
	;;
esac
