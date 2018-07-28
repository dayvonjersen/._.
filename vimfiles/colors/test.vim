" VIM colorscheme generated from a Visual Studio .vstheme with XSLT
" Y'all cowards don't even smoke crack
"
"*NOTE* This won't actually work at the moment because none of the names map to
" the correct ones for VIM
		
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "Dark (1)"

hi CursorColumn guifg=NONE guibg=#3399FF gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Keyword guifg=#569CD6 guibg=#000000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Comment guifg=#57A64A guibg=#000000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi String guifg=#D69D85 guibg=#000000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Number guifg=#B5CEA8 guibg=#000000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#DCDCDC guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
