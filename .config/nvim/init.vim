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
"
"
" Commenting
vmap <leader>c gc<CR>k
nmap <leader>c gcc<CR>k

" Jumping around splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" System clipboard
set clipboard=unnamed

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Nerdtree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git$','\.hg','\.svn','\.       bzr', '\.DS_Store']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" auto-open nerd tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <C-n> :NERDTreeToggle<CR>

" Ctrl P
" set runtimepath^=~/.vim/bundle/ctrlp.vim

" Ctrl-p ignore node modules
"let g:ctrlp_custom_ignore = { 'dir' : 'node_modules' }
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|ios\/build\|android\/app\/build'
let g:ctrlp_user_command = ['.git', 'cd %s; git ls-files -co --exclude-standard']

set pastetoggle=<F2>

" CamelCase words
map <S-W> <Plug>CamelCaseMotion_w
map <S-B> <Plug>CamelCaseMotion_b
map <S-E> <Plug>CamelCaseMotion_e

" Remapping paste to not yank into register
vnoremap p "_dP

" HTML
" Jump to closing tags
" runtime macros/matchit.vim

" Ignore capital letter fuckups
:command! WQ wq
:command! QA qa
:command! WA wa
:command! Wq wq
:command! Wa wa
:command! Qa qa
:command! W w
:command! Q q

" Reload vimrc
nnoremap <leader>reload :so $MYVIMRC<CR>
nnoremap <leader>r :so $MYVIMRC<CR>
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" YouCompleteMe
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_key_list_select_completion = ['<TAB>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>']






"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use ; for commands
nnoremap ; :

" Use Q to execute default register
nnoremap Q @q

" Kinesis mappings for enter key in insert mode
"inoremap <CR> <Esc>
inoremap jj <Esc>
inoremap jk <Esc>
vnoremap <CR> <Esc>
nnoremap K i<CR><Esc>h

" Open multiple lines (insert empty lines) before or after current line,
" and position cursor in the new space, with at least one blank line
" before and after the cursor.
function! OpenLines(nrlines, dir)
  let nrlines = a:nrlines < 3 ? 3 : a:nrlines
  let start = line('.') + a:dir
  call append(start, repeat([''], nrlines))
  if a:dir < 0
    normal! 2k
  else
    normal! 2j
  endif
endfunction

" Mappings to open multiple lines and enter insert mode.
nnoremap <Leader>o :<C-u>call OpenLines(v:count, 0)<CR>S
nnoremap <Leader>O :<C-u>call OpenLines(v:count, -1)<CR>S

"Remap arrow keys
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv
" in visual, escape
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
" imap <Up> <Esc>
" imap <Down> <Esc>
imap <Left> <Nop>
imap <Right> <Nop>
inoremap <Del> <Esc>
vnoremap <Del> <Esc>
nnoremap <Del> <Esc>

" Remap tab to esc
":inoremap kj <esc>
":inoremap jk <esc>
":vnoremap kj <esc>
":vnoremap jk <esc>
":cnoremap kj <C-c>
":cnoremap jk <C-c>
"nnoremap <Tab> <Esc>
"vnoremap <Tab> <Esc>gV
"onoremap <Tab> <Esc>
"inoremap <Tab> <Esc>`^
"inoremap <Leader><Tab> <Tab>

" vim-closetag
let g:closetag_filenames = "*.jsx,*.js"

" localvimrc
let g:localvimrc_sandbox = 0

" Install Plugins
nnoremap <leader>pi :PlugInstall<CR>
