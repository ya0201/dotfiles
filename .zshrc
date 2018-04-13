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
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

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

### Prompt ###
# basic prompt color setting
autoload -Uz colors
colors

# 一般ユーザ時
# tmp_prompt="%m:%c %{${fg[cyan]}%}%n$ "
tmp_prompt="maiMacBookPro:%c %{${fg[cyan]}%}me$ "
# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
fi
# prompt
PROMPT=$tmp_prompt


# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###
alias v=vim

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
