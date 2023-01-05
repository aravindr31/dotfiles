#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
WHITE="\033[37m"
NORMAL="\033[0;39m"


printf "\n${WHITE}==============================================================================

                                 Setting up ${whoami}'s Linux Env!!!!!

==============================================================================${NORMAL}\n"


echo "This script require the linux password.Enter your Password"

read password

printf "\n${RED}NVM & Node \n"

eval "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash"
eval "nvm install --lts"
eval "nvm alias default node"

printf "\n${GREEN}Setting up bash \n"

 # font installtion pending

#  install and configure starship
eval "curl -sS https://starship.rs/install.sh | sh"
eval "cp ./config/starship.toml ~/.config/starship.toml"
# custom bashrc
eval "cp ./config/.bashrc ~/.bashrc"
# install ble.sh
eval "git clone --recursive https://github.com/akinomyoga/ble.sh.git"
eval "make -C ble.sh install PREFIX=~/.local"
eval "echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc"

# snapd 
printf "\n${YELLOW}Setting up snapd \n"

eval "sudo dnf install snapd"
eval "sudo systemctl snapd start"

# enableing snapd deamon
eval "sudo systemctl snapd enable"

# vscode
printf "\n${RED}Installing & Setting up Visual Studio Code \n"

eval "sudo snap install --classic code "
eval "cp -r ./config/vscode/settings.json ~/.config/Code/User/"

#sublime
printf "\n${MAGENTA}Installing & Setting up sublime text \n"
eval "cp -r ./config/sublime/* ~/.config/sublime-text/Packages/User/ 

eval "sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg"
eval "sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo"

eval "sudo dnf install sublime-text"

#spotify

printf "\n${GREEN}Installing up spotify \n"

eval "sudo snap install spotify"

# telegram
printf "\n${BLUE}Installing up telegram \n"

eval "sudo dnf install telegram"

# brave browser
printf "\n${RED}Installing up Brave Browser \n"

eval "sudo dnf install dnf-plugins-core"
eval "sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/"
eval "sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc"
eval "sudo dnf install brave-browser"

# gparted 
printf "\n${BLUE}Installing up gparted \n"

eval "sudo dnf install gparted"

# gnome-tweaks
printf "\n${WHITE}Installing up gnome-tweaks \n"

eval "sudo dnf install gnome-tweaks"

#authpass
printf "\n${YELLOW}Installing up Authpass \n"

eval "sudo snap install authpass"

# virtualbox
printf "\n${BLUE}Installing up VirtualBox \n"

eval "sudo dnf install virtualbox"

# gh
printf "\n${GREEN}Installing up GH \n"

eval "sudo dnf install gh"

#protonvpm-cli
printf "\n${MAGENTA}Installing up Proton VPN Service \n"

eval "curl -sS https://protonvpn.com/download/protonvpn-stable-release-1.0.1-1.noarch.rpm"
eval "sudo dnf ./protonvpn-stable-release-1.0.0-1.noarch.rpm"
eval "sudo dnf update"
eval "sudo dnf install protonvpn-cli"
eval "pip3 install --user dnspython>=1.16.0"

# vlc
printf "\n${YELLOW}Installing up VLC \n"

eval "sudo dnf install vlc"

#htop
printf "\n${GREEN}Installing up HTOP \n"

eval "sudo dnf install htop"
eval "sudo dnf install tlp"
eval "sudo tlp start"

eval "cp ./config/customTheme ~/.themes/customTheme"

eval "sudo cp /etc/default/grub /etc/defualt/grub.bak "
eval "sudo cp ./config/grub /etc/default/grub"

eval "sudo cp ./config/themes /usr/share/grub/themes"

eval "grub2-mkconfig -o /boot/grub2/grub.cfg"

eval "sudo snap install auto-cpufreq"
eval "sudo auto-cpufreq --live"
