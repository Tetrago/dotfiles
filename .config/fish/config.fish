set fish_greeting
set -x EDITOR vim

alias ps="procs"
alias cat="bat"
alias ls="exa -1la --group-directories-first --color=always"
alias la="exa -1a --group-directories-first --color=always"
alias ll="exa -1l --group-directories-first --color=always"
alias mv="mv -i"
alias cp="cp -i"
alias unar="dtrx"
alias op="pcmanfm"
alias pak="paru -S --noconfirm --sudoloop"
alias yeet="paru -Rsn --noconfirm --sudoloop"
alias topgrade="paru -Syu --noconfirm --sudoloop"
alias dotfiles="git --git-dir=$HOME/dotfiles --work-tree=$HOME"

colorscript random

starship init fish | source
