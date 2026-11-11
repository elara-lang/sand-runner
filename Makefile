MAKEFLAGS += --no-print-directory

.DEFAULT_GOAL := help

# Second word of `make <verb> <component>` (empty when omitted).
COMP := $(word 2,$(MAKECMDGOALS))

# Component tokens are no-op goals so `make run msx` does not fail.
.PHONY: help run build test assets clean msx trs80

msx trs80:
	@:

help: ## Show available targets
	@echo "sand-runner - Available targets"
	@echo ""
	@echo "Usage:  make <verb> [msx|trs80]"
	@echo ""
	@echo "Verbs:"
	@grep -hE '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*## "} {printf "  %-15s %s\n", $$1, $$2}'
	@echo ""
	@echo "Components:"
	@echo "  msx     MSX1 portable library (msx.*)"
	@echo "  trs80   TRS-80 Model III portable library (trs.*)"
	@echo ""
	@echo "Examples:"
	@echo "  make run msx"
	@echo "  make build              # both exports → build/"
	@echo "  make build trs80"
	@echo "  make test               # headless both (FRAMES=600)"
	@echo "  make assets msx"
	@echo ""
	@echo "Requires system elara8: /usr/bin/elara8, /usr/bin/assetkit, /usr/share/elara8"

run: ## Playtest (requires msx|trs80)
ifeq ($(COMP),)
	$(error run: specify a target — make run msx|trs80)
else ifeq ($(COMP),msx)
	@./.make/run.sh msx
else ifeq ($(COMP),trs80)
	@./.make/run.sh trs80
else
	$(error run: unknown target '$(COMP)'; use msx|trs80)
endif

build: ## Export .rom/.cmd to build/ (default: both)
ifeq ($(COMP),)
	@./.make/build.sh
else ifeq ($(COMP),msx)
	@./.make/build.sh msx
else ifeq ($(COMP),trs80)
	@./.make/build.sh trs80
else
	$(error build: unknown target '$(COMP)'; use msx|trs80 or omit for both)
endif

test: ## Headless playtest (default: both; FRAMES=600)
ifeq ($(COMP),)
	@./.make/test.sh
else ifeq ($(COMP),msx)
	@./.make/test.sh msx
else ifeq ($(COMP),trs80)
	@./.make/test.sh trs80
else
	$(error test: unknown target '$(COMP)'; use msx|trs80 or omit for both)
endif

assets: ## Re-encode art.txt via assetkit (default: both)
ifeq ($(COMP),)
	@./.make/assets.sh
else ifeq ($(COMP),msx)
	@./.make/assets.sh msx
else ifeq ($(COMP),trs80)
	@./.make/assets.sh trs80
else
	$(error assets: unknown target '$(COMP)'; use msx|trs80 or omit for both)
endif

clean: ## Remove build/ artifacts
	@./.make/clean.sh
