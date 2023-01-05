#snapd - If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export OPENSSL_DIR=/usr/bin/openssl-1.1


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

#ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="archcraft"
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
        git
        zsh-syntax-highlighting
        zsh-autosuggestions
        zsh-history-substring-search   
        you-should-use 
    )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
 export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
 export ARCHFLAGS="-arch x86_64"

eval "$(dircolors /home/davidb/.config/dircolors)"

# On-demand rehash
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

# omz
alias nv="nvim"
alias zshrc="nvim ~/.zshrc"
alias ohmyzsh="thunar ~/.oh-my-zsh"
alias bashrc="nvim ~/.bashrc"
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias awrc="nvim ~/.config/awesome/rc.lua"
alias bashrc="nvim ~/.bashrc"
alias cls="clear"
alias ls="lsd"
alias pac="sudo pacman"
alias upgrade="sudo pacman -Syu"
alias b="light -S"
alias bx="xrandr --output eDP1  --brightness"

alias shutdown="shutdown now"
alias restart="reboot"
#alias sleep="betterlockscreen -l &"
alias suspend="systemctl suspend"
#alias hibernate="betterlockscreen -l && sleep 0.5 && systemctl hibernate &"
#alias logout="pkill -KILL -u davidb"
alias logout="pkill -KILL awesome"

alias mountd="sudo mount -t ntfs-3g /dev/sda1 ~/Mountpoint/Data"
alias mountc="sudo mount -t ntfs-3g /dev/sdb5 ~/Mountpoint/C/"
alias drive="ranger /run/media/davidb"
alias umount="sudo umount"

alias gc="git clone"
alias ga="git add --all"
alias gp="git push"
alias gs="git status"
alias ghc="gh repo create"
alias ns="npm start"

alias dm="dmenu_run"
alias tkw="tmux kill-window"
alias tks="tmux kill-session"

alias ovpn="sudo openvpn"

alias w="nitrogen --set-zoom-fill --random ~/Media/Wallpapers"

alias rcsyn="rclone sync -P pcloud: ~/RClone"
alias resync="rclone bisync ~/RClone pcloud: --resync -v"
alias bisync="rclone bisync ~/RClone pcloud: -v"

alias top="btop --utf-force"
alias tmux="tmux -u"
alias tsm="transmission-remote"

#NVM configs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export SPACESHIP_CONFIG="$HOME/.config/spaceship/spaceship.zsh"
#source "$HOME/.cargo/env"

#Application Folder
export PATH=$PATH:/home/davidb/Applications/bin
export $(dbus-launch)

eval  "$(starship init zsh)"
