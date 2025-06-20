# ------------------------------
# General Settings
# ------------------------------


# ビープ音を鳴らさないようにする
setopt no_beep
# nonomatch
setopt nonomatch
# ctrl+s, ctrl+qを開放する
setopt no_flow_control
# どっかからコピペしてきたため$ $ lsなどとなっても実行できるようにする
function $ { $@ }

disable r

### Complement ###  
# basic complement setting
autoload -U compinit
# https://htr3n.github.io/2018/07/faster-zsh/
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

### History ###
HISTSIZE=10000
SAVEHIST=10000
# 履歴ファイルの保存先
HISTFILE=${HOME}/.zsh_history
# 余分な空白は詰めて記録
setopt hist_reduce_blanks  
# 古いコマンドと同じものは無視 
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# multi tabs share history
setopt share_history

# バックグラウンドジョブの優先度を下げない
setopt nobgnice
# !bなどをコマンド履歴に展開しない
setopt nobanghist

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# Extend dirstacksize
DIRSTACKSIZE=100
setopt pushdsilent

# ------------------------------
# Look And Feel Settings
# ------------------------------

### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# ファイル名等の補完において大文字/小文字の区別をつけない
# ref: https://ozuma.hatenablog.jp/entry/20141219/1418915137
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### initialize brew-installed zsh
### if brew installed, ${_BREW_PREFIX} is set in .zshenv
if [[ -n $_BREW_PREFIX ]]; then
  FPATH=${_BREW_PREFIX}/share/zsh/functions:$FPATH
  FPATH=${_BREW_PREFIX}/share/zsh/site-functions:$FPATH
fi

## initialize starship
eval "$(starship init zsh)"

# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###
alias v=vim
alias vizr='vim ~/.zshrc'
alias vp='vim-grep-fzf'
ls --color >/dev/null 2>&1 && alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias g=git
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gsh='git switch'
alias gsc='git switch -c'
alias gr='git restore'
alias gd='git diff'
alias glog='git log'
alias gpull='git pull'
alias gpul='git pull'
alias gpush='git push'
alias gg='ghq get'
alias gl='gcloud'
alias tf='terraform'
alias snk='ssh -o StrictHostKeyChecking=no'
alias gg='ghq get'
alias ggrep='git grep'
alias nl='nerdctl'
if command -v ya0201ctl &>/dev/null; then
  alias yl='ya0201ctl'
fi

function yaml2json() {
  if which ruby >/dev/null 2>&1; then
    ruby -ryaml -rjson -e 'puts JSON.dump(YAML.load(ARGF))'
  else
    python3 -c 'import sys, yaml, json; print(json.dumps(yaml.safe_load(sys.stdin)))'
  fi
}

function json2yaml() {
  if which ruby >/dev/null 2>&1; then
    ruby -ryaml -rjson -e 'puts YAML.dump(JSON.load(ARGF))' | tail -n +2
  else
    python3 -c "import sys, yaml, json; print(yaml.dump(json.load(sys.stdin)))"
  fi
}

function remove_kube_metadata() {
  yaml2json | jq '. | del(.status) | del(.metadata.managedFields) | del(.metadata.annotations["kubectl.kubernetes.io/last-applied-configuration"]) | del(.metadata.creationTimestamp) | del(.metadata.generation) | del(.metadata.resourceVersion) | del(.metadata.uid)' | json2yaml
}

function remove_kube_metadata_with_status() {
  yaml2json | jq '. | del(.metadata.managedFields) | del(.metadata.annotations["kubectl.kubernetes.io/last-applied-configuration"]) | del(.metadata.creationTimestamp) | del(.metadata.generation) | del(.metadata.resourceVersion) | del(.metadata.uid)' | json2yaml
}

function clm() {
  local clmnum="$1"
  cut -f " " -d "$clmnum"
}

function gpsuo() {
  local branch=$(sed -e 's;^.*\[\(.*\)\].*$;\1;' <<< "${vcs_info_msg_0_}")
  if [[ -n "$branch" ]]; then
    git push --set-upstream origin "$branch"
  else
    echo "gpsuo error: '$branch' is empty"
    return 1
  fi
}
alias gcompute='gcloud compute'
alias gci='gcloud compute instances'
alias gssh='gcompute ssh'
alias dv='dirs -v'
alias kl='kubectl'
alias kd='kubectl describe'
alias cbrun='docker run --rm -v $(pwd):/src -w /src compilerbook'
alias cbsh='docker run --rm -it -v $(pwd):/src -w /src compilerbook'

