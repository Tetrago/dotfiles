set fish_greeting
set -x EDITOR vim

alias ps="procs"
alias cat="bat"
alias ls="exa -1la --group-directories-first --color=always"
alias la="exa -1a --group-directories-first --color=always"
alias ll="exa -1l --group-directories-first --color=always"
alias mv="mv -i"
alias cp="cp -i"
alias dotfiles="git --git-dir=$HOME/dotfiles --work-tree=$HOME"

if type -q pcmanfm
  alias op="pcmanfm"
end

if type -q paru
  alias pak="paru -S --noconfirm --sudoloop"
  alias yeet="paru -Rsn --noconfirm --sudoloop"
  alias topgrade="paru -Syu --noconfirm --sudoloop"
else if type -q pacman
  alias pak="pacman -S --noconfirm"
  alias yeet="pacman -Rsn --noconfirm"
  alias topgrade="pacman -Syu --noconfirm"
end

neofetch

starship init fish | source
