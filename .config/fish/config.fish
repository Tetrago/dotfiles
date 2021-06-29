set fish_greeting
set -x EDITOR vim

alias ps="procs"
alias cat="bat"
alias la="exa --1la --group-directories-first --color=always"
alias mv="mv -i"
alias cp="cp -i"
alias tar="dtrx"
alias dotfiles="git --git-dir=$HOME/dotfiles --work-tree=$HOME"

colorscript random | tail -n +2

starship init fish | source