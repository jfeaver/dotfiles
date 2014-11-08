### HOMEBREW
export PATH=/usr/local/bin:$PATH

### OH-MY-ZSHRC
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

if [ -f ~/.dotfiles/omzshrc ]; then
      . ~/.dotfiles/omzshrc
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

### RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

### GIT
# Add git uprades to PATH
export PATH=/usr/local/git/bin:/usr/local/sbin:$PATH

### NPM
# Add npm packages to the path
export PATH=$PATH:/usr/local/share/npm/bin

### HEROKU TOOLBELT
export PATH="/usr/local/heroku/bin:$PATH"

### ALIASES
if [ -f ~/.dotfiles/aliases ]; then
      . ~/.dotfiles/aliases
fi

### PROMPT
autoload -U colors && colors

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "[${ref#refs/heads/}] "
}
local branch='$(parse_git_branch)'

PS1="%{$fg[green]%}${branch}%{$reset_color%}`whoami`:%{$fg[blue]%}%~%{$reset_color%}$ "
setopt promptsubst

### VIM-LIKE ZSH
export EDITOR="vim"
bindkey -v

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

