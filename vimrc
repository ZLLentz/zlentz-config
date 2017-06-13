set nocompatible              " required for Vundle
filetype off                  " required for Vundle

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugin manager, do not delete
Plugin 'VundleVim/Vundle.vim'

" All plugins here
Plugin 'ervandew/supertab' " Autocomplete with tabs
Plugin 'scrooloose/nerdtree' " Vim filetree browser
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'scrooloose/syntastic' " General syntax checker
Plugin 'tmhedberg/SimpylFold' " Python code-folding
Plugin 'vim-scripts/indentpython.vim' " Python autoindent

" All Plugins must be added before the following line
call vundle#end()            " required for Vundle
filetype plugin indent on    " required for Vundle

"""""""""""""""""""
" Plugin settings "
"""""""""""""""""""

" supertab
" Start at top of the list
let g:SuperTabDefaultCompletionType = "<c-n>"

" NERDTree
" Compatibility symbols for bad unicode
let g:NERDTreeDirArrowExpandable = ">"
let g:NERDTreeDirArrowCollapsible= "/"
" Shortcut to open NERDTree
nnoremap <F2> :NERDTree<CR>
" Close NERDTree if no main buffer exists
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" powerline
set laststatus=2
let g:powerline_config_overrides = {'ext': {'vim': {'top_theme': 'ascii'}}}

" Syntastic
" Disable syntastic text at bottom
let g:syntastic_auto_loc_list = 0
" Do not check on quit
let g:syntastic_check_on_wq = 0
" Only use flake8
let g:syntastic_python_checkers = ['flake8']
" Change error/warning sign colors to be less obnoxious
highlight SyntasticErrorSign cterm=bold ctermfg=1 guifg=Red
highlight SyntasticWarningSign cterm=bold ctermfg=3 guifg=Brown
" Make error collumn background less obnoxious
highlight SignColumn ctermbg=black

" SimpylFold
" Show preview of folded docstrings
let g:SimpylFold_docstring_preview=1


""""""""""""""""""
" Other settings "
""""""""""""""""""

" Disable beep if enabled
set noerrorbells visualbell t_vb=

" Line numbers
set number
set relativenumber

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
" Make folding less obnoxious
highlight Folded ctermbg=black
" Syntax highlighting
let python_highlight_all=1
syntax on

" Python settings
au FileType python
    \ set tabstop=4
    \     softtabstop=4
    \     shiftwidth=4
    \     textwidth=79
    \     expandtab
    \     autoindent
    \     fileformat=unix
    \     encoding=utf-8

"" Start new python files with boilerplate
au BufNewFile *.py 0r ~/.vim/skeleton.py

" General settings for shell/vim scripts, c++, etc.
au FileType sh,vim,cpp,yaml
    \ set tabstop=2
    \     softtabstop=2
    \     shiftwidth=2
    \     expandtab
    \     autoindent

" Show bad whitespace in an obvious but not obnoxious color
highlight BadWhitespace ctermbg=darkgreen guibg=darkgreen
au BufNewFile,BufRead *.py,*.pyw,*.c,*.h,*.cc,*.hh,*.sh match BadWhitespace /\s\+$/
