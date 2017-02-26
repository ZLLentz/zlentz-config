set nocompatible              " required
filetype off                  " required 

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""
" Plugin settings "
"""""""""""""""""""

" SimpylFold
let g:SimpylFold_docstring_preview=1

" Syntastic
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
highlight SyntasticErrorSign cterm=bold ctermfg=1 guifg=Red
highlight SyntasticWarningSign cterm=bold ctermfg=3 guifg=Brown

" NERDTree
let g:NERDTreeDirArrowExpandable = ">"
let g:NERDTreeDirArrowCollapsible= "/"
autocmd vimenter * NERDTree
autocmd vimenter * wincmd l
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" jedi-vim
autocmd FileType python setlocal completeopt-=preview

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"


""""""""""""""""""
" Other settings "
""""""""""""""""""

" Disable beep if enabled
set visualbell

" Line numbers
set number

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Colors
highlight Folded ctermbg=black
highlight SignColumn ctermbg=black
let python_highlight_all=1
"syntax on

" Python settings
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \     softtabstop=4
    \     shiftwidth=4
    \     textwidth=79
    \     expandtab
    \     autoindent
    \     fileformat=unix
    \     encoding=utf-8

"" Start new python files with boilerplate
"au BufNewFile *.py r /reg/neh/home/zlentz/projects/new_file_boilerplate.py
"au BufNewFile *.py 1d

" Bash, yaml, c, rc settings
au BufNewFile,BufRead *.c,*.c,*.cc,*.hh,*.sh,*.yaml,*.*rc
    \ set tabstop=2
    \     softtabstop=2
    \     shiftwidth=2
    \     expandtab
    \     autoindent

" Show bad whitespace in an obvious but not obnoxious color
highlight BadWhitespace ctermbg=darkgreen guibg=darkgreen
au BufNewFile,BufRead *.py,*.pyw,*.c,*.h,*.cc,*.hh,*.sh match BadWhitespace /\s\+$/
