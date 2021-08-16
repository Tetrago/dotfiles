set fish_greeting
set -x EDITOR vim

alias mv="mv -i"
alias cp="cp -i"
alias dotfiles="git --git-dir=$HOME/dotfiles --work-tree=$HOME"

if type -q procs
  alias ps="procs"
end

if type -q bat
  alias cat="bat --paging=never"
end

if type -q exa
  alias ls="exa -la --group-directories-first --color=always"
  alias la="exa -1a --group-directories-first --color=always"
  alias ll="exa -l --group-directories-first --color=always"
end

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
else if type -q emerge
  alias pak="emerge"
  alias yeet="emerge --deselect"
  alias topgrade="emerge --deep @world"
end

if type -q neofetch
  neofetch
end

if type -q starship
  starship init fish | source
else
  echo "Skipping 'starship'..."
end
