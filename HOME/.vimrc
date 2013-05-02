" Pathogen
call pathogen#infect()
call pathogen#helptags()

set ls=2            " allways show status line
set tabstop=2       " numbers of spaces of tab character
set shiftwidth=2    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set number          " show line numbers
set ignorecase      " ignore case when searching 
"set noignorecase   " don't ignore case
set title           " show title in console title bar
set ttyfast         " smoother changes
set nostartofline   " don't jump to first character when paging
set autoindent     " always set autoindenting on
set smartindent        " smart indent
set cindent            " cindent
syntax on
set t_Co=256
colorscheme Tomorrow-Night
"hi LineNR ctermfg=180 guifg=#d7af87
filetype on
autocmd FileType yaml setlocal expandtab

set formatoptions+=w
set tw=80
nnoremap Q gqip
