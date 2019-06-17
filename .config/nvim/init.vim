"Plugins {{{
    call plug#begin()

    "Git integration
    Plug 'tpope/vim-fugitive'

    "Autocompletion
    function! DoRemote(arg)
        UpdateRemotePlugins
    endfunction
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'greg-js/vim-react-es6-snippets'

    " Nerdtree is a file browser in the left pane
    Plug 'scrooloose/nerdtree'

    "Language protocol support
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }

    "Fuzzy file finder
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    "See editorconfig.org
    Plug 'editorconfig/editorconfig-vim'

    "Sneaky motions
    Plug 'justinmk/vim-sneak'

    "Better JS highlighting & indentation
    Plug 'pangloss/vim-javascript'

    "TypeScript syntax highlighting
    Plug 'leafgarland/typescript-vim'

    "TypeScript completion support
    Plug 'Quramy/tsuquyomi'

    "Syntax checking
    Plug 'w0rp/ale'

    "Async execution for vim (dependency of tsuquyomi)
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }

    "JSX support
    Plug 'mxw/vim-jsx'

    "Improved Markdown support
    Plug 'plasticboy/vim-markdown'

    "Modify surrounding chars, such as parantheses & quotes
    Plug 'tpope/vim-surround'

    call plug#end()

"}}}

"Plugin settings {{{
    "Enable vim-jsx also for .js files
    let g:jsx_ext_required = 0

    "Disable folding for markdown files
    let g:vim_markdown_folding_disabled = 1

    let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio']
    \ }
"}}}

"Basic settings {{{
    set expandtab
    set shiftwidth=2
    set tabstop=2
    set smartindent
    set smarttab

    set ignorecase
    set smartcase
    set hlsearch
    set incsearch

    set wildmode=longest:full
    set wildmenu
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/node_modules

    set foldmethod=marker

    set backupcopy=yes

    syntax on
    filetype on
    filetype plugin indent on

    "Don't allow NVIM to set cursor shape
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
    set guicursor=

    "Disable mouse
    set mouse=""

    "Use relative line numbers for all lines...
    set relativenumber
    "...except the current line
    set number
"}}}

"Key mappings {{{
    let mapleader=","

    nmap <Leader>p :Files<CR>
    nmap <Leader>o :Buffers<CR>
    nmap <Leader>l :Lines<CR>

    "Make ctrl-l clear highlights
    nnoremap <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

    imap jj <Esc>
"}}}

"Statusline {{{
    hi User1 ctermbg=black   ctermfg=white   guibg=darkgrey  guifg=white
    hi User2 ctermbg=black   ctermfg=grey    guibg=darkgrey  guifg=grey

    set laststatus=2
    set statusline+=%1*
    set statusline+=%F\ 
    set statusline+=%2*
    set statusline+=%m%r
    set statusline+=%y
    set statusline+=%{fugitive#statusline()}
    set statusline+=%=
    set statusline+=%10((%l,%c)%)\ 
    set statusline+=%P
"}}}

"Misc {{{
    set list
    set listchars=nbsp:…,tab:▸\ ,trail:·

    "Disable background color erase
    set t_ut=
"}}}

"Deoplete {{{
    let g:deoplete#enable_at_startup = 1
"}}}

"UltiSnips {{{
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"}}}
