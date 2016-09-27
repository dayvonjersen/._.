call plug#begin('~/.plugged')
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'
" Plug 'fatih/vim-go'
Plug 'mdempsky/gocode', { 'rtp': 'nvim' }
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/gv.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'othree/html5.vim'
Plug 'othree/eregex.vim'
" Plug 'scrooloose/syntastic'
if has("unix")
    Plug 'shougo/deoplete.nvim'
    Plug 'zchee/deoplete-jedi'
else
    Plug 'shougo/neocomplete'
endif
call plug#end()

if has("unix")
    set guifont=ProFontWindows\ 9
endif

if has("win32")
    set guifont=mononoki:h10:cANSI
    set guifontwide=M+\ 1m:h12
endif

colorscheme up
set background=dark
let g:airline_theme="serene"
set statusline=%!airline#statusline(1}%{fugitive#statusline()}

set autoindent

set showmatch
set matchtime=0

set nocompatible
set nobackup
set nowritebackup
set noundofile
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch
set directory=.,$TEMP

set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set fileformat=unix
set fileformats=unix,dos

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set cmdheight=2

filetype on
filetype plugin on

set laststatus=2
set shortmess=aoOsAI

set modeline
syntax on
au BufNewFile,BufRead *.phpt set filetype=php

set foldmethod=manual
let g:php_folding=2
set foldlevelstart=20

set number
set linebreak

set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=e

set listchars=space:‧,trail:‧,tab:‣‣,extends:…,precedes:…,nbsp:•
nmap <leader>l :set list!<CR>

nnoremap <F6> :let @/ = ""<CR>

nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

nnoremap <F2> :e! ++enc=cp1252<CR>
nnoremap <F4> :e! ++enc=utf-8<CR>

map <F12> :set number!<CR>
map <F1> <Esc>
imap <F1> <Esc>
inoremap <F1> <Esc>
noremap <F1> <Esc>
inoremap <C-Space> <Esc>
noremap <C-Space> <Esc>
map <PageUp> <C-b>
map <PgDown> <C-f>

" Window Navigation
map <C-Left> <C-w>h
map <C-Down> <C-w>j
map <C-Up> <C-w>k
map <C-Right> <C-w>l

" Window Shens
" 'Fullscreen'
map <F11> <C-w>_<C-w>\|
" Move windows around
map <C-S-Left> <C-w>H
map <C-S-Down> <C-w>J
map <C-S-Up> <C-w>K
map <C-S-Right> <C-w>L

" Tab Navigation
map <C-Tab> gt
map <C-S-Tab> gT
map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt
map <A-0> :tablast<CR>
map <C-t> :tabnew 

command! -complete=shellcmd -nargs=+ Cmd call s:RunShellCommand(<q-args>, 0)
command! -complete=shellcmd -nargs=+ Cmd2 call s:RunShellCommand(<q-args>, 1)
function! s:RunShellCommand(cmdline, printout)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
"  if a:printout == 1
"    call setline(1, 'You entered:    ' . a:cmdline)
"    call setline(2, 'Expanded Form:  ' .expanded_cmdline)
"    call setline(3,substitute(getline(2),'.','=','g'))
"  endif
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  if a:printout == 0
    close
  endif
  1
endfunction

command -nargs=0 -range=% OrderedList <line1>,<line2>s/^\s*\zs/\=(line('.') - <line1>+1).'. '


" this is from vimrc_example.vim
map Q gq
inoremap <C-U> <C-G>u<C-U>
if has("mouse")
    set mouse=a
endif
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
if has("autocmd")
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
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" this is from mswin.vim
behave mswin
if 1
  let s:save_cpo = &cpoptions
endif
set cpo&vim
vnoremap <BS> d
vnoremap <C-X> "+x
vnoremap <S-Del> "+x
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
map <C-V> "+gP
map <S-Insert> "+gP
cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>
noremap <C-Q> <C-V>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
if !has("unix")
  set guioptions-=a
endif
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif
command! -complete=shellcmd -nargs=+ Cmd call s:RunShellCommand(<q-args>, 0)
command! -complete=shellcmd -nargs=+ Cmd2 call s:RunShellCommand(<q-args>, 1)
function! s:RunShellCommand(cmdline, printout)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  if a:printout == 0
    close
  endif
  1
endfunction

if has("unix")
    " nvim needs these
    set clipboard+=unnamedplus
    au FileChangedShell,InsertEnter,InsertLeave,FocusGained,BufEnter * :silent! !
    set autoread
endif

if has("win32")
    noremap <MiddleMouse> ""
    noremap! <MiddleMouse> <Esc>
    noremap <2-MiddleMouse> ""
    noremap! <2-MiddleMouse> <Esc>
    noremap <3-MiddleMouse> ""
    noremap! <3-MiddleMouse> <Esc>
    noremap <4-MiddleMouse> ""
    noremap! <4-MiddleMouse> <Esc>

    set diffexpr=MyDiff()
    function MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      let eq = ''
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          let cmd = '""' . $VIMRUNTIME . '\diff"'
          let eq = '"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
    if has('gui_running') && has('libcall')
        let g:_fullscr = 0
        function! FullScreen()
            if g:_fullscr == 0
                let g:_fullscr = 1
                set guioptions-=r
                call libcallnr('vimtweak.dll', 'EnableMaximize', 1)
            else
                let g:_fullscr = 0
                set guioptions+=r
                call libcallnr('vimtweak.dll', 'EnableMaximize', 0)
            endif
        endfunction

        " call ToggleSleek()
        map <F7> <Esc>:call libcallnr('vimtweak.dll', 'EnableCaption', 0)<CR>
        map <F8> <Esc>:call libcallnr('vimtweak.dll', 'EnableCaption', 1)<CR>
        map <F9> <Esc>:set guioptions-=m<CR>
        map <F10> <Esc>:set guioptions+=m<CR>

        map <C-Enter> <Esc>:call FullScreen()<CR>

        let g:MyVimLib = $VIMRUNTIME.'/gvimfullscreen.dll'
        let g:VimAlpha = 255
        function! SetAlpha(alpha)
            let g:VimAlpha = g:VimAlpha + a:alpha
            if g:VimAlpha < 180
                let g:VimAlpha = 180
            endif
            if g:VimAlpha > 255
                let g:VimAlpha = 255
            endif
            call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
        endfunction


        function! ToggleOpacity()
            if g:VimAlpha == 255
                call SetAlpha(-25)
            else
                call SetAlpha(255)
            endif
        endfunction

        "Shift+A - Toggle Opacity/Alpha
        nmap <s-a> <Esc>:call ToggleOpacity()<CR>
        "Shift+Y - Increase Opacity
        nmap <s-y> <Esc>:call SetAlpha(3)<CR>
        "Shift+T - Decrease Opacity
        nmap <s-t> <Esc>:call SetAlpha(-3)<CR>

        let g:VimTopMost = 0
        function! SwitchVimTopMostMode()
            if g:VimTopMost == 0
                let g:VimTopMost = 1
            else
                let g:VimTopMost = 0
            endif
            call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
        endfunction

        "Shift+R - Toggle Always-On-Top
        nmap <s-r> <Esc>:call SwitchVimTopMostMode()<CR>
    endif
endif


if has("unix")
    let g:deoplete#enable_at_startup = 1
else
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1

    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
endif
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
let g:go_fmt_command = "goimports"
