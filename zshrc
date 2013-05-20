
### OH-MY-ZSHRC
if [ -f ~/.dotfiles/omzshrc ]; then
      . ~/.dotfiles/omzshrc
fi

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

