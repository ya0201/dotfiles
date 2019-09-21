sudo apt install -y curl python3-pip zsh neovim peco
sudo pip3 install neovim xkeysnail

which zsh >/dev/null 2>&1 && chsh -s $(which zsh)

# install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

nvim -c PlugInstall -c qa

# touchpad setting
sudo cp ./30-touchpad.conf /etc/X11/xorg.conf.d/

# japanese input setting
if which fcitx >/dev/null 2>&1; then
  sudo apt install -y fcitx-mozc
fi
