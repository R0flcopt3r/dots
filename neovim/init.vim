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
	Plug 'autozimu/LanguageClient-neovim', {
		\ 'branch': 'next',
		\ 'do': 'bash install.sh',
		\ }
	let g:deoplete#enable_at_startup = 1
call plug#end()

" LanguageClient 
	set hidden
	let g:LanguageClient_serverCommands = {
		\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
		\ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
		\ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
		\ 'python': ['/usr/local/bin/pyls'],
		\ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
		\ }


" Srcery
	let g:srcery_transparent_background = 1
	let g:srcery_underline=1
	let g:srcery_undercurl=1
	let g:srcery_italic=1
	let g:srcery_bold=1
	colorscheme srcery

" GENERAL
	set relativenumber
	set number
	set autoindent
	set smarttab
	set tabstop=4
	set shiftwidth=4
	set noexpandtab 
	set clipboard=unnamedplus
	set undofile 				" Persisten undo
	set inccommand=nosplit 		" Shows regex and replaces in real time
	set textwidth=80
	set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{wordcount()[\"words\"]}\ %P
	set foldcolumn=2			" Shows two levels of folding
	set lazyredraw 				" Wont redraw during macro
	set smartcase				" Enable smart-case search

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
		"inoremap <expr><tab> pumvisible() ? '\<c-n>' : '\<tab>'
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
	" split and find
		nnoremap <leader>sf :below split<CR>:Files ../<CR>
		nnoremap <leader>vf :vsplit<CR>:Files ../<CR>
	" LanguageClient
		nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
		nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
		nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Highlighting
	match Todo /\vXXX|TODO\(([^)]+)\)|FIXME\(([^)]+)\)|FIXME/
	hi Todo ctermfg=black ctermbg=blue
	call matchadd('ColorColumn', '\%82v', 100)
	hi SpellBad ctermfg=111
	hi SpellBad ctermbg=799


" Writing
	augroup writing
		autocmd!
		autocmd filetype tex,markdown,rmd set spelllang=nb,en
		autocmd filetype tex,markdown,rmd set spell
	augroup end

" Programming
	augroup programming
		autocmd!
		autocmd FileType cpp,rust set foldmethod=syntax
		autocmd FileType cpp,rust set foldminlines=7
		autocmd FileType cpp,rust set foldnestmax=2
	augroup end

	augroup cpp
		autocmd!
		autocmd FileType cpp nnoremap <leader>c :w<CR> :! make<CR>
	augroup end

	augroup rust
		autocmd!
		autocmd FileType rust nnoremap <leader>c :w<CR> :! cargo run<CR>
		autocmd FileType rust nmap gd <Plug>(rust-def)
		autocmd FileType rust nmap gs <Plug>(rust-def-split)
		autocmd FileType rust nmap gx <Plug>(rust-def-vertical)
		autocmd FileType rust nmap <leader>gd <Plug>(rust-doc)
	augroup end

" ALE
	let g:ale_lint_on_text_changed = 'never'
	let g:ale_lint_on_enter = 0

" Ultisnips
	let g:UltiSnipsExpandTrigger='<A-tab>'
	let g:UltiSnipsJumpForwardTrigger='<tab>'
	let g:UltiSnipsJumpBackwardTrigger='<S-tab>'
	let g:UltisnipsListSnippets='<C-tab>'
	let g:UltiSnipsSnippetDirectories=['/home/eirik/Git/dots/neovim/UltiSnips/']


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
