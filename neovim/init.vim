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
	Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
	Plug 'tpope/vim-dadbod' " Connect to database with vim.
	Plug 'sirtaj/vim-openscad' 
	Plug 'leafgarland/typescript-vim' 
	Plug 'actionshrimp/vim-xpath' 
	Plug 'altercation/vim-colors-solarized'
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
	let g:LanguageClient_useVirtualText = 0

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
	set mouse=a	                " Mouse support

" Keybinds
	" Rerun last macro. Q was old Ex mode
		nnoremap Q @@ 
	" Navigation with splits
		map <C-h> <C-w>h
		map <C-j> <C-w>j
		map <C-k> <C-w>k
		map <C-l> <C-w>l
	" FZF
		noremap <leader>n :Files ./<CR>
		noremap <leader>N :Files ../<CR>
	" Make j and k work with both relativenumbers and softwrapped text
		nnoremap <expr> j v:count ? 'j' : 'gj'
		nnoremap <expr> k v:count ? 'k' : 'gk'
	" Navigating with guides
		vnoremap <leader><Space> <Esc>/<++><Enter>"_c4l
		noremap  <leader><Space> <Esc>/<++><Enter>"_c4l
		noremap ;gui a<++><Esc>
	" Run command on cursor line
		nnoremap <leader>e :exe getline(line('.'))<cr>
	" Open a terminal split below current split
		nnoremap <leader>t :below split<CR>:terminal<CR>:resize 12<CR>
	" Folding
		nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
		vnoremap <Space> zf
	" split and find
		nnoremap <leader>sf :below split<CR>:Files ./<CR>
		nnoremap <leader>vf :vsplit<CR>:Files ./<CR>
	" LanguageClient
		nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
		nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
		nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
	" Replace
		nnoremap <leader>r :%s///g<Left><Left>
	" dadbod run query
		vnoremap <leader>d :DB<CR>
	" dadbod run entire file
		nnoremap <leader>d :%DB<CR>
	" Buffers
		nnoremap <leader>b :Buffers<CR>
	" Goyo
		noremap <leader>g :Goyo<CR>
	" xPath
		vnoremap <leader>q :! xpath -e %v ./data/Disney.xml

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
		autocmd FileType markdown nnoremap <silent> <F5> :call SaveAndExecute("pandoc", 15)<CR>
	augroup end

" Programming
	augroup programming
		autocmd!
		autocmd FileType cpp,rust set foldmethod=syntax
		autocmd FileType cpp,rust set foldminlines=7
		autocmd FileType cpp,rust set foldnestmax=2
		autocmd FileType cpp nnoremap <silent> <F6> :call SaveAndExecute("g++", 15)<CR>
		autocmd FileType cpp vnoremap <silent> <F6> :<C-u>call SaveAndExecute("g++", 15)<CR>
	augroup end

	augroup bash
		autocmd!
		autocmd FileType sh nnoremap <silent> <F5> :call SaveAndExecute("sh", 15)<CR>
	augroup end

	augroup php
		autocmd!
		autocmd FileType php nnoremap <silent> <F5> :call SaveAndExecute("php", 15)<CR>
		autocmd FileType php vnoremap <silent> <F5> :<C-u>call SaveAndExecute("php", 15)<CR>
	augroup end

	augroup python
		autocmd!
		autocmd FileType python nnoremap <silent> <F5> :call SaveAndExecute("python", 15)<CR>
		autocmd FileType python vnoremap <silent> <F6> :<C-u>call SaveAndExecute("python", 15)<CR>
	augroup end

	augroup typescript
		autocmd!
		autocmd filetype typescript set  softtabstop=2 expandtab shiftwidth=2
	augroup end

	augroup cpp
		autocmd!
		autocmd FileType cpp nnoremap <leader>c :w<CR> :! make<CR>
		autocmd FileType cpp nnoremap <leader>C :w<CR> :! make  <CR> :GdbStart gdb -q ../bin/main <CR>
		autocmd FileType cpp nnoremap <leader>x :w<CR> :! xmake run <CR>
		autocmd FileType cpp nnoremap <leader>X :w<CR> :! xmake  <CR> :GdbStart gdb -q ../build/linux/x86_64/release/
	augroup end

	augroup rust
		autocmd!
		autocmd FileType rust nnoremap <leader>c :w<CR> :! cargo run<CR>
		autocmd FileType rust nmap gd <Plug>(rust-def)
		autocmd FileType rust nmap gs <Plug>(rust-def-split)
		autocmd FileType rust nmap gx <Plug>(rust-def-vertical)
		autocmd FileType rust nmap <leader>gd <Plug>(rust-doc)
	augroup end

	augroup yml
		autocmd!
		autocmd FileType yaml set softtabstop=4 expandtab shiftwidth=4
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

" dadbod
	let g:db='mysql://root:imt2571@127.0.0.1:3306/'


" Goyo
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


function SaveAndExecute(compiler, size)
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute 'update | edit'

    " get file path of current file
    let s:current_buffer_file_path = expand('%')

    let s:output_buffer_name = 'PHP'
    let s:output_buffer_filetype = 'output'

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists('s:buf_nr') || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute 'setlocal filetype=' . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
	if a:compiler == 'cpp'
		silent execute '.!' . a:compiler . ' ' . shellescape(s:current_buffer_file_path, 1) 
		silent execute '! ./a.out'
	elseif a:compiler == 'shebang' 
		silent execute '.!/bin/sh' . ' '  . shellescape(s:current_buffer_file_path, 1)
	else
		silent execute '.!' . a:compiler . ' ' . shellescape(s:current_buffer_file_path, 1)
	endif

    " resize window to content length
	" Note: This is annoying because if you print a lot of lines then your code
	"       buffer is forced to a height of one line every time you run this function.
	"       However without this line the buffer starts off as a default size and if
	"       you resize the buffer then it keeps that custom size after repeated runs
	"       of this function.
	"
    "       But if you close the output buffer then it returns to using the default size when its recreated
    execute 'resize' . a:size

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction
