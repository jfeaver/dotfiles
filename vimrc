""""""""""""""""""  VUNDLE """""""""""""""""""""""""""""""
" This must be first, because it changes other options as a side effect.
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" Fuzzy File Finder
" Plugin 'ctrlpvim/ctrlp.vim'

" Syntax highlighting
Plugin 'elixir-lang/vim-elixir'
" Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'leafgarland/typescript-vim'
Plugin 'rust-lang/rust.vim'

" Other
Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'tpope/vim-rhubarb' " View file on GitHub plugin for Fugitive
Plugin 'Quramy/tsuquyomi' " typescript completions
Plugin 'vim-utils/vim-ruby-fold' " Ruby code folding
Plugin 'xolox/vim-lua-ftplugin' " Lua
Plugin 'xolox/vim-misc' " Lua dependency
Plugin 'neoclide/coc.nvim'

" 2 dependencies for vim-snipmate
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" " Community contributed snippets
" Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" System vimrc located in:
" /usr/share/vim/vimrc
"
" Filetype defaults set in:
" /usr/share/vim/vim73/filetype.vim

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup  " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif
set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

if has('mouse_sgr')
  set ttymouse=sgr
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to N characters.
  autocmd FileType text setlocal textwidth=120

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" Nathan's additions (syntax highlighting)
autocmd! BufRead,BufNewFile *.haml setfiletype haml
autocmd BufNewFile,BufRead *.spec setfiletype=ruby
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=handlebars
autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby
autocmd BufNewFile,BufRead *.xlsx.axlsx set ft=ruby
autocmd BufNewFile,BufRead *.lua set ft=lua

set cf  " Enable error files & error jumping.
set autowrite  " Writes on make/shell commands
set nu!  " Line numbers on
set nowrap  " Line wrapping off
autocmd BufNewFile,BufRead *.md set wrap linebreak
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set t_Co=256

"" Formatting
set ts=2
set copyindent
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set smarttab
set expandtab
set relativenumber

autocmd Filetype elm setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype lua setlocal ts=4 sw=4 sts=0 expandtab

"" Visual
set showmatch   " Show matching brackets.
set mat=5       " Bracket blinking.
set list
" Show trailing space as ~
set lcs=tab:..,trail:~,extends:>,precedes:<
set laststatus=2  " Always show status line.
" Highlight colors so that they don't obfuscate text
hi Search cterm=NONE ctermfg=grey ctermbg=blue

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Newlines without entering insert mode
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>

" Source project specific vim configs
if filereadable(".vimrc.custom")
  so .vimrc.custom
endif

if !exists(":UpdateHashSyntax")
  command UpdateHashSyntax :%s/:\(\w\+\) =>/\1:/g
endif

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" elm-vim
" let g:elm_format_autosave = 1 " auto format on save
