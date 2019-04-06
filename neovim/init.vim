    "set runtimepath^=~/.vim runtimepath+=~/.vim/after
    "let &packpath = &runtimepath
    "source ~/.vimrc

" PLUGINS

call plug#begin('~/.local/share/nvim/plugged')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'Shougo/deoplete-clangx'
	Plug 'w0rp/ale'
	Plug 'iamcco/markdown-preview.vim'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'SirVer/ultisnips'
	let g:deoplete#enable_at_startup = 1
call plug#end()

" GENERAL
	set relativenumber
	set number
	set showbreak=+++
	set textwidth=80
	set autoindent
	set smarttab
	set tabstop=4
	set shiftwidth=4
	set clipboard=unnamedplus

" Highlighting
	match Todo /\vXXX|TODO\(([^)]+)\)|FIXME\(([^)]+)\)|FIXME/
	hi Todo ctermfg=black ctermbg=blue
	call matchadd('ColorColumn', '\%82v', 100)
	hi SpellBad ctermfg=111
	hi SpellBad ctermbg=799


" Make j and k work with both relativenumbers and softwrapped text
	nnoremap <expr> j v:count ? 'j' : 'gj'
	nnoremap <expr> k v:count ? 'k' : 'gk'

" Navigation with splits
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Autocomplete to tab
	inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" LATEX
	autocmd filetype tex set spelllang=nb,en
	autocmd filetype tex set spell
	autocmd filetype tex set conceallevel=2


" C++
    autocmd FileType cpp inoremap { <Esc>a{<Enter>}<Esc><Up>$a<Enter>
    autocmd FileType cpp inoremap [ <Esc>a[]<++><Esc>T[i
    autocmd FileType cpp inoremap ( <Esc>a()<++><Esc>T(i
    autocmd Filetype cpp set textwidth=80

" R Markdown
    autocmd filetype rmd set spelllang=nn,en
    autocmd filetype rmd set spell
	autocmd filetype rmd set conceallevel=2

" Markdown
    autocmd filetype markdown set spelllang=nn,en
	autocmd filetype markdown set conceallevel=2

" ALE
	let g:ale_lint_on_text_changed = 'never'
	let g:ale_lint_on_enter = 0

" FZF
	noremap <C-n> :Files ../<CR>

" Navigating with guides
	vnoremap <Space><Space> <Esc>/<++><Enter>"_c4l
	noremap <Space><Space> <Esc>/<++><Enter>"_c4l
	noremap ;gui a<++><Esc>

" Ultisnips
	let g:UltiSnipsExpandTrigger="<A-tab>"
	let g:UltiSnipsJumpForwardTrigger="<A-tab>"
	let g:UltiSnipsJumpBackwardTrigger="<C-z>"
	let g:UltiSnipsSnippetDirectories=["~/Git/dots/neovim/UltiSnips"]
