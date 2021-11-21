CURRENT_DIR = $(shell pwd)
ARCH := $(shell uname)

.PHONY: install _install zsh-plugins

install: _install

_install:
ifeq ($(ARCH),Darwin)
	$(CURRENT_DIR)/scripts/dotfiles.zsh
	$(CURRENT_DIR)/scripts/macos.zsh
endif

zsh-plugins:
	@. $(CURRENT_DIR)/files/.zshenv
	@$(CURRENT_DIR)/scripts/install-zsh-plugins.zsh 'install'
