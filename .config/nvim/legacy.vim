" C++ helpers

" switch between hpp and cpp
au BufEnter,BufNew *.cpp nnoremap <silent> ;p :e %<.hpp<CR>
au BufEnter,BufNew *.hpp nnoremap <silent> ;p :e %<.cpp<CR>

au BufEnter,BufNew *.cpp nnoremap <silent> ;vp :leftabove vs %<.hpp<CR>
au BufEnter,BufNew *.hpp nnoremap <silent> ;vp :rightbelow vs %<.cpp<CR>

au BufEnter,BufNew *.cpp nnoremap <silent> ;xp :leftabove split %<.hpp<CR>
au BufEnter,BufNew *.hpp nnoremap <silent> ;xp :rightbelow split %<.cpp<CR>

" surround with std::optional
nnoremap <silent> ;cso :execute 's/\(' . expand('<cWORD>') . '\)/std::optional<\1>'<CR>:noh<CR>

" faster updates!
set updatetime=50

" no hidden buffers
set hidden&

" automatically read on change
set autoread

" auto-pairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

" ;t is trim
nnoremap ;t <silent> :Trim<CR>

" easy search
nnoremap ;s :s/

" easy search/replace with current visual selection
xnoremap ;s y:%s/<C-r>"//g<Left><Left>

" easy search/replace on current line with visual selection
xnoremap ;ls y:.s/<C-r>"//g<Left><Left>

" ;w is save
noremap <silent> ;w :update<CR>

";f formats in normal mode
noremap <silent> ;f gg=G``:w<CR>

" language-specific formatters
au FileType cpp set formatprg=clang-format | set equalprg=clang-format

let g:lion_squeeze_spaces = 1

" no folds, ever
set foldlevelstart=99

" rainbow parens
let g:rainbow_active = 1

" rust config
let g:rustfmt_autosave = 1

set nocompatible
let c_no_curly_error=1

" Get syntax files from config folder
set runtimepath+=~/.config/nvim/syntax

" Use ripgrep as grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Colorscheme
set termguicolors
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox
hi LspCxxHlGroupMemberVariable guifg=#83a598

" alt-a as esc-a for select
nmap <esc>a <a-a>

" Disable C-z from job-controlling neovim
nnoremap <c-z> <nop>

" Remap C-c to <esc>
nmap <c-c> <esc>
imap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>

" Map insert mode CTRL-{hjkl} to arrows
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" same in normal mode
nmap <C-h> <Left>
nmap <C-j> <Down>
nmap <C-k> <Up>
nmap <C-l> <Right>

" Syntax highlighting
syntax on

" Position in code
set number
set ruler

" Don't make noise
set visualbell

" default file encoding
set encoding=utf-8

" Line wrap
set wrap

" Function to set tab width to n spaces
function! SetTab(n)
  let &tabstop=a:n
  let &shiftwidth=a:n
  let &softtabstop=a:n
  set expandtab
  set autoindent
  set smartindent
endfunction

command! -nargs=1 SetTab call SetTab(<f-args>)

set noexpandtab
set autoindent
set smartindent

" Function to trim extra whitespace in whole file
function! Trim()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

command! -nargs=0 Trim call Trim()

set laststatus=2

" Highlight search results
set hlsearch
set incsearch

set t_Co=256

" Binary files -> xxd
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" colorcolumn 80 when opening C/C++
autocmd BufRead,BufNewFile *.c setlocal colorcolumn=80
autocmd BufRead,BufNewFile *.h setlocal colorcolumn=80
autocmd BufRead,BufNewFile *.cpp setlocal colorcolumn=80
autocmd BufRead,BufNewFile *.hpp setlocal colorcolumn=80
autocmd BufRead,BufNewFile *.c SetTab 2
autocmd BufRead,BufNewFile *.h SetTab 2
autocmd BufRead,BufNewFile *.cpp SetTab 2
autocmd BufRead,BufNewFile *.hpp SetTab 2

" C/C++ indent options: fix extra indentation on function continuation
set cino=(0,W4

" colorcolumn 80, tab width 4 for shaders
autocmd BufRead,BufNewFile *.sc setlocal colorcolumn=80 | SetTab 4

" Mouse support
set mouse=a

" Map F8 to Tagbar
nmap <F8> :TagbarToggle<CR>

" disable backup files
set nobackup
set nowritebackup

set shortmess+=c

set signcolumn=yes

au FileType text set colorcolumn=80

" show syntax group of symbol under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
