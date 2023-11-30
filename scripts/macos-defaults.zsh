#!/usr/bin/env zsh
set -euo pipefail

# reduce motion
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1

# darkmode
# sudo defaults write /Library/Preferences/.GlobalPreferences AppleInterfaceTheme Dark

# Tap to click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# tabなどでMacのボタンのフォーカスを変えられるフルコントロールを設定
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# キーリピートの高速化
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# スペルの訂正を無効にする
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# タップしたときに、クリックとする
# defaults write -g com.apple.mouse.tapBehavior -int 1

# show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles YES
# Automatically hide or show the Dock
defaults write com.apple.dock autohide -bool true
# すべての拡張子を表示する
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# ネットワークフォルダに .DS_Storeを作らない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# USBメディアに .DS_Storeを作らない
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# 通知メッセージの表示時間（１秒）
defaults write com.apple.notificationcenterui bannerTime 1

# クラッシュ リポーターを無効にする
defaults write com.apple.CrashReporter DialogType none

# 先頭文字を自動で大文字化するのを無効
defaults write -g NSAutomaticCapitalizationEnabled -bool false

# 上記設定後は、Finder と Dock を再起動する
killall Finder
killall Dock

# メニューバーにバッテリーの残量をパーセント表示する YES/NO
defaults write com.apple.menuextra.battery ShowPercent YES

# メニューバーを再起動する
killall SystemUIServer
