set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('$HOME/.config/nvim/dein')
	call dein#begin('$HOME/.config/nvim/dein')
	call dein#add('$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

	" A file finder to unite interfaces asynchronously.
	call dein#add('Shougo/denite.nvim')

	" Asynchronous linting of text.
	call dein#add('w0rp/ale')

	" Time measurement when editing files.
	call dein#add('wakatime/vim-wakatime')

	" Automatically add the ending 'operator' in languages which use e.g.
	" 'end', 'endfunction', 'fi', etc.
	call dein#add('tpope/vim-endwise')

	" Automatically detect what indent to use on a file.
	call dein#add('tpope/vim-sleuth')

	" Surrounding text with more text.
	call dein#add('tpope/vim-surround')

	" TOML support for vim.
	call dein#add('cespare/vim-toml', { 'on_ft': 'toml' })

	" Live Markdown preview powered by Rust.
	call dein#add('euclio/vim-markdown-composer', { 'on_ft': 'markdown', 'build': 'cargo build --release', 'merged': 0 })

	" Markdown language support.
	call dein#add('plasticboy/vim-markdown', { 'on_ft': 'markdown' })

	" Markdown Table of Contents
	call dein#add('mzlogin/vim-markdown-toc', { 'on_ft': 'markdown' })

	" Change colour of parentheses and brackets of any kind alternating per
	" occurrence; forms what looks like a rainbow.
	call dein#add('kien/rainbow_parentheses.vim')

	" File explorer for vim.
	call dein#add('scrooloose/nerdtree')

	" A light powerline/statusline.
	call dein#add('itchyny/lightline.vim')

	" Support for sxhkd configurations.
	call dein#add('kovetskiy/sxhkd-vim')

	" Fuzzy file finder integration into vim.
	call dein#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })

	" VSCode plugin interface for vim.
	call dein#add('neoclide/coc.nvim', { 'rev': 'release' })

	" EditorConfig support
	call dein#add('editorconfig/editorconfig-vim')

	" LaTeX
	call dein#add('xuhdev/vim-latex-live-preview')

	" Colour themes
"	call dein#add('yassinebridi/vim-purpura') " For vim theme
"	call dein#add('Rigellute/shades-of-purple.vim') " For lightline
	call dein#add('nlknguyen/papercolor-theme')

	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable

" Verify that all plugins are installed upon every launch.
if dein#check_install()
	call dein#install()
end

" Have a coloured column at 80.
set colorcolumn=80

" Line numbers on the side.
set number relativenumber

" Hide a buffer with unsaved modifications instead of dropping them when
" closing the buffer to work somewhere else.
set hidden

set wildmenu

" Highlight the entire line the cursor is on.
set cursorline

" Show a building command in the lower right of the screen.
" Slow connections or terminals should not have this enabled.
set showcmd

" When typing searches, show the matches as it's being typed in. This is nice
" in case the wanted view is seen while typing out the search.
set incsearch

" Highlight all the previous search matches.
" <Leader>h clears this.
set hlsearch

" Override the ignorecase option if the search includes uppercase characters.
set smartcase

set backspace=indent,eol,start

" Options for the default statusline.
set noruler
set noshowmode

" Makes certain commands not move to the start of the line.
set nostartofline

" Use a dialog when certain commands have to be confirmed.
set confirm

" Mouse support for:
"   - Normal mode
"   - Visual mode
"   - Insert mode
"   - Command-line mode
"   - When editing help files
set mouse=a

" Do smart indentation when starting a new line.
set smartindent

" Use a visual bell instead of a beep.
set visualbell

" Makes the command input 2 lines tall.
set cmdheight=2

" Makes no timeout exist for a <c-f> keypress.
set notimeout

" Don't make backup files before overwriting files.
set nobackup
set nowritebackup

" Timeout for a command to be finished in milliseconds.
set timeoutlen=200 ttimeoutlen=0

" When the last window will have a statusline. (2 = always)
set laststatus=2

" Don't give ins-completion-menu messages.
set shortmess+=c

" Do not redraw the screen while executing macros.
set lazyredraw

" Use 24-bit colours.
" Requires an ISO-8613-3 compatible terminal (e.g. alacritty).
set termguicolors

" After 300 milliseconds inactivity, the swap file will be updated.
set updatetime=300

" Put :split windows below the current.
set splitbelow

" Put :vsplit windows to the right of the current.
set splitright

" Text should always be shown normally.
set conceallevel=0
set concealcursor&

" Folds should be done via markers.
set foldmethod=marker

" Don't expand tabs into spaces.
set noexpandtab

" A TAB should be 4 long.
set tabstop=4

" A soft tab should be 0 long.
set softtabstop=0

