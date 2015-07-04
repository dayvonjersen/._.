set nocompatible
set nobackup
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch

map Q gq

inoremap <C-U> <C-G>u<C-U>

if has('mouse')
	set mouse=a
endif

if &t_Co > 2 || has('gui_running')
	syntax on
	set hlsearch
endif

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

  "set autoindent		" always set autoindenting on

endif " has("autocmd")

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set directory=.,$TEMP

colorscheme Revolution 
set guifont=Inconsolata\ 11
set guioptions-=T 

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

set laststatus=2
set shortmess=aoOsAI

behave mswin

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif

" ol
"command -nargs=0 -range=% OrderedList <line1>,<line2>s/^\s*\zs/\=(line('.') - <line1>+1).'. '

noremap <MiddleMouse> ""
noremap! <MiddleMouse> <Esc>
noremap <2-MiddleMouse> ""
noremap! <2-MiddleMouse> <Esc>
noremap <3-MiddleMouse> ""
noremap! <3-MiddleMouse> <Esc>
noremap <4-MiddleMouse> ""
noremap! <4-MiddleMouse> <Esc>

" Typing on a Thinkpad is hard.
map <F1> <Esc>
imap <F1> <Esc>
inoremap <F1> <Esc>
noremap <F1> <Esc>
inoremap <C-Space> <Esc>
noremap <C-Space> <Esc>

" XML formatter
function! DoFormatXML() range
	" Save the file type
	let l:origft = &ft

	" Clean the file type
	set ft=

	" Add fake initial tag (so we can process multiple top-level elements)
	exe ":let l:beforeFirstLine=" . a:firstline . "-1"
	if l:beforeFirstLine < 0
		let l:beforeFirstLine=0
	endif
	exe a:lastline . "put ='</PrettyXML>'"
	exe l:beforeFirstLine . "put ='<PrettyXML>'"
	exe ":let l:newLastLine=" . a:lastline . "+2"
	if l:newLastLine > line('$')
		let l:newLastLine=line('$')
	endif

	" Remove XML header
	exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"

	" Recalculate last line of the edited code
	let l:newLastLine=search('</PrettyXML>')

	" Execute external formatter
	exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"

	" Recalculate first and last lines of the edited code
	let l:newFirstLine=search('<PrettyXML>')
	let l:newLastLine=search('</PrettyXML>')
	
	" Get inner range
	let l:innerFirstLine=l:newFirstLine+1
	let l:innerLastLine=l:newLastLine-1

	" Remove extra unnecessary indentation
	exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"

	" Remove fake tag
	exe l:newLastLine . "d"
	exe l:newFirstLine . "d"

	" Put the cursor at the first line of the edited code
	exe ":" . l:newFirstLine

	" Restore the file type
	exe "set ft=" . l:origft
endfunction
command! -range=% FormatXML <line1>,<line2>call DoFormatXML()

nmap <silent> <leader>x :%FormatXML<CR>
vmap <silent> <leader>x :FormatXML<CR>

" Visual Mode Navigation
vmap <S-Left> h
vmap <S-Down> j
vmap <S-Up> k
vmap <S-Right> l
vmap <S-Home> 0
vmap <S-End> $
" These are broken for some reason
map <PageUp> <C-b>
map <PgDown> <C-f>
" Something remapped <Esc> asl;kjf
map <Esc> <Esc>
noremap <Esc> <Esc>
noremap! <Esc> <Esc>

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

" Folding
" Note: should probably move this to ftplugin...
syntax on
set foldmethod=syntax
let g:php_folding=2
set foldlevelstart=20

" Hipster cred
set number
set linebreak
map <F12> :set number!<CR>

" finally
set guioptions-=m

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
" maybe this might be helpful
" right now it's shit tho
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

vmap <silent> ;h :s?^\(\s*\)+ '\([^']\+\)',*\s*$?\1\2?g<CR>:let @/ = ""<CR>
vmap <silent> ;q :s?^\(\s*\)\(.*\)\s*$? \1 + '\2'?<CR>:let @/ = ""<CR>

" Clear last search
map <F9> :let @/ = ""<CR> 
