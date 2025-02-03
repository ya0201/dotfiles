CURRENT_DIR = $(shell pwd)
ARCH := $(shell uname)

.PHONY: install

install:
ifeq ($(ARCH),Darwin)
	$(CURRENT_DIR)/scripts/macos.zsh
	@echo
endif
