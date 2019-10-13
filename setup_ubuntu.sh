set -e

[[ -z $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME="$HOME/.config"

function check_is_installed() {
  which $@ >/dev/null 2>&1
fi

sudo apt install -y curl python3-pip zsh neovim peco
sudo pip3 install neovim xkeysnail

check_is_installed zsh && chsh -s $(which zsh)

# install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

nvim -c PlugInstall -c qa

# touchpad setting
sudo cp ./30-touchpad.conf /etc/X11/xorg.conf.d/

# editor config (in visudo and etc.) from nano to some config
# interactive setting
sudo update-alternatives --config editor

# daemonize xkeysnail
if check_is_installed xkeysnail; then
  sudo groupadd --system xkeysnail
  if [[ $(cat /etc/group | grep xkeysnail | wc -l) -ne 0 ]]; then
    # group successfully created

    # add current user to xkeysnail group
    sudo gpasswd -a $USER xkeysnail

    # enable user in xkeysnail group to run xkeysnail command with root priviledge, nopasswd
    echo "%xkeysnail ALL=(ALL) NOPASSWD: $(which xkeysnail)" | sudo EDITOR='tee -a' visudo

    # add xkeysnail user service, enable it and start it
    mkdir -p $XDG_CONFIG_HOME/systemd/user
    sudo tee $XDG_CONFIG_HOME/systemd/user/xkeysnail.service <<EOS
[Unit]
Description=My xkeysnail daemon
PartOf=graphical-session.target

[Service]
ExecStart=sudo $(which xkeysnail) $XDG_CONFIG_HOME/xkeysnail/config.py
ExecStop=/bin/kill \${MAINPID}
Restart=always
Type=simple
RemainAfterExit=yes

[Install]
WantedBy=default.target
EOS

    if [[ $(sudo systemctl --user list-unit-files --type=service | grep xkeysnail | wc -l) -eq 0 ]]; then
      echo 'Added xkeysnail group and to sudoers, but could not add service file to /etc/systemd/system.'
      false
    fi

    sudo systemctl --user enable xkeysnail
    sudo systemctl --user start xkeysnail
  else
    echo 'Could not add xkeysnail group.'
    false
  fi
fi


# japanese input setting
if which fcitx >/dev/null 2>&1; then
  sudo apt install -y fcitx-mozc
fi

set +e