if which go >/dev/null 2>&1; then
  function goinit() {
    local dirname="$1"
    mkdir "$dirname"
    cd "$dirname"
    go mod init "$dirname"
    touch main.go
    cat <<EOS > main.go
package main

import (
	"fmt"
)

func main() {
	fmt.Println("hello, world")
}
EOS

  }
fi

## pyenv
if [[ -d "${PYENV_ROOT}" ]]; then
  _py_funcs=('pyenv' 'python' 'python3')
  for f in ${_py_funcs[@]}; do
    eval "function $f () { unset -f $f; eval \"\$(pyenv init -)\"; $f \"\$@\" }"
  done
fi

if [[ $(uname) == 'Darwin' ]]; then
  # option + arrows
  bindkey "^[^[[D" backward-word
  bindkey "^[^[[C" forward-word
fi

# if nvim installed, then replace 'vim' command to 'nvim'
which nvim >/dev/null 2>&1
if [ $? -eq 0 ]; then
  alias vim='nvim'
fi


# cdコマンド実行後、lsを実行する
function cd() {
  builtin cd $@ && ls && MY_DIRSTACK=();
}

# alcで英単語を検索してlynxで見たりするためのコマンド
function alc() {
  if [ $# != 0 ]; then
    lynx -dump -nonumbers "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +33
  else
    lynx -dump -nonumbers "http://www.alc.co.jp/"
  fi
}

# Oxford Learner's Dicで英単語を検索してlynxで見たりする
function eed() {
  if [ $# != 0 ]; then
    baseURL="https://www.oxfordlearnersdictionaries.com/definition/english/"
    local ORGIFS=$IFS
    IFS='-'; local QUERY1="$*"; IFS=$ORGIFS
    IFS='+'; local QUERY2="$*"; IFS=$ORGIFS
    lynx -dump -nonumbers "${baseURL}${QUERY1}?q=${QUERY2}" | less +25
  else
    lynx -dump -nonumbers $baseURL
  fi
}

# Urban Dictionaryで英単語を検索してlynxで見たりする
function urd() {
  if [ $# != 0 ]; then
    baseURL="https://www.urbandictionary.com/define.php?term="
    local ORGIFS=$IFS
    IFS='+'; local QUERY="$*"; IFS=$ORGIFS
    lynx -dump -nonumbers "${baseURL}${QUERY}" | less +40
  else
    lynx -dump -nonumbers $baseURL
  fi
}

# lynx+lessでテキストサイトを簡単に見る
function vurl() {
  if [ $# != 0 ]; then
    lynx -dump -nonumbers "$*" | less
  else
    lynx -dump -nonumbers "http://google.com" | less
  fi
}

function check_is_installed() {
  which $@ >/dev/null 2>&1
}

# tmux
local ticc=$XDG_CACHE_HOME/.tpm_install_confirmation_cache
if [[ ! -f $XDG_DATA_HOME/tmux/plugins/tpm/tpm && ! -f $ticc ]]; then
  printf "Install TPM? [y/N]: "
  if read -q; then
    echo; git clone https://github.com/tmux-plugins/tpm "${XDG_DATA_HOME}/tmux/plugins/tpm"; echo "[IMPORTANT] Make sure to run 'prefix I' for installing tmux plugins"
  else
    echo; touch $ticc
  fi
fi

# load zsh plugins
eval "$(sheldon source)"

# load asdf if exists
if [[ -f $HOME/.asdf/asdf.sh ]]; then
  source $HOME/.asdf/asdf.sh
  export FPATH=${HOME}/.asdf/completions:${FPATH}
fi

# z wo fzf tte bakusoku cd
# ref: https://qiita.com/maxmellon/items/23325c22581e9187639e
check_is_installed z fzf
if [[ $? -eq 0 ]]; then
  # search function definition
  function fzf-z-search {
    local res=$(z | sort -rn | cut -c 12- | fzf --no-sort --reverse --exact)
    if [ -n "$res" ]; then
      BUFFER+="cd $res"
      zle accept-line
    else
      return 1
    fi
  }

  # map search function to Ctrl-f
  zle -N fzf-z-search
  bindkey '^f' fzf-z-search
else
  function plz-install-fzf-z {
    echo "Please install fzf and z"
    return 1
  }
  zle -N plz-install-fzf-z
  bindkey '^f' plz-install-fzf-z
fi

# vim with fuzzy finder
check_is_installed vim fzf
if [ $? -eq 0 ]; then
  function fifp() {
    find . -type f 2>/dev/null -not \( -path '*/.git/*' -o -path '*/node_modules/*' -o -path '*/.next/*' -o -path '*/target/debug/*' -o -path '*/target/release/*' -o -path '*/.DS_Store' \) | fzf --no-sort --reverse --exact
    return $?
  }

  function vim-fzf-edit {
    local selected="$(fifp)"
    if [ -n "$selected" ]; then
      BUFFER+="vim \"$selected\""
      zle accept-line
    else
      return 1
    fi
  }

  # map vim-fzf-edit to Ctrl-v
  zle -N vim-fzf-edit
  bindkey '^v' vim-fzf-edit
else
  function plz-install-fzf-vim {
    echo "Please install fzf and vim"
    return 1
  }
  zle -N plz-install-fzf-vim
  bindkey '^v' plz-install-fzf-vim
fi

# https://postd.cc/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# ディレクトリ内ファイルをgrepで全文検索してfzfで絞り込み、該当行をvimで開く
vim-grep-fzf () {
  if [[ $# -lt 2 ]]; then
    echo "Usage: vim-grep-fzf [word] [dir1] [dir2] ..."
    return 1
  fi

  if check_is_installed 'rg'; then
    local selected_line=$(rg -in --hidden -- "$@" 2>/dev/null | fzf --no-sort --reverse --exact | awk -F: '{print "-c", $2, $1}')
  else
    local selected_line=$(grep -inr -- "$@" | fzf --no-sort --reverse --exact | awk -F: '{print "-c", $2, $1}')
  fi
  if [[ -n $selected_line ]]; then
    vim ${=selected_line}
  fi
}

# for moving around the directory stack by ctrl+j/ctrl+u
MY_DIRSTACK=()
go-back-in-dir-history () {
  if [[ $#BUFFER -eq 0 ]]; then
    local curr_dir="$(pwd)"
    popd >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
      MY_DIRSTACK=($curr_dir $MY_DIRSTACK)
      zle accept-line
    fi
  fi
  return 0
}
go-forward-in-dir-history () {
  if [[ $#BUFFER -eq 0 ]]; then
    [[ $#MY_DIRSTACK -eq 0 ]] && return 0

    pushd $MY_DIRSTACK[1] && shift MY_DIRSTACK
    zle accept-line
  fi
  return 0
}
zle -N go-back-in-dir-history
bindkey '^u' go-back-in-dir-history
zle -N go-forward-in-dir-history
bindkey '^j' go-forward-in-dir-history

# history incremental search
check_is_installed fzf
if [[ $? -eq 0 ]]; then
  check_is_installed tac
  if [[ $? -eq 0 ]]; then
    # centos/ubuntu
    history-fzf-search () {
      BUFFER=$(history -n 1 | tac | awk '!a[$0]++' | fzf --no-sort --reverse --wrap --exact)
      CURSOR=$#BUFFER
      zle reset-prompt
    }
  else
    # freebsd family
    history-fzf-search () {
      BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | fzf --no-sort --reverse --wrap --exact)
      CURSOR=$#BUFFER
      zle reset-prompt
    }
  fi
  zle -N history-fzf-search
  bindkey '^R' history-fzf-search
fi

# change directory to ghq repository
if which ghq &> /dev/null; then
  ! which fzf &>/dev/null && return
  function fzf-ghq () {
      local selected_dir=$(ghq list --full-path | fzf --no-sort --reverse --exact)
      if [ -n "$selected_dir" ]; then
          BUFFER="cd ${selected_dir}"
          zle accept-line
      fi
      zle clear-screen
  }

  zle -N fzf-ghq
  bindkey '^G' fzf-ghq
fi

# snippet to read credential from stdin without logging plain text of credential to .zsh_history
function read-cred() {
  local credname="$1"

  echo -n "Please input ${credname}: "
  read -s "$credname"
  export "$credname"
  echo ''
}

function continue?() {
  echo -n "Continue? [Y/n] "
  read input
  echo

  if [[ $input == "n" ]]; then
    return 1
  else
    return 0
  fi
}

# load dotfiles for work
DOTFILES_WORKING_DIR="${HOME}/dotfiles-working"
if [[ -d ${DOTFILES_WORKING_DIR} ]]; then
  source ${DOTFILES_WORKING_DIR}/.zsh
fi


# for profiling
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi
