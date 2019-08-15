"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Notes to Self
"
" Leader is set to space. So to reload this vimrc, aka:
"
" nnoremap <leader>r :so $MYVIMRC<CR>
"
" I hold space and hit r.
"
" C is mapped to the caps lock key. So:
"
" nmap <C-n> :NERDTreeToggle<CR>
"
" I hold caps lock and hit n.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoVim Plugins, installed using vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Sensible defaults for vim
Plug 'tpope/vim-sensible'

" Nerdtree is a file browser in the left pane
Plug 'scrooloose/nerdtree'

" This is a frontend for the silver searcher (ag) but it is deprecated.
" However, it still works.
Plug 'rking/ag.vim'

" Supplies GBlame inline. Does other git-specific things (:Gbrowse should
" automatically open the file on Github, but I'm not sure it works)
Plug 'tpope/vim-fugitive'
" Apparently it also needs this
Plug 'tpope/vim-rhubarb'

" Ctrl+p
Plug 'ctrlpvim/ctrlp.vim'

" This allows for navigation amongst CamelCase words, very neessary
Plug 'bkad/CamelCaseMotion'

" vim-airline makes things slow as shit
" Plug 'vim-airline/vim-airline'

" Baller package that parses javascript
" 'Syntax highlighting and improved indentation'
Plug 'pangloss/vim-javascript'

" Formatting for JSX"
Plug 'mxw/vim-jsx'

" Coloring for typescript
Plug 'leafgarland/typescript-vim'

" A formatter and syntax highlighter for jsx.
" This one works on Tower, and the one below
" does not.
Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'peitalin/vim-jsx-typescript'

" Typescript IDE
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For async completion - deoplete, installed below
" For Denite features
Plug 'Shougo/denite.nvim'


" Alternative Typescript IDE
" Plug 'Quramy/tsuquyomi'

" Trying to get indenting back
Plug 'AndrewRadev/splitjoin.vim'

" This is for use with tsuquyomi below
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Formatting for styled-components
" Plug 'styled-components/vim-styled-components'

" pretter is a js package for making js pretty, not sure exactly what else
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }

" deoplete is also a completion (aka auto-complete) plugin, apparently its async
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Splits Javascript objects and JSX
Plug 'AndrewRadev/splitjoin.vim'

" Matching plugin which purports to match through things like
" if / else, while / endwhile, that sort of thing
" But it doesn't work out of the box so blech
" Plug 'andymass/matchup.vim'

" Plug 'samuelsimoes/vim-jsx-utils'
" Plug 'maksimr/vim-jsbeautify'

" This allows one click line commenting
Plug 'tpope/vim-commentary'

" I mostly use this to go from snake case to camelcase. Example:
"
" Want to turn barBar into bar_bar? Press crs (coerce to snake_case).
" MixedCase (crm), camelCase (crc), snake_case (crs), UPPER_CASE (cru),
" dash-case (cr-), dot.case (cr.), space case (cr<space>),
" and Title Case (crt) are all just 3 keystrokes away
Plug 'tpope/tpope-vim-abolish'

" This allows easy switching between quotes. So you can do
" cs'" and single quotes become double quotes
Plug 'tpope/vim-surround'

" This ostensibly hooks up a thesaurus
" Note this plugin also fucks with my custom mappings
" Plug 'beloglazov/vim-online-thesaurus'

" This is another thesaurus
" This also fucks with my mappings
"Plug 'Ron89/thesaurus_query.vim'


" No idea what these do
" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'

" Vim plugin for Go
Plug 'fatih/vim-go'

call plug#end()

"""""
" General
"""""
let mapleader="\<SPACE>"

" Sets how many lines of history VIM has to remember
set history=1000

set wildmenu

" Enable filetype plugins
filetype plugin indent on

" Pathogen
set nocp
syntax on

set number

" Set to auto read when a file is changed from the outside
set autoread

"Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Speed speed speed. When this option is set, the screen will not be
" redrawn while executing macros, registers and other commands that have
" not been typed. Also, updating the window title is postponed.
" To force an update use |:redraw|.
set lazyredraw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Use g flag by default  with :s/baz/bar/g
" set gdefault

" Use magic patterns (extended regular expressions)
set magic

nmap <Leader>s :%S//g<Left><Left>
vmap <Leader>s :S//g<Left><Left>

" Turn off F1
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme desert
"colorscheme delek
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set nowritebackup


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs

setlocal autoindent
"setlocal cindent
setlocal smartindent

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

set lbr
set tw=500
set nojoinspaces
set nostartofline

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" JSBeautify
vnoremap <leader>f :call RangeJsBeautify()<cr>
vnoremap <leader>f :call RangeJsonBeautify()<cr>
vnoremap <leader>f :call RangeJsxBeautify()<cr>
vnoremap <leader>f :call RangeHtmlBeautify()<cr>
vnoremap <leader>f :call RangeCSSBeautify()<cr>

autocmd FileType javascript vnoremap <leader>f :call RangeJsBeautify()<cr>
autocmd FileType ts vnoremap <leader>f :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <leader>f :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <leader>f :call RangeJsxBeautify()<cr>
autocmd FileType tsx vnoremap <leader>f :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <leader>f :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <leader>f :call RangeCSSBeautify()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" PHP Formatting
au BufRead,BufNewFile *.php set ft=phtml

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript and JSX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" JSX Formatting
let g:jsx_ext_required = 0

" Try to find .eslint_rules
function! ESLintArgs()
  let rules = findfile('.eslint_rules', '.;')
  return rules != '' ? '--rulesdir ' . shellescape(fnamemodify(rules, ':p:h')) : ''
endfunction

" Typescript colors
autocmd BufEnter,BufNewFile,BufRead *.js set filetype=javascript
autocmd BufEnter,BufNewFile,BufRead *.mjs set filetype=javascript
au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufEnter,BufNewFile,BufRead *.ts set filetype=typescript
" autocmd BufEnter,BufNewFile,BufRead *.tsx set filetype=typescript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" These are breaking normal JS and .ts files
" autocmd BufEnter,BufNewFile,BufRead *.ts,*.js set filetype=typescript.jsx
" autocmd BufEnter,BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.jsx

" let g:js_indent_typescript = 1
let g:js_indent_logging = 1
let g:js_indent_flat_switch = 1

" Javascript highlighting in template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String

" Tern
nnoremap <leader>td :TernDef<CR>
nnoremap <leader>tt :TernType<CR>
nnoremap <leader>tr :TernRefs<CR>
nnoremap <leader>tR :TernRename<CR>

" vim-jsx-pretty
let g:vim_jsx_pretty_enable_jsx_highlight = 1
let g:vim_jsx_pretty_colorful_config = 0

" AndrewRadev/splitjoin.vim

" Split JSX intelligently
" g:splitjoin_html_attributes_bracket_on_new_line

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" w0rp/ale configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow navigation to errors
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

let g:ale_sign_column_always = 1

let g:ale_linters = { 'js': ['eslint'], 'jsx': ['eslint'], 'tsx': ['tslint', 'tsserver'] }

let g:ale_sign_error = '->'
let g:ale_sign_warning = '--'

" let g:ale_fix_on_save = 1

" let g:ale_fixers = {
"   'html': []
" }

" Don't lint minified js or node_modules
let g:ale_pattern_options = {
\ 'node_modules': {'ale_linters': [], 'ale_fixers': []},
\ '\.(ts|tsx)$': ['tslint', 'tsserver'],
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []}
\ }

let g:ale_linters = {'typescript': ['tslint', 'tsserver']}

" THIS DOESNT SEEM TO BE WORKING
" let g:ale_lint_on_text_changed = 'never'

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoVim Plugins, installed using built in plugins
"
" w0rp/ale - Asynchronous linting engine
" mxw/vim-jsx - styling for jsx
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Writing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd BufNewFile,BufRead *.md set ft=markdown spell

" Set thesaurus mapping to space-t
" nnoremap <Leader>cs :ThesaurusQueryReplaceCurrentWord<CR>
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pymode_options_max_line_length = 120
let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
set nofoldenable

highlight BadWhitespace guibg=red ctermbg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

nnoremap <Leader>qj ^yw$a `json:"phcrsA"`j

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Ignore line line warnings
" I'm now trying to edit this in ~/.config/flake8
" let g:ale_python_flake8_options="--ignore=E501"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_snippet_engine = "neosnippet"
" au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>d <Plug>(go-def)
au FileType go nmap <Leader>hd <Plug>(go-def-split)
au FileType go nmap <Leader>vd <Plug>(go-def-vertical)
