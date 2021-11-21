CURRENT_DIR = $(shell pwd)
ARCH := $(shell uname)

.PHONY: install _install zsh-plugins

install: _install zsh-plugins

_install:
ifeq ($(ARCH),Darwin)
	$(CURRENT_DIR)/scripts/dotfiles.zsh
	@echo
	$(CURRENT_DIR)/scripts/macos.zsh
	@echo
endif

zsh-plugins:
	$(CURRENT_DIR)/scripts/install-zsh-plugins.zsh
