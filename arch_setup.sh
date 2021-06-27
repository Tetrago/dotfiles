#!/bin/bash

echo -e "                     .__                        __                "
echo -e "_____ _______   ____ |  |__        ______ _____/  |_ __ ________  "
echo -e "\__  \\_  __ \_/ ___\|  |  \      /  ___// __ \   __\  |  \____ \ "
echo -e " / __ \|  | \/\  \___|   Y  \     \___ \\  ___/|  | |  |  /  |_> >"
echo -e "(____  /__|    \___  >___|  /____/____  >\___  >__| |____/|   __/ "
echo -e "     \/            \/     \/_____/    \/     \/           |__|    "
echo ""

# --- Script startup ------------------------------------------------------------------------------

COLOR_CYAN='\033[0;36m'
COLOR_NONE='\033[0m'

base_user=${SUDO_USER:-${USER}}
base_home=$(eval echo ~$base_user)

log_step ()
{
  echo -e "${COLOR_CYAN}$1${COLOR_NONE}"
}

as_base ()
{
  sudo -u $base_user $1
}

# --- Basic setup ---------------------------------------------------------------------------------

log_step "Running basic setup processes..."

sudo -n true
set -euo pipefail

# --- Base Packages -------------------------------------------------------------------------------

log_step "Installing base packages from pacman..."

pacman -S --noconfirm git curl

# --- Creating work directory ---------------------------------------------------------------------

log_step "Creating working directory for script..."

cd $base_home
rm -rf arch_setup
as_base "mkdir arch_setup"
cd arch_setup

as_base "git clone https://github.com/Tetrago/dotfiles.git"

# --- AUR -----------------------------------------------------------------------------------------

log_step "Installing AUR helper..."

if ! command -v yay &> /dev/null
then
  as_base "git clone https://aur.archlinux.org/yay.git"
  cd yay
  as_base "makepkg -si --noconfirm"
  cd ..
  rm -rf yay
else
  log_step "'yay' found, skipping..."
fi

log_step "Installing AUR packages..."

as_base "yay -S --noconfirm caffeine-ng neovim-symlinks pnmixer batterymon-clone"

# --- Installing all packages ---------------------------------------------------------------------

log_step "Installing all packages..."

pacman -S --noconfirm --needed xorg-server make cmake emacs xmonad xmonad-contrib xmobar fish picom nitrogen lightdm alacritty xterm dmenu dunst tldr man exa procs bat ripgrep fd fish neofetch trayer lxsession network-manager-applet

# --- Confirguring lightdm ------------------------------------------------------------------------

log_step "Configuring lightdm..."

systemctl enable lightdm
pacman -S --noconfirm --needed lightdm-webkit2-greeter lightdm-webkit-theme-litarvan
sed -i 's/greeter-session=.*/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sed -i 's/#greeter-session=.*/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sed -i 's/webkit_theme.*/webkit_theme=litarvan/g' /etc/lightdm/lightdm-webkit2-greeter.conf

# --- Replicating configuration ------------------------------------------------------------------

log_step "Replicating configuration..."

chsh -s /bin/fish $base_user
as_base "mkdir .xmonad"
as_base "mkdir -p .config/fish"
as_base "cp dotfiles/.xmobarrc $base_home/"
as_base "cp dotfiles/.xmonad/xmonad.hs $base_home/.xmonad/"
as_base "cp dotfiles/.config/fish/config.fish $base_home/.config/fish/"

# --- Installing SpaceVim -------------------------------------------------------------------------

log_step "Installiong SpaceVim..."

sudo -u $base_user curl -sLf https://spacevim.org/install.sh | sudo -u $base_user bash

# --- Installing Doom Emacs -----------------------------------------------------------------------

log_step "Installing Doom Emacs..."

as_base "git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d"
as_base "~/.emacs.d/bin/doom -y install"

init_el="${base_home}/.doom.d/init.el"

sed -i 's/;;vterm/vterm/' ${init_el}
sed -i 's/;;make/make/' ${init_el}
sed -i 's/;;cc/cc/' ${init_el}
sed -i 's/;;csharp/csharp/' ${init_el}
sed -i 's/;;json/json/' ${init_el}
sed -i 's/;;javascript/javascript/' ${init_el}
sed -i 's/;;lua/lua/' ${init_el}
sed -i 's/;;php/php/' ${init_el}
sed -i 's/;;python/python/' ${init_el}
sed -i 's/;;rust/rust/' ${init_el}
sed -i 's/;;yaml/yaml/' ${init_el}

as_base "~/.emacs.d/bin/doom -y sync"

# --- Finializing setup process -------------------------------------------------------------------

log_step "Finializing setup..."

cd ..
rm -rf arch_setup

# --- Done ----------------------------------------------------------------------------------------

log_step "arch_setup completed!"