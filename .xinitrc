#!/usr/bin/env bash

export PATH=$PATH:$HOME/.dmenu/build/bin:$HOME/.slstatus/build/bin:$HOME/.dwm
export AUTOSTART=$HOME/.config/tetrago/autostart.sh
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=qt5ct

exec $HOME/.dwm/build/bin/dwm
