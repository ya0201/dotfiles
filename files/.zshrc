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

### Prompt ###
setopt prompt_subst
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz colors
colors

# 一般ユーザ時
top_left='%F{green}[%M:%~]%f'
bottom_left="%F{cyan}%n $ %f"
# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  bottom_left="%B%U${bottom_left}%u%b"
fi

# qwer-ps1
## initialize
QWER_PS1_DIR=${QWER_PS1_DIR:-${HOME}/.qwer-ps1}
[[ ! -d ${QWER_PS1_DIR} ]] && git clone https://github.com/ya0201/qwer-ps1 ${HOME}/.qwer-ps1
if ! which qp1 &>/dev/null; then
  source ${QWER_PS1_DIR}/qwer-ps1.zsh
fi
eval "$(qwer-ps1 init)"

## qwer-ps1 plugins
if ! qwer-ps1 plugin is-installed suspended-vims; then
  qp1 p a suspended-vims https://github.com/ya0201/qwer-ps1-suspended-vims
fi
if ! qwer-ps1 plugin is-installed oscloud; then
  qp1 p a oscloud https://github.com/ya0201/qwer-ps1-oscloud
fi
if ! qwer-ps1 plugin is-installed gitinfo; then
  qp1 p a gitinfo https://github.com/ya0201/qwer-ps1-gitinfo
fi
top_left=${top_left}'$(qp1 -b "()" -c green s suspended-vims)'
if qwer-ps1 plugin is-installed rse; then
  top_left=${top_left}'$(qwer-ps1 -b "" -c white show-current rse)'
fi

# prompt
PROMPT="${top_left}
${bottom_left}"

# right-prompt shows git information
RPROMPT='$(qp1 -b "" s gitinfo)'


# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###
alias v=vim
alias vizr='vim ~/.zshrc'
alias vp='vim-grep-peco'
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
alias gpush='git push'
alias gg='ghq get'
alias gl='gcloud'
alias tf='terraform'
alias snk='ssh -o StrictHostKeyChecking=no'

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

# vimrでmemodir内のmdをnote的に編集したい
function check_memodir_set() {
  if [ -z "$MEMODIR" ]; then
    echo 'Error: $MEMODIR is not set.'
    return 1
  else
    return 0
  fi
}
function check_is_installed() {
  which $@ >/dev/null 2>&1
}

