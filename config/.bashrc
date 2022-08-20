# .bashrc

#ble.sh setup

#[[ $- == *i* ]] && source ~/.config/ble.sh --noattach

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=


#GREEN=$(tput setaf 051)
#PS1="\[$GREEN\]\e[1;51m[\u@\h \W]> \e[0m"

# startship prompt
eval "$(starship init bash)"

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

#alias
alias bashrc="nano ~/.bashrc"
alias starconfig="nano ~/.config/starship.toml"
alias cls="clear"
alias update="sudo dnf update"
alias upgrade="sudo dnf upgrade"
alias add="sudo dnf install"
alias del="sudo dnf remove"
alias ghc="gh repo create"
alias ghd="git clone" 
alias ga="git add --all"
alias gstat="git status"
alias gc="git commit"
alias gp="git push"
alias ni="npm install"
alias start="npm start"
alias dev="npm run dev"
alias build="npm run build"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#endpoint for ble.sh
#[[ ${BLE_VERSION-} ]] && ble-attach
