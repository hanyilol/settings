set number
set background=light
if v:progname =~? "evim"
   finish
endif

set nocompatible
set backspace=indent,eol,start
if has("vms")
  set nobackup
else
  set backup
endif
set history=50
set ruler
set showcmd
set incsearch
map Q gq
inoremap <C-U> <C-G>u<C-U>
set mouse=a
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
if has("autocmd")
filetype plugin indent on
augroup vimrcEx
au!
autocmd FileType text setlocal textwidth=78
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
augroup END

else
  set autoindent
endif 
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
	\ | wincmd p | diffthis
endif

set shiftwidth=4
set expandtab
autocmd FileType make setlocal noexpandtab
set ignorecase
autocmd FileType text setlocal autoindent expandtab softtabstop=2 textwidth=76 spell spelllang=en_us
autocmd FileType help setlocal nospell
set backupdir^=~/.vim_backup
set dir^=~/.vim_backup//
set listchars=tab:▸\ ,eol:¬
set softtabstop=4
highlight Comment ctermfg=lightblue
set paste
