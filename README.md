# Sand Runner

Original endless runner for 8-bit Elara targets (MSX1 and TRS-80 Model III), built with the **elara8** playtest and export host.

Portuguese: [README-PT.md](README-PT.md).

## Highlights

- Dual ports from one repo: colourful MSX1 sprites (`msx.*`) and Model III cell-grid stamps (`trs.*`)
- Canonical entry `main.ela` per target under `msx/` and `trs80/`
- Playtest on the PC via `elara8 --target … run` (preview host, not a faithful emulator)
- Export a 16 KB MSX1 `.rom` or a Model III `.cmd` for real hardware or dedicated emulators
- Attract mode, session `HI`, jump/obstacle loop, and short SFX on both targets
- Assets regenerated from `art.txt` with elara8's `assetkit`
- Make verbs: `run`, `build`, `test`, `assets`, `clean`

## Prerequisites

- **elara8** installed system-wide:
  - `/usr/bin/elara8` — playtest + export CLI
  - `/usr/bin/assetkit` — ASCII art encoder (optional; for `make assets`)
  - `/usr/share/elara8/` — runtimes, docs, and shared data used by export
- Optional, for export only: **SDCC 4.2+**. Optional emulator checks: **openMSX**, **trs80gp**

`make test` only needs `/usr/bin/elara8`. Full `make build` needs SDCC and the Z80 runtimes under `/usr/share/elara8`.

## Installation

This repo is the game, not an installable CLI. Assume the elara8 package is already installed:

```text
/usr/bin/elara8
/usr/bin/assetkit
/usr/share/elara8/
```

With those on `PATH`, `make run` / `make build` / `make test` just call `elara8` and `assetkit`.

## Quick Start

```bash
make run msx           # interactive PC playtest
make run trs80
make test              # headless both targets, 600 frames
```

## Usage

### Playtest

```bash
make run msx
make run trs80
elara8 --target msx run msx/main.ela
elara8 --target trs80 run --headless --frames 600 trs80/main.ela
```

| Action | MSX | TRS-80 |
| --- | --- | --- |
| Jump / start / restart | Joy0 up or fire A, or cursor-up / space | Joy up or fire, or cursor-up / space |

Interactive `run` opens the playtest preview. Use `--headless` (or `make test`) in scripts and CI.

### Export

```bash
make build             # → build/sand-runner.rom and build/sand-runner.cmd
make build msx
make build trs80
```

| Target | Artifact |
| --- | --- |
| `msx` | `build/sand-runner.rom` (16 KB MSX1 cartridge) |
| `trs80` | `build/sand-runner.cmd` (Model III CMD) |

### Assets

```bash
make assets            # re-encode both art.txt files via assetkit
make assets msx
make assets trs80
```

Asset layouts follow `/usr/share/elara8/docs/assets.md`.

## Project Layout

```
msx/                 # MSX1 port (main.ela + assets)
trs80/               # Model III port (main.ela + assets)
build/               # Exported .rom / .cmd (git-ignored)
.make/               # run / build / test / assets / clean scripts
```

## Development

```bash
make help              # verbs and components
make run msx           # interactive playtest
make build             # export both targets to build/
make test              # headless both (FRAMES=600)
make assets            # regenerate binaries from art.txt
make clean             # remove build/
```

## License

MIT — see [LICENSE](LICENSE).
