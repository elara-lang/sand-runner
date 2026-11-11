#!/usr/bin/env bash
# Re-encode art.txt via assetkit. Usage: ./.make/assets.sh [msx|trs80]
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-}"

encode_one() {
	local tgt="$1"
	local art="$ROOT_DIR/$tgt/assets/art.txt"
	if [[ ! -f "$art" ]]; then
		echo "sand-runner: missing $art" >&2
		exit 1
	fi
	case "$tgt" in
	msx)
		echo "Encoding MSX assets from $art"
		assetkit --target msx encode "$art" \
			--sprites "$ROOT_DIR/msx/assets/runner.sprites" \
			--tiles "$ROOT_DIR/msx/assets/runner.tiles"
		;;
	trs80)
		echo "Encoding TRS-80 stamps from $art"
		assetkit --target trs80 encode "$art" \
			--stamps "$ROOT_DIR/trs80/assets/runner.stamps"
		;;
	*)
		echo "sand-runner: assets: unknown target '$tgt'" >&2
		exit 2
		;;
	esac
}

case "$TARGET" in
"")
	encode_one msx
	encode_one trs80
	;;
msx|trs80)
	encode_one "$TARGET"
	;;
*)
	echo "sand-runner: assets: unknown target '$TARGET' (use msx|trs80 or omit for both)" >&2
	exit 2
	;;
esac
