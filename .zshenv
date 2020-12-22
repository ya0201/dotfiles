source /etc/profile
# export ANT_HOME="/usr/local/bin/ant/"
# export PATH="$PATH:$ANT_HOME/bin"

# homebrew
## for apple sillicon macos
[[ -d /opt/homebrew ]] && export PATH="$PATH:/opt/homebrew/bin"

which brew >/dev/null 2>&1
if [ $? -eq 0 ]; then
  export PATH="$PATH:$(brew --prefix)/bin:$(brew --prefix)/sbin"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


## Go env
# if install go with tarballs, then place it to /usr/local/go
which go >/dev/null 2>&1
[[ $? -eq 1 && -d /usr/local/go ]] && export PATH=$PATH:/usr/local/go/bin

which go >/dev/null 2>&1
if [ $? -eq 0 ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOPATH/bin
  [[ -d /usr/local/opt/go ]] && export PATH=$PATH:/usr/local/opt/go/libexec/bin
fi

## pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
fi

## rust env
export CARGO_ROOT="${HOME}/.cargo"
if [ -d "${CARGO_ROOT}" ]; then
  export PATH=${CARGO_ROOT}/bin:$PATH
fi

# XDG Base Directory Specification and file-hierarchy(7)
if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
  mkdir -p $XDG_CONFIG_HOME
fi
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
  mkdir -p $XDG_DATA_HOME
fi
if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
  mkdir -p $XDG_CACHE_HOME
fi

# personal binaries
export PATH=${HOME}/.local/bin:$PATH
mkdir -p ${HOME}/.local/bin

# memo dir
# assumed to be used by memo (memo tool by golang)
if [ -z "$MEMODIR" ]; then
  export MEMODIR="${HOME}/GoogleDrive/memo"
fi

# TIL dir
if [ -z "$TILDIR" ]; then
  export TILDIR="${HOME}/til"
fi


# for newer clang
# export PATH="/usr/local/opt/llvm/bin:$PATH"

# zplug
export ZPLUG_HOME="${HOME}/.zplug"
