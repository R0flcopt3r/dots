" PLUGINS

call plug#begin('~/.local/share/nvim/plugged')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'Shougo/deoplete-clangx'
	Plug 'w0rp/ale'
	Plug 'iamcco/markdown-preview.vim'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
	Plug 'SirVer/ultisnips'
	Plug 'junegunn/goyo.vim'
	Plug 'srcery-colors/srcery-vim'
	let g:deoplete#enable_at_startup = 1
call plug#end()

" GENERAL
	set relativenumber
	set number
	set autoindent
	set smarttab
	set tabstop=4
	set shiftwidth=4
	set clipboard=unnamedplus
	set undofile 				" Persisten undo
	set inccommand=nosplit 		" Shows regex and replaces in real time
	set textwidth=80
	colorscheme srcery
	set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{wordcount()[\"words\"]}\ %P
	set foldcolumn=2			" Shows two levels of folding
	set lazyredraw 				" Wont redraw during macro


" Keybinds
	" Rerun last macro. Q was old Ex mode
		nnoremap Q @@ 
	" Navigation with splits
		map <C-h> <C-w>h
		map <C-j> <C-w>j
		map <C-k> <C-w>k
		map <C-l> <C-w>l
	" FZF
		noremap <leader>n :Files ../<CR>
	" Make j and k work with both relativenumbers and softwrapped text
		nnoremap <expr> j v:count ? 'j' : 'gj'
		nnoremap <expr> k v:count ? 'k' : 'gk'
	" Autocomplete to tab
		"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
	" Navigating with guides
		vnoremap <leader><Space> <Esc>/<++><Enter>"_c4l
		noremap  <leader><Space> <Esc>/<++><Enter>"_c4l
		noremap ;gui a<++><Esc>
	" Run command on cursor line
		nnoremap <leader>e :exe getline(line('.'))<cr>
	" Open a terminal split below current split
		nnoremap <leader>t :below split<CR>:terminal<CR>
	" Folding
		nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
		vnoremap <Space> zf

" Highlighting
	match Todo /\vXXX|TODO\(([^)]+)\)|FIXME\(([^)]+)\)|FIXME/
	hi Todo ctermfg=black ctermbg=blue
	call matchadd('ColorColumn', '\%82v', 100)
	hi SpellBad ctermfg=111
	hi SpellBad ctermbg=799


" LATEX
	autocmd filetype tex set spelllang=nb,en
	autocmd filetype tex set spell

" C++
    autocmd FileType cpp set foldmethod=syntax

" C++ 
    autocmd FileType rust inoremap { <Esc>a{<Enter>}<Esc><Up>$a<Enter>
    autocmd FileType rust inoremap [ <Esc>a[]<++><Esc>T[i
    autocmd FileType rust inoremap ( <Esc>a()<++><Esc>T(i
    autocmd FileType rust set foldmethod=syntax

" R Markdown
    autocmd filetype rmd set spelllang=nn,en
    autocmd filetype rmd set spell

" Markdown
    autocmd filetype markdown set spelllang=nn,en

" ALE
	let g:ale_lint_on_text_changed = 'never'
	let g:ale_lint_on_enter = 0

" Ultisnips
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<A-tab>"
	let g:UltisnipsListSnippets="<C-tab>"
	let g:UltiSnipsSnippetDirectories=["/home/eirik/Git/dots/neovim/UltiSnips/"]

" Goyo

	noremap <leader>g :Goyo<CR>
	function! s:goyo_enter()
	" Highlighting
		match Todo /\vXXX|TODO\(([^)]+)\)|FIXME\(([^)]+)\)|FIXME/
		hi Todo ctermfg=black ctermbg=blue
		call matchadd('ColorColumn', '\%82v', 100)
		hi SpellBad ctermfg=111
		hi SpellBad ctermbg=799
		set conceallevel=2
	endfunction

	function! s:goyo_leave()
	" Highlighting
		match Todo /\vXXX|TODO\(([^)]+)\)|FIXME\(([^)]+)\)|FIXME/
		hi Todo ctermfg=black ctermbg=blue
		call matchadd('ColorColumn', '\%82v', 100)
		hi SpellBad ctermfg=111
		hi SpellBad ctermbg=799
		set conceallevel=0
	endfunction

	autocmd! User GoyoEnter nested call <SID>goyo_enter()
	autocmd! User GoyoLeave nested call <SID>goyo_leave()
