#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
POWERLEVEL9K_MODE='awesome-fontconfig'

DEFAULT_USER="samclement"
source ~/.zsh-nvm/zsh-nvm.plugin.zsh

POWERLEVEL9K_BATTERY_ICON=$'\u26A1'
POWERLEVEL9K_BATTERY_VERBOSE=false
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery nvm)
#POWERLEVEL9K_STATUS_VERBOSE=false
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
#POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
#POWERLEVEL9K_SHOW_CHANGESET=true

#export PATH=/usr/bin:$PATH
export NVM_DIR="/Users/samclement/.nvm"
source "$NVM_DIR/nvm.sh"

#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#export PATH=$PATH:~/.nvm/versions/node/`nvm version node`/bin
