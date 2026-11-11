#!/usr/bin/env bash
# Playtest one target: ./.make/run.sh msx|trs80 [-- extra elara8 run flags...]
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-}"
shift || true

case "$TARGET" in
msx|trs80) ;;
*)
	echo "sand-runner: run requires target msx|trs80 (got '${TARGET:-}')" >&2
	exit 2
	;;
esac

exec elara8 --target "$TARGET" run "$@" "$ROOT_DIR/$TARGET/main.ela"
