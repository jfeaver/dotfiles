### OH-MY-ZSHRC
# Path to your oh-my-zsh installation.

if [ -e ~/.omzshrc ]; then
  . ~/.omzshrc
fi

### RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

### NPM
# Add npm packages to the path
export PATH=$PATH:/usr/local/share/npm/bin

### Powerline
# Make sure powerline is found
if [ -d "$HOME/Library/Python/2.7/bin" ]; then
  PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

### HEROKU TOOLBELT
export PATH="/usr/local/heroku/bin:$PATH"

### ALIASES
if [ -f ~/dotfiles/aliases ]; then
  . ~/dotfiles/aliases
fi

### PROMPT
# autoload -U colors && colors

# function parse_git_branch {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "[${ref#refs/heads/}] "
# }
# local branch='$(parse_git_branch)'
#
# PS1="%{$fg[green]%}${branch}%{$reset_color%}`whoami`:%{$fg[blue]%}%~%{$reset_color%}$ "
# setopt promptsubst

### VIM-LIKE ZSH
export EDITOR="vim"
bindkey -v

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Auto change directory (don't need to type `cd`)
setopt AUTO_CD

# Use caps lock as a ctrl key and escape if tapped by itself
# Use ctrl keys as escaped if tapped by themselves
if [ -x /usr/bin/xcape ]; then
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
fi
