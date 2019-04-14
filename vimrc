" Disable beep if enabled
set noerrorbells visualbell t_vb=

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

" Remap tab to autocomplete
nnoremap <tab> <C-N>

" Colors
" Make folding less obnoxious
highlight Folded ctermbg=black
" Syntax highlighting
let python_highlight_all=1
syntax on
" Diff recoloring to overwrite syntax highlighting
highlight DiffAdd ctermfg=black
highlight DiffChange ctermfg=black
highlight DiffText ctermfg=black

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

" General settings for shell/vim scripts, c++, etc.
au FileType sh,vim,cpp,yaml
    \ set tabstop=2
    \     softtabstop=2
    \     shiftwidth=2
    \     expandtab
    \     autoindent

" Show bad whitespace in an obvious but not obnoxious color
highlight pythonSpaceError ctermbg=darkgreen guibg=darkgreen
highlight BadWhitespace ctermbg=darkgreen guibg=darkgreen
au BufNewFile,BufRead *.py,*.pyw,*.c,*.h,*.cc,*.hh,*.sh match BadWhitespace /\s\+$/
