Dotfiles
========

A collection of my config files for ZSH, Oh-My-Zsh, Vim, Tmux, and Powerline.  This has
been inspired by [Dr. Bunsen's Text Triumvirate](http://www.drbunsen.org/the-text-triumvirate/).

Dependencies
============

I use Homebrew to install: zsh, vim, git, tmux
I install Oh-My-Zsh from it's GitHub homepage

tmux uses reattach-to-user-namespace which can be installed via Homebrew (it allows us
to copy/paste inside tmux sessions in OSX).

I use powerline which is tricky to install.  It also requires your terminal to support
patched fonts or fontconfig.
[Here's the full details](https://powerline.readthedocs.org/en/latest/installation.html).
Here's the gist:
You'll need PyPy (a JIT python compiler) [from the website](http://pypy.org/download.html#default-with-a-jit-compiler).
You'll need pip (a python package manager) [from the website](http://pip.readthedocs.org/en/latest/installing.html).
Then you'll be able to install powerline: `sudo pip install --user git+git://github.com/Lokaltog/powerline`.

NOTE: Using the user flag installs the powerline package into your user directory.  If you
want to install the package globally, you'll need to modify the vimrc and tmux.conf files
here with the correct global powerline.conf filepaths.

You'll need to install powerline fonts by cloning the fonts repo and running the
install.sh locally. [https://github.com/Lokaltog/powerline-fonts](https://github.com/Lokaltog/powerline-fonts).
Finally, set the terminal font to one of the powerline fonts.  If you're using iTerm, you only need to use
the powerline font as the Non-ASCII font.

Setup
=====

1. Clone this repository to your home directory: `git clone
git@github.com:jfeaver/dotfiles.git ~/`

2. Move or remove existing config files (if they exist):
  - ~/.zshrc
  - ~/.omzshrc
  - ~/.vimrc
  - ~/.tmux.conf
  - ~/.gemrc

2. Create symbolic links to dotfile config files. I.E. `ln -s ~/dotfiles/zshrc ~/.zshrc`
