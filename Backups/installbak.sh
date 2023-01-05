#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
WHITE="\033[37m"
NORMAL="\033[0;39m"


printf "\n${WHITE}==============================================================================

                                 Setting up ${whoami}'s Desktop Environment!!!!!

==============================================================================${NORMAL}\n"


echo "This script require the linux password.Enter your Password"

read password

eval "sudo dnf update"

printf "\n${RED}Installing Node JS\n"

eval "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
eval "nvm install node --lts"
eval "nvm alias default node"

#Install ZSH
printf "\n${GREEN}Installing ZSH SHELL..\n"
eval "sudo apt install zsh"

# Install Oh My Zsh
printf "\n${BLUE}Installing Oh My Zsh...${NORMAL}\n"
eval "sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'"

printf "${YELLOW}Copying ZSH config into ~/.zshrc...${NORMAL}\n"
eval "cp ./zshrc ~/.zshrc"

#Install Devolopment Environment

echo "Install Visual Studio code"

eval ("wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg")
eval ("sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/")
eval ("sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'")
eval ("rm -f packages.microsoft.gpg")

#update the package cache and install the package

eval ("sudo apt install apt-transport-https")
eval ("sudo apt update")
eval ("sudo apt install code")

echo "Install Sublime Text"

eval ("sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common")
eval ("curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -")
eval ("sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"")

eval("sudo apt install sublime-text")



