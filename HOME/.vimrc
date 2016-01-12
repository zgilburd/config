" Pathogen
call pathogen#infect()
call pathogen#helptags()

set ls=2            " allways show status line
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set softtabstop=4
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
filetype indent on
autocmd FileType yaml setlocal expandtab

set formatoptions+=w
set tw=80
nnoremap Q gqip

au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set smarttab
au BufRead,BufNewFile *.py,*.pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4
fu Select_c_style()
	if search('^\t', 'n', 150)
		set shiftwidth=8
		set noexpandtab
	el set shiftwidth=4
		set expandtab
	en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab


autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

set guioptions-=T " Remove toolbar
set guioptions-=r " Remove right scrollbar
set guioptions-=L " Remove left scrollbar

" let g:syntastic_python_checkers = ['flake8']
let g:powerline_pycmd = "py3"
