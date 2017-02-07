Dotfiles
========

A collection of my config files for ZSH, Oh-My-Zsh, Vim, Tmux, and Powerline.  This has
been inspired by [Dr. Bunsen's Text Triumvirate](http://www.drbunsen.org/the-text-triumvirate/).

Dependencies
============

I use Homebrew to install: zsh, vim, git, tmux
I install Oh-My-Zsh from it's GitHub homepage

tmux might need reattach-to-user-namespace which can be installed via Homebrew (it allows us
to copy/paste inside tmux sessions in OSX).

hub - brew install hub - command line tool for GitHub
ghi - brew install ghi - command line tool to manage GitHub issues and pull requests

### Caps and R-ctrl key remapping

Linux: [xcape](https://github.com/alols/xcape)
Mac: Change Keyboard Modifier Keys, install [Karabiner](https://pqrs.org/osx/karabiner/) and change left control settings (after granting Karabiner accessibility options in Security preferences)

[source](http://www.economyofeffort.com/2014/08/11/beyond-ctrl-remap-make-that-caps-lock-key-useful/)

### Powerline

NOTE: I no longer use powerline

I use powerline which is tricky to install.  It also requires your terminal to support
patched fonts or fontconfig.
[Here's the full details](https://powerline.readthedocs.org/en/latest/installation.html).
Here's the gist:
You'll need PyPy (a JIT python compiler) [from the website](http://pypy.org/download.html#default-with-a-jit-compiler).
You'll need pip (a python package manager) [from the website](http://pip.readthedocs.org/en/latest/installing.html).
Then you'll be able to install powerline: `sudo pip install --user git+git://github.com/Lokaltog/powerline`.

Then you'll be able to install powerline: `sudo pip install powerline-status`.

NOTE: Using the user flag installs the powerline package into your user directory.  If you
want to install the package globally, you'll need to modify the vimrc and tmux.conf files
here with the correct global powerline.conf filepaths.

You'll need to install powerline fonts by cloning the fonts repo and running the
install.sh locally. [https://github.com/Lokaltog/powerline-fonts](https://github.com/Lokaltog/powerline-fonts).
Finally, set the terminal font to one of the powerline fonts.  If you're using iTerm, you only need to use
the powerline font as the Non-ASCII font.

Setup
=====

1. Clone this repository into your home directory: `git clone
git@github.com:jfeaver/dotfiles.git ~/`

2. Move or remove existing config files (if they exist):
  - ~/.atom/config.cson
  - ~/.zshrc
  - ~/.omzshrc
  - ~/.vimrc
  - ~/.tmux.conf
  - ~/.rvmrc
  - ~/.gemrc
  - ~/.gitignore\_global
  - ~/.ssh/config

3. Run `git config --global core.excludesfile ~/.gitignore_global` if you haven't already
4. Run `./setup.sh` (Creates symbolic links from the home directory to the dotfiles directory)
5. Change the zshrc theme to your own in `~/dotfiles/omzshrc`
6. Run `chmod +x /usr/local/bin/start`