function note() {
  check_is_installed vimr
  if [ $? -eq 1 ]; then
    return
  fi
  check_memodir_set()
  if [ $? -eq 1 ]; then
    return
  fi

  if [ $# -eq 0 ]; then
    vimr --cwd $MEMODIR
  else
    echo "Error: Invalid argument (no argument is required)"
  fi
}
function noten() {
  check_is_installed vimr
  if [ $? -eq 1 ]; then
    return
  fi
  check_memodir_set()
  if [ $? -eq 1 ]; then
    return
  fi

  if [ $# -eq 1 ]; then
    filename=$MEMODIR/$(date "+%Y-%m-%d")-note-$1.md
    if [ ! -f $filename ];then
      touch $filename
      echo -e "# note-$1\n\n" >> $filename
    else
      # nop
    fi

    vimr $filename --cwd $MEMODIR
  else
    echo "Error: Invalid argument (only one note title is required)"
  fi
}
function notee() {
  check_is_installed vimr peco
  if [ $? -eq 1 ]; then
    return
  fi
  check_memodir_set()
  if [ $? -eq 1 ]; then
    return
  fi

  if [ $# -eq 0 ]; then
    selected_file=$(ls $MEMODIR/*.md | peco --query="note ")

    if [ -z "$selected_file" ]; then
      echo "notee: No files selected"
      return
    fi
    vimr $selected_file --cwd $MEMODIR
  else
    echo "Error: Invalid argument (no argument is required)"
  fi
}
function noteea() {
  check_is_installed vimr peco
  # check_vimr_installed()
  if [ $? -eq 1 ]; then
    return
  fi
  check_memodir_set()
  if [ $? -eq 1 ]; then
    return
  fi

  if [ $# -eq 0 ]; then
    selected_file=$(find $MEMODIR | grep .md | sed -e "s;$MEMODIR/;;g" | peco --query="note ")

    if [ -z "$selected_file" ]; then
      echo "noteea: No files selected"
      return
    fi
    vimr $selected_file --cwd $MEMODIR
  else
    echo "Error: Invalid argument (no argument is required)"
  fi
}

function command-peco() {
  check_is_installed peco
  if [ $? -eq 1 ]; then
    return $?
  fi

  eval $@ | peco
}

function lsp() {
  command-peco ls
  return $?
}
function lap() {
  command-peco 'ls -a'
  return $?
}
function llap() {
  command-peco 'ls -al'
  return $?
}
function fifp() {
  command-peco 'find . -type f 2>/dev/null | grep -v "./.git/"'
  return $?
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
ZPLUG_REPOS=${ZPLUG_HOME}/repos
if [[ -f $ZPLUG_REPOS/rupa/z/z.sh ]]; then
  # load z
  source $ZPLUG_REPOS/rupa/z/z.sh
fi
if [[ -d $ZPLUG_REPOS/zsh-users/zsh-completions/src ]]; then
  export FPATH=${ZPLUG_REPOS}/zsh-users/zsh-completions/src:${FPATH}
fi
function defer_loading_zsh_plugins() {
  if [[ -f $ZPLUG_REPOS/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    # load zsh-syntax-highlighting
    source $ZPLUG_REPOS/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
}

# load asdf if exists
if [[ -f $HOME/.asdf/asdf.sh ]]; then
  source $HOME/.asdf/asdf.sh
  export FPATH=${HOME}/.asdf/completions:${FPATH}
fi

# z wo peco tte bakusoku cd
# ref: https://qiita.com/maxmellon/items/23325c22581e9187639e
check_is_installed z peco
if [[ $? -eq 0 ]]; then
  # search function definition
  function peco-z-search {
    local res=$(z | sort -rn | cut -c 12- | peco)
    if [ -n "$res" ]; then
      BUFFER+="cd $res"
      zle accept-line
    else
      return 1
    fi
  }

  # map search function to Ctrl-f
  zle -N peco-z-search
  bindkey '^f' peco-z-search
else
  function plz-install-peco-z {
    echo "Please install peco and z"
    return 1
  }
  zle -N plz-install-peco-z
  bindkey '^f' plz-install-peco-z
fi

# vim with aimai search
check_is_installed vim peco
if [ $? -eq 0 ]; then
  function vim-peco-edit {
    local selected=$(fifp)
    if [ -n "$selected" ]; then
      BUFFER+="vim $selected"
      zle accept-line
    else
      return 1
    fi
  }

  # map vim-peco-edit to Ctrl-v
  zle -N vim-peco-edit
  bindkey '^v' vim-peco-edit
else
  function plz-install-peco-vim {
    echo "Please install peco and vim"
    return 1
  }
  zle -N plz-install-peco-vim
  bindkey '^v' plz-install-peco-vim
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

# ディレクトリ内ファイルをgrepで全文検索してpecoで絞り込み、該当行をvimで開く
vim-grep-peco () {
  if [[ $# -lt 2 ]]; then
    echo "Usage: vim-grep-peco [word] [dir1] [dir2] ..."
    return 1
  fi

  local selected_line=$(grep -inr -- "$@" | peco | awk -F: '{print "-c", $2, $1}')
  if [[ -n $selected_line ]]; then
    vim ${=selected_line}
  fi
}

# MEMODIRとTILDIR用
vigmt () {
  if [[ $# -ne 1 ]]; then
    echo "Usage: vigmt [word]"
    return 1
  fi

  vim-grep-peco $1 $MEMODIR $TILDIR
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
check_is_installed peco
if [[ $? -eq 0 ]]; then
  check_is_installed tac
  if [[ $? -eq 0 ]]; then
    # centos/ubuntu
    history-peco-search () {
      BUFFER=$(history -n 1 | tac | awk '!a[$0]++' | peco)
      CURSOR=$#BUFFER
      zle reset-prompt
    }
  else
    # freebsd family
    history-peco-search () {
      BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
      CURSOR=$#BUFFER
      zle reset-prompt
    }
  fi
  zle -N history-peco-search
  bindkey '^R' history-peco-search
fi

# change directory to ghq repository
if which ghq &> /dev/null; then
  ! which peco &>/dev/null && return
  function peco-ghq () {
      local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
      if [ -n "$selected_dir" ]; then
          BUFFER="cd ${selected_dir}"
          zle accept-line
      fi
      zle clear-screen
  }

  zle -N peco-ghq
  bindkey '^G' peco-ghq
fi

# snippet to read credential from stdin without logging plain text of credential to .zsh_history
function read-cred() {
  local credname="$1"

  echo -n "Please input ${credname}: "
  read -s "$credname"
  export "$credname"
  echo ''
}

# load dotfiles for work
DOTFILES_WORKING_DIR="${HOME}/dotfiles-working"
if [[ -d ${DOTFILES_WORKING_DIR} ]]; then
  source ${DOTFILES_WORKING_DIR}/.zsh
fi

# defer loading of zsh plugins
defer_loading_zsh_plugins

# for profiling
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi
