#!/bin/bash
export CHROME_FLAGS=""
source /etc/profile
export GO_PATH="$HOME/go"
export PATH="$HOME/.local/pulse-wrappers:$GO_PATH/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export XCURSOR_PATH="$XCURSOR_PATH:$HOME/.local/share/icons:$HOME/.icons:$HOME/.icons/themes"
export GPG_TTY=$(tty)
export QT_QPA_PLATFORMTHEME=qt5ct
export MAKEFLAGS="-j$(nproc)"
export CXXFLAGS="-march=native"
