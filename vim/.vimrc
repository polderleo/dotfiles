set nocompatible          " get rid of Vi compatibility mode. SET FIRST!
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
set number                " show line numbers
set laststatus=2          " last window always has a statusline
filetype indent on        " activates indenting for files
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set smarttab              " use tabs at the start of a line, spaces elsewhere
set nowrap                " don't wrap text
set relativenumber        " show relative line numbers
set belloff=all           " disable bell sound
set clipboard=unnamedplus " use system clipboard for yank and paste
set mouse=a               " enable mouse support
set cursorline            " highlight current line
set cursorcolumn          " highlight current column
set colorcolumn=80        " highlight column 80
set numberwidth=1         " set number width to 1
set signcolumn=yes        " show sign column
set scrolloff=5           " keep 5 lines above and below the cursor
set sidescrolloff=5       " keep 5 characters to the left and right of the cursor
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set showmatch             " show matching brackets
set matchtime=2           " show matching brackets for 2 seconds