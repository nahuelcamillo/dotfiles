# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
source /usr/share/nvm/init-nvm.sh

# Useful Commands

# Navigation
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias home="cd ~"

# Random Shortcuts
alias dw="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias pics="cd ~/Pictures"
alias nrd="npm run dev"
alias ns="npm start"
alias cl="clear"

# Work Commands
alias cheyenne="cd ~/Documents/Development/Cheyenne"
alias rabbitup="sudo systemctl start rabbitmq"
alias rabbitdown="sudo systemctl stop rabbitmq"

# Git Commands
alias g="git"
alias st="git status"
alias br="git branch"
alias ci="git commit"
alias co="git checkout"
alias gc="git clone"
# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
