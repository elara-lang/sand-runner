# Sand Runner

Corrida infinita original para alvos Elara de 8 bits (MSX1 e TRS-80 Model III), usando o host de playtest e export **elara8**.

Inglês: [README.md](README.md).

## Destaques

- Duas portas no mesmo repositório: sprites coloridas MSX1 (`msx.*`) e stamps em grade do Model III (`trs.*`)
- Entry canônica `main.ela` por alvo em `msx/` e `trs80/`
- Playtest no PC via `elara8 --target … run` (preview, não é emulador fiel)
- Exporta um `.rom` MSX1 de 16 KB ou um `.cmd` Model III para hardware real ou emuladores dedicados
- Modo attract, `HI` da sessão, loop de pulo/obstáculos e SFX curto nos dois alvos
- Assets regenerados a partir de `art.txt` com o `assetkit` do elara8
- Verbos Make: `run`, `build`, `test`, `assets`, `clean`

## Pré-requisitos

- **elara8** instalado no sistema:
  - `/usr/bin/elara8` — CLI de playtest + export
  - `/usr/bin/assetkit` — encoder de arte ASCII (opcional; para `make assets`)
  - `/usr/share/elara8/` — runtimes, docs e dados compartilhados usados no export
- Opcional, só para export: **SDCC 4.2+**. Checagens opcionais de emulador: **openMSX**, **trs80gp**

`make test` só precisa de `/usr/bin/elara8`. O `make build` completo precisa de SDCC e dos runtimes Z80 em `/usr/share/elara8`.

## Instalação

Este repositório é o jogo, não um CLI instalável. Assuma o pacote elara8 já instalado:

```text
/usr/bin/elara8
/usr/bin/assetkit
/usr/share/elara8/
```

Com isso no `PATH`, `make run` / `make build` / `make test` chamam `elara8` e `assetkit` direto.

## Início Rápido

```bash
make run msx           # playtest interativo no PC
make run trs80
make test              # headless nos dois alvos, 600 frames
```

## Uso

### Playtest

```bash
make run msx
make run trs80
elara8 --target msx run msx/main.ela
elara8 --target trs80 run --headless --frames 600 trs80/main.ela
```

| Ação | MSX | TRS-80 |
| --- | --- | --- |
| Pular / iniciar / reiniciar | Joy0 cima ou fogo A, ou seta cima / espaço | Joy cima ou fogo, ou seta cima / espaço |

O `run` interativo abre o preview de playtest. Use `--headless` (ou `make test`) em scripts e CI.

### Export

```bash
make build             # → build/sand-runner.rom e build/sand-runner.cmd
make build msx
make build trs80
```

| Alvo | Artefato |
| --- | --- |
| `msx` | `build/sand-runner.rom` (cartucho MSX1 16 KB) |
| `trs80` | `build/sand-runner.cmd` (CMD Model III) |

### Assets

```bash
make assets            # reencoda os dois art.txt via assetkit
make assets msx
make assets trs80
```

Os layouts de asset seguem `/usr/share/elara8/docs/assets.md`.

## Estrutura do Projeto

```
msx/                 # porta MSX1 (main.ela + assets)
trs80/               # porta Model III (main.ela + assets)
build/               # .rom / .cmd exportados (git-ignored)
.make/               # scripts de run / build / test / assets / clean
```

## Desenvolvimento

```bash
make help              # verbos e componentes
make run msx           # playtest interativo
make build             # exporta os dois alvos para build/
make test              # headless nos dois (FRAMES=600)
make assets            # regenera binários a partir de art.txt
make clean             # remove build/
```

## Licença

MIT — veja [LICENSE](LICENSE).
