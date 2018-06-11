source /etc/profile
source ~/.zshrc
# export ANT_HOME="/usr/local/bin/ant/"
# export PATH="$PATH:$ANT_HOME/bin"

export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"

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
eval "$(pyenv init -)"

# XDG Base Directory Specification
# used by nvim
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