" A shift should be 4 spaces long.
set shiftwidth=4

" Use <SPACE> as <Leader>.
let mapleader = " "

let g:lightline = {
	\ 'colorscheme': 'PaperColor',
	\ 'active': {
	\ 	'left': [
	\ 		[ 'mode', 'paste' ],
	\ 		[ 'cocstatus', 'readonly', 'filename', 'modified' ]
	\ 	]
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status'
	\ },
\ }

" LaTeX
let g:livepreview_previewer = 'zathura'

" Disable automatic folding in Markdown files.
let g:vim_markdown_folding_disabled = 1

" Don't conceal stuff in Markdown files.
let g:vim_markdown_conceal = 0 

let g:context_add_mappings = 0

" Commands to use specific indentation style
command! -nargs=1 Spaces execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " expandtab" | setlocal ts? sw? sts?
command! -nargs=1 Tabs execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " noexpandtab" | setlocal ts? sw? sts?

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0]
				\ | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd InsertEnter *.json setlocal concealcursor=
autocmd InsertLeave *.json setlocal concealcursor=inc

map <C-e> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFocus<CR>

let g:ale_rust_cargo_use_check = 0
let g:ale_rust_rls_executable = 'rustup run nightly rls'
let g:ale_linters = {
		\ 'sh': ['language_server'],
\ }

autocmd FileType json syntax match Comment +\/\/.\+$+
inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
inoremap <silent><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gå <Plug>(coc-diagnostic-prev)
nmap <silent> gæ <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~# '\s'
endfunction

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>qf <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <silent> <Leader>cc :<C-u>CocList commands<CR>
nnoremap <silent> <Leader>co :<C-u>CocList outline<CR>
nnoremap <silent> <Leader>cs :<C-u>CocList -I symbols<CR>
nnoremap <silent> <Leader>j :<C-u>CocNext<CR>
nnoremap <silent> <Leader>k :<C-u>CocPrev<CR>
nnoremap <silent> <Leader>p :<C-u>CocListResume<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nmap <S-CR> o<ESC>
nmap <C-CR> O<ESC>

nnoremap <Leader>\ :edit ~/.config/nvim/init.vim<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>r :edit<CR>
nnoremap <Leader>f :Format<CR>
nnoremap <Leader>h :noh<CR>

nnoremap <Leader>tl :tabnext<CR>
nnoremap <Leader>th :tabprev<CR>
nnoremap <Leader>tt :tabnew<CR>
nnoremap <Leader>te :tabedit<Space>
nnoremap <Leader>tj :tablast<CR>
nnoremap <Leader>tk :tabfirst<CR>
nnoremap <Leader>tf :tabfind<Space>
nnoremap <Leader>tq :tabclose<CR>
nnoremap <Leader>tw :w<CR>:tabclose<CR>
nnoremap <Leader>s "+
vnoremap <Leader>s "+
nnoremap <Leader><Leader> :

nnoremap <Leader><tab> :FZF<CR>

map <UP> <NOP>
map <RIGHT> <NOP>
map <LEFT> <NOP>
map <DOWN> <NOP>

function! Modeline()
	let l:modeline = printf(
				\ "vim: set ff=unix autoindent ts=%d sw=%d tw=%d %set :",
				\ &tabstop,
				\ &shiftwidth,
				\ &textwidth,
				\ &expandtab ? '' : 'no'
				\ )

	" Some `&commentstring` include a space, some do not, and I'm not all
	" about that ugly code B)
	if stridx(&commentstring, " ") == -1
		let l:modeline = printf(" %s", l:modeline)
	endif

	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunction
nnoremap <Leader>ml :call Modeline()<CR>

" Uncomment if gruvbox is used.
"let g:gruvbox_italic=1

set background=light
colorscheme PaperColor

"                 &&& & &   	
"            &    &&&&&  &  &  &   	
"            &&  & &&&&&&&&  & &  &   	
"        &  &&&  &&&&&&&&&& &   	
"               &&  /&~&&& &   	
"           &&& &&&&&&&& &  &   	
"       &   &&  &&&&|&&&&&&&&   	
"          & && &\_&&\&&&&&&&   	
"                & /~\|&&&__/& && &&   	
"                   /_/ _/ _&_&&&&&&   	
"                 \/~~|/|     &&&& Cute bonsai to
"                  /|/_\       &&&   disract you from
"                 \/~   	the modeline
"                  /|   	
"                 /~   	
"                   \   	
"                    \   	
"                     /   	
"                    /   	
"                   /~   	
"   :___________./~~\.___________:
"    \                          /
"     \________________________/
"     (_)                    (_)

" vim: set ff=unix autoindent ts=4 sw=4 tw=78 noet :
