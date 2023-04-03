#!/bin/bash

ln -s ~/dotfiles/omzshrc ~/.omzshrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/rvmrc ~/.rvmrc
ln -s ~/dotfiles/gemrc ~/.gemrc
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/sshc ~/.ssh/config
ln -s ~/dotfiles/agignore ~/.agignore

if ! [ -f ~/.local/bin ]; then
  mkdir -p ~/.local/bin
fi

ln -s ~/dotfiles/start.rb ~/.local/bin/start
chmod +x ~/.local/bin/start

ln -s -f /opt/homebrew/bin/python3 ~/.local/bin/python
ln -s -f /opt/homebrew/bin/pip3 ~/.local/bin/pip
ln -s -f /opt/homebrew/bin/pydoc3 ~/.local/bin/pydoc > /dev/null

ln -s -f /opt/homebrew/opt/ruby/bin/ruby ~/.local/bin/ruby > /dev/null
ln -s -f /opt/homebrew/opt/ruby/bin/bundle ~/.local/bin/bundle > /dev/null
ln -s -f /opt/homebrew/opt/ruby/bin/bundler ~/.local/bin/bundler > /dev/null
ln -s -f /opt/homebrew/opt/ruby/bin/erb ~/.local/bin/erb > /dev/null
ln -s -f /opt/homebrew/opt/ruby/bin/irb ~/.local/bin/irb > /dev/null
ln -s -f /opt/homebrew/opt/ruby/bin/rake ~/.local/bin/rake > /dev/null
ln -s -f /opt/homebrew/opt/ruby/bin/rdoc ~/.local/bin/rdoc > /dev/null
echo "DONE!"
