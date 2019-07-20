# ------------------------------
# General Settings
# ------------------------------


# ビープ音を鳴らさないようにする
setopt no_beep

### Complement ###  
# basic complement setting
autoload -U compinit
compinit

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

# バックグラウンドジョブの優先度を下げない
setopt nobgnice
# !bなどをコマンド履歴に展開しない
setopt nobanghist

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

### Prompt ###
# basic prompt color setting
autoload -Uz colors
colors

# 一般ユーザ時
top_left="%{${fg[green]}%}[%M:%~]"
bottom_left="%{${fg[cyan]}%}%n $ %{${reset_color}%}"
# tmp_prompt="%{${fg[cyan]}%}[%n@%m] $ %{${reset_color}%}"
# tmp_prompt="%m:%c %{${fg[cyan]}%}%n$ "
# tmp_prompt="maiMacBookPro:%c %{${fg[cyan]}%}me$ "
# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  bottom_left="%B%U${bottom_left}%u%b"
fi
# prompt
PROMPT="$top_left
$bottom_left"

# right-prompt shows git information
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'


# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###
alias v=vim
alias vizr='vim ~/.zshrc'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias g=git
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gch='git checkout'
alias gd='git diff'
alias gpush='git push'
alias gpull='git pull'
alias glog='git log'
alias gcompute='gcloud compute'
alias gci='gcloud compute instances'
alias gssh='gcompute ssh'

# if nvim installed, then replace 'vim' command to 'nvim'
which nvim >/dev/null 2>&1
if [ $? -eq 0 ]; then
  alias vim='nvim'
fi


# cdコマンド実行後、lsを実行する
function cd() {
 builtin cd $@ && ls;
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
function fip() {
  command-peco 'find .'
  return $?
}

# z wo peco tte bakusoku cd
# ref: https://qiita.com/maxmellon/items/23325c22581e9187639e
check_is_installed brew
if [ $? -eq 0 ]; then
  local z_dot_sh_path=$(brew --prefix)/etc/profile.d/z.sh
  [ ! -f $z_dot_sh_path ] && return 0

  # load z
  . $z_dot_sh_path

  # search function definition
  function peco-z-search {
    check_is_installed peco z
    if [ $? -ne 0 ]; then
      echo "Please install peco and z"
      return 1
    fi
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
fi

# vim with aimai search
check_is_installed vim peco
if [ $? -eq 0 ]; then
  function vim-peco-edit {
    local selected=$(fip)
    # [ -n "$selected" ] && vim $selected || echo "vim-peco-edit: No files selected.";
    if [ -n "$selected" ]; then
      vim $selected
    else
      echo "vim-peco-edit: No files selected."
      return 1
    fi
  }

  # map vim-peco-edit to Ctrl-v
  zle -N vim-peco-edit
  bindkey '^v' vim-peco-edit
fi
