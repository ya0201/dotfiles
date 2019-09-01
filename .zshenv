source /etc/profile
# export ANT_HOME="/usr/local/bin/ant/"
# export PATH="$PATH:$ANT_HOME/bin"

# homebrew
# if [ -x "`which brew 2>/dev/null`" ]; then
which brew >/dev/null 2>&1
if [ $? -eq 0 ]; then
  export PATH="$PATH:$(brew --prefix)/bin:$(brew --prefix)/sbin"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


## Go env
# if [ -x "`which go 2>/dev/null`" ]; then
which go >/dev/null 2>&1
if [ $? -eq 0 ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOPATH/bin
  export PATH=$PATH:/usr/local/opt/go/libexec/bin
fi

## pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    # export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

## rust env
export CARGO_ROOT="${HOME}/.cargo"
if [ -d "${CARGO_ROOT}" ]; then
  export PATH=${CARGO_ROOT}/bin:$PATH
fi

# XDG Base Directory Specification and file-hierarchy(7)
if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

# personal binaries
if [[ -d "${HOME}/.local/bin" ]]; then
  export PATH=${HOME}/.local/bin:$PATH
fi

# memo dir
# assumed to be used by memo (memo tool by golang)
if [ -z "$MEMODIR" ]; then
  export MEMODIR="${HOME}/GoogleDrive/memo"
fi

# for newer clang
# export PATH="/usr/local/opt/llvm/bin:$PATH"

# zplug
export ZPLUG_HOME="${HOME}/.zplug"
