source /etc/profile
source ~/.zshrc
# export ANT_HOME="/usr/local/bin/ant/"
# export PATH="$PATH:$ANT_HOME/bin"

# homebrew
if [ -x "`which brew`" ]; then
  export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


## Go env
if [ -x "`which go`" ]; then
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

# XDG Base Directory Specification
# used by nvim
if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi
