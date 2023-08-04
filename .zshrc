# Use powerline
USE_POWERLINE="true"

[[ -r ~/.antidote ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
autoload -Uz compinit && compinit
antidote load

# Useful Commands

# Navigation
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias home="cd ~"

#Replacements
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

alias cp="cp -iv"
#             │└─ list copied files
#             └─ prompt before overwriting an existing file

alias mkdir="mkdir -pv"
#                   │└─ list cranuseated directories
#                   └─ create intermediate directories

alias mv="mv -iv"
#             │└─ list moved files
#             └─ prompt before overwriting an existing file

alias rm="rm -rf --"

alias ls="lsd"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# Random Shortcuts
alias dw="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias pics="cd ~/Pictures"
alias nrd="npm run dev"
alias ns="npm start"
alias cl="clear"
alias ip='curl -X GET "https://httpbin.org/ip" -H "accept: application/json"'
alias resetant='antidote update'


# Work Commands
alias p="cd ~/Documents/Projects/"
alias cheyenne="cd ~/Documents/Projects/Cheyenne"
alias rabbitup="sudo systemctl start rabbitmq"
alias rabbitdown="sudo systemctl stop rabbitmq"
alias vpnl="sudo openvpn ./Documents/VPNs/Lanus/pfsense-UDP4-1194-ncamillo-config.ovpn"
alias kvpnl="sudo pkill openvpn"

# Git Commands
alias g="git"
alias st="git status"
alias br="git branch"
alias ci="git commit"
alias co="git checkout"
alias gc="git clone"
alias gpl="git pull"
# Dotfiles
alias cfg='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/tmux
  zgen load spaceship-prompt/spaceship-prompt spaceship
  zgen load lukechilds/zsh-nvm

  # generate the init script from plugins above
  zgen save
fi

