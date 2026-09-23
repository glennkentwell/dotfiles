#!/bin/zsh

# sets MacOS defaults for convenience and sanity
# https://macos-defaults.com

# Fn key opens the Emoji & Symbols viewer
defaults write com.apple.HIToolbox AppleFnUsageType -int "2"
# F1-F12 act as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
# Wait 25 ticks before key repeat kicks in
defaults write NSGlobalDomain InitialKeyRepeat -int 25
# Key repeat rate (lower is faster)
defaults write NSGlobalDomain KeyRepeat -int 2
# Keep Dock always visible; restart Dock to apply
defaults write com.apple.dock "autohide" -bool "false" && killall Dock
# Dock icon size
defaults write com.apple.dock "tilesize" -int "29" && killall Dock
# Dock icon size while magnified
defaults write com.apple.dock "largesize" -int "86" && killall Dock
# Dock shows only running apps, not pinned ones
defaults write com.apple.dock "static-only" -bool "true" && killall Dock
# Hide recently used apps from the Dock
defaults write com.apple.dock "show-recents" -bool "false" && killall Dock
# Magnify Dock icons on hover
defaults write com.apple.dock "magnification" -bool "true" && killall Dock
# Disable natural (swipe) scrolling
defaults write -g com.apple.swipescrolldirection -bool NO



