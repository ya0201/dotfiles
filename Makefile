CURRENT_DIR = $(shell pwd)

.PHONY: pwd
pwd:
	@echo $(CURRENT_DIR)

.PHONY: install-zsh-plugins
install-zsh-plugins:
	@. $(CURRENT_DIR)/.zshenv
