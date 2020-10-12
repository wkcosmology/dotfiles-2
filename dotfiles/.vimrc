" My VIM setup
"
" Author: Ricardo Madriz
" Based on: Sam Roeca's dotfiles (https://github.com/pappasam/dotfiles)

" General: global config ---------------------- {{{

" Leader mappings
let mapleader = ","
let maplocalleader = "\\"

"A comma separated list of options for Insert mode completion
"   menuone  Use the popup menu also when there is only one match.
"            Useful when there is additional information about the
"            match, e.g., what file it comes from.

"   longest  Only insert the longest common text of the matches.  If
"            the menu is displayed you can use CTRL-L to add more
"            characters.  Whether case is ignored depends on the kind
"            of completion.  For buffer text the 'ignorecase' option is
"            used.

"   preview  Show extra information about the currently selected
"            completion in the preview window.  Only works in
"            combination with 'menu' or 'menuone'.
set completeopt=menu,longest

" Enable buffer deletion instead of having to write each buffer
set hidden

" Mouse: enable GUI mouse support in all modes
set mouse=a

" Set column to light grey at 80 characters
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

" Always show signcolumn
set signcolumn=yes

" Highlight current line
set cursorline

" Remove query for terminal version
" This prevents un-editable garbage characters from being printed
" after the 80 character highlight line
set t_RV=

filetype plugin indent on

set spelllang=en_us

set showtabline=2

set autoread

" When you type the first tab hit will complete as much as possible,
" the second tab hit will provide a list, the third and subsequent tabs
" will cycle through completion options so you can complete the file
" without further keys
set wildmode=longest,list,full
set wildmenu

" Turn off complete vi compatibility
set nocompatible

" Enable using local vimrc
set exrc

" Make sure numbering is set
set number
set relativenumber

" Disable Swap file
set nobackup
set noswapfile

" My shell is ZSH
set shell=/usr/bin/zsh

" More natural splitting
set splitbelow
set splitright

" Hide mode (LightLine provides what we need to tell the mode we're in
set noshowmode

" Redraw window whenever I've regained focus
augroup redraw_on_refocus
  au FocusGained * :redraw!
augroup END

" Ignore annoying patterns
set wildignore=*.pyc,**/__pycache__/*,**/node_modules/*,.coverage.*,.eggs,*.egg-info/

" Ignore casing when performing completion
set wildignorecase

" Better color support
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

let g:python3_host_prog = $HOME . '/.asdf/shims/python3'
let g:python_host_prog  = $HOME . '/.asdf/shims/python2'

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Have proper space to show diagnostic messages
set cmdheight=2
"
" }}}
" General: Plugin Install --------------------- {{{
function! PackagerInit() abort
  packadd vim-packager
  call packager#init({'depth': 1})
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

  " Basic
  call packager#add('fcpg/vim-altscreen')
  call packager#add('itchyny/lightline.vim')
  call packager#add('tpope/vim-surround')
  call packager#add('tmux-plugins/vim-tmux-focus-events') " Tmux integration
  call packager#add('christoomey/vim-system-copy')
  call packager#add('tmhedberg/matchit')

  call packager#add('bagrat/vim-buffet')
  call packager#add('Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' })

  " Utils
  call packager#add('tpope/vim-commentary')
  call packager#add('ctrlpvim/ctrlp.vim')
  call packager#add('myusuf3/numbers.vim')
  call packager#add('tpope/vim-abolish')
  call packager#add('weirongxu/plantuml-previewer.vim')
  call packager#add('tyru/open-browser.vim')
  call packager#add('greyblake/vim-preview')
  call packager#add('alvan/vim-closetag')
  call packager#add('tpope/vim-ragtag')
  call packager#add('wincent/ferret')
  call packager#add('tommcdo/vim-lion')
  call packager#add('tpope/vim-endwise')
  call packager#add('pappasam/vim-filetype-formatter')
  call packager#add('Yggdroot/indentLine')
  call packager#add('psliwka/vim-smoothie')
  call packager#add('mogelbrod/vim-jsonpath', {'type': 'opt'})

" Coloring & Syntax highlighting
  call packager#add('NLKNguyen/papercolor-theme')
  call packager#add('numirias/semshi', {'do': ':UpdateRemotePlugins'})

  call packager#add('chr4/nginx.vim')
  call packager#add('docker/docker', {'rtp': '/contrib/syntax/vim/'})
  call packager#add('pangloss/vim-javascript')
  call packager#add('MaxMEllon/vim-jsx-pretty')
  call packager#add('mrk21/yaml-vim')
  call packager#add('aklt/plantuml-syntax')
  call packager#add('khalliday7/Jenkinsfile-vim-syntax')
  call packager#add('cespare/vim-toml')
  call packager#add('hashivim/vim-terraform')
  call packager#add('jparise/vim-graphql')
  call packager#add('plasticboy/vim-markdown')
  call packager#add('leafgarland/typescript-vim')
  call packager#add('peitalin/vim-jsx-typescript')

" Indentation & folding
  call packager#add('hynek/vim-python-pep8-indent' , {'type': 'opt'})
  call packager#add('vim-scripts/groovyindent-unix', {'type': 'opt'})
  call packager#add('tmhedberg/simpylfold') " Better folding for python
  call packager#add('pseewald/vim-anyfold')

" Git
  call packager#add('tpope/vim-fugitive')
  call packager#add('airblade/vim-gitgutter')
  call packager#add('rhysd/git-messenger.vim')
  call packager#add('kristijanhusak/defx-git')

" Language server: Coc
  call packager#add('Shougo/neco-vim')
  call packager#add('neoclide/coc-neco')
  call packager#add('neoclide/coc.nvim', {'branch': 'release'})
  for coc_plugin in [
        \ 'fannheyward/coc-sql',
        \ 'iamcco/coc-diagnostic',
        \ 'josa42/coc-docker',
        \ 'neoclide/coc-css',
        \ 'neoclide/coc-html',
        \ 'neoclide/coc-json',
        \ 'neoclide/coc-pairs',
        \ 'neoclide/coc-snippets',
        \ 'neoclide/coc-tsserver',
        \ 'neoclide/coc-yaml',
        \ 'pappasam/coc-jedi',
        \ ]
    call packager#add(coc_plugin, {
          \ 'do': 'yarn install --frozen-lockfile && yarn build',
          \ })
  endfor
endfunction

command! PlugInstall call PackagerInit() |
      \ call packager#install()
command! -bang PlugUpdate call PackagerInit() |
      \ call packager#update({'force_hooks': '<bang>'})
command! -bang PlugClean call PackagerInit() |
      \ call packager#clean()
command! -bang PlugStatus call PackagerInit() |
      \ call packager#status()
command! -bang PlugStartOver call PackagerInit() |
      \ call packager#clean()
      \ call packager#update({'force_hooks': '<bang>'})

augroup enable_opt_plugins
  autocmd!
  autocmd Filetype python packadd vim-python-pep8-indent
  autocmd Filetype groovy packadd groovyindent-unix
  autocmd Filetype json packadd vim-jsonpath
augroup END

" }}}
" General: Indentation ------------------------ {{{

augroup indentation_sr
  autocmd!
  autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype yaml setlocal indentkeys-=<:>
  autocmd Filetype make setlocal noexpandtab softtabstop=0
augroup END

" }}}
" General: Folding Settings ------------------- {{{

augroup fold_settings
  autocmd!
  autocmd FileType vim,tmux,zsh setlocal foldmethod=marker foldlevelstart=0
  autocmd FileType yaml setlocal foldmethod=indent foldnestmax=5 foldlevelstart=5
  autocmd FileType * setlocal foldnestmax=1
augroup END

augroup fold_python_settings
  autocmd!
  autocmd BufRead *.py,*.js,*.jsx normal zR<CR>
augroup END

" }}}
" General: Trailing whitespace ---------------- {{{

" This section should go before syntax highlighting
" because autocommands must be declared before syntax library is loaded
function! TrimWhitespace()
  if &ft == 'markdown'
    return
  endif
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

highlight EOLWS ctermbg=red guibg=red
match EOLWS /\s\+$/
augroup whitespace_color
  autocmd!
  autocmd ColorScheme * highlight EOLWS ctermbg=red guibg=red
  autocmd InsertEnter * highlight EOLWS NONE
  autocmd InsertLeave * highlight EOLWS ctermbg=red guibg=red
augroup END

augroup fix_whitespace_save
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END

" }}}
" General: Syntax highlighting ---------------- {{{

" Papercolor: options
let g:PaperColor_Theme_Options = {}
let g:PaperColor_Theme_Options['theme'] = {
      \     'default.dark': {
      \       'transparent_background': 0,
      \       'override': {
      \         'color00': ['#282a36'],
      \         'color01': ['#ff5555'],
      \         'color02': ['#50fa7b'],
      \         'color03': ['#f1fa8c'],
      \         'color04': ['#bd93f9'],
      \         'color05': ['#6272a4'],
      \         'color06': ['#8be9fd', '#8be9fd-cyan/py>cls,self/js>default,const,var,let/vim>var_names'],
      \         'color07': ['#f8f8f2'],
      \         'color08': ['#4d4d4d'],
      \         'color09': ['#50fa7b', '#50fa7b-green/py>try,except,finally'],
      \         'color10': ['#50fa7b', '#50fa7b-green/py>keywords/js>function,return,undefined,null/html>attrs'],
      \         'color11': ['#50fa7b', '#ff79c6-pink/py>while,if,try/js>if,else,while,for/html>tags'],
      \         'color12': ['#fcf405', 'unused'],
      \         'color13': ['#bd93f9', '#bd93f9-purple/py>numbers,None,deco@/js>number,super,window'],
      \         'color14': ['#8be9fd'],
      \         'color15': ['#44475a'],
      \         'color16': ['#8be9fd'],
      \         'color17': ['#bd93f9', '#bd93f9-purple/py>True,False,None/js>true,false,this'],
      \         'cursorline': ['#44475a'],
      \         'cursorlinenr_bg': ['#282a36'],
      \         'cursorlinenr_fg': ['#00d75f'],
      \         'folded_bg': ['#5f5f5f', '59'],
      \         'folded_fg': ['#c6c6c6', '251'],
      \         'linenumber_bg': ['#282a36'],
      \         'linenumber_fg': ['#44475a'],
      \         'matchparen_bg': ['#282a36'],
      \         'matchparen_fg': ['#f8f8f2'],
      \         'search_bg': ['#00d75f'],
      \         'search_fg': ['#282a36'],
      \         'todo_bg': ['#44475a'],
      \         'todo_fg': ['#ffb86c'],
      \         'vertsplit_bg': ['#282a36'],
      \         'vertsplit_fg': ['#8be9fd'],
      \         'visual_bg': ['#44475a'],
      \         'visual_fg': ['#f8f8f2'],
      \       }
      \     }
      \ }
let g:PaperColor_Theme_Options['language'] = {
      \     'python': {
      \       'highlight_builtins' : 0
      \     },
      \     'javascript': {
      \       'highlight_builtins' : 1
      \     }
      \ }

" Syntax: select global syntax scheme
" Make sure this is at end of section
try
  set t_Co=256 " says terminal has 256 colors
  set background=dark
  colorscheme PaperColor
catch
endtry

function! s:redefine_keywords(new_keywords)
  for [newGroup, keywords] in a:new_keywords
    exec 'syn keyword ' . newGroup . ' ' . join(keywords)
  endfor
endfunction

function! s:override_links(new_links)
  for [oldGroup, newGroup] in a:new_links
    exec 'hi! link ' . oldGroup . ' ' . newGroup
  endfor
endfunction

function! s:js_syntax()
  let l:js_new_keywords = [
        \ ['jsBooleanFalse',    ['undefined', 'null']],
        \ ['jsStatement',       ['throw']],
        \ ]
  let l:js_links_overrides = [
        \ ['jsAsyncKeyword',   'jsStatement'],
        \ ['jsImport',         'jsStatement'],
        \ ['jsExport',         'jsStatement'],
        \ ['jsModuleAs',       'jsStatement'],
        \ ['jsFrom',           'jsStatement'],
        \ ['jsExportDefault',  'jsStatement'],
        \ ['jsClassKeyword',   'jsStatement'],
        \ ['jsExtendsKeyword', 'jsStatement'],
        \ ['jsNoise',          'jsConditional'],
        \ ]

  call s:redefine_keywords(l:js_new_keywords)
  call s:override_links(l:js_links_overrides)
endfunction

function! s:ts_syntax()
  let l:ts_new_keywords = [
        \ ['typescriptGlobal',   ['Error', 'EvalError', 'RangeError',
                                \ 'ReferenceError', 'SyntaxError', 'TypeError',
                                \ 'URIError', 'Promise', 'super'] ],
        \ ['typescriptStatement', ['await', 'async', 'continue', 'break', 'default',]],
        \ ['typescriptThis',      ['this']],
        \ ]
  let l:ts_links_overrides = [
        \ ['typescriptReserved',      'typescriptStatement'],
        \ ['typescriptExceptions',    'Exception'],
        \ ['typescriptGlobalObjects', 'typescriptGlobal'],
        \ ['typescriptThis',          'typescriptSpecial'],
        \ ]

  call s:redefine_keywords(l:ts_new_keywords)
  call s:override_links(l:ts_links_overrides)
endfunction

function! s:python_syntax()
  let g:semshi#simplify_markup = v:true
  " Make semshi play well with dracula colors
  hi semshiLocal           guifg=#ff0000
  hi semshiGlobal          guifg=#ff79c6
  hi semshiImported        guifg=#ff79c6 gui=bold
  hi semshiParameter       guifg=#ffb86c
  hi semshiParameterUnused guifg=#ffb86c gui=underline
  hi semshiFree            guifg=#ffb86c
  hi semshiBuiltin         guifg=#8be9fd
  hi semshiAttribute       guifg=#f8f8f2
  hi semshiSelf            guifg=#bd93f9 gui=italic
  hi semshiUnresolved      guifg=#ff5555 gui=underline
  hi semshiSelected        guifg=#282a36 guibg=#ffb86c
endfunction

augroup custom_syntax
  autocmd!
  " `Special` hi-group is italic by default
  try
    autocmd VimEnter,SourcePost * exec 'hi! Special gui=italic guifg=#ff5555'

    autocmd VimEnter,Filetype,SourcePost javascript,javascript.tsx call s:js_syntax()
    autocmd VimEnter,Filetype,SourcePost typescript,typescript.tsx call s:ts_syntax()
    autocmd VimEnter,Filetype,SourcePost python call s:python_syntax()
  catch
  endtry
augroup end

" Syntax highlight Debug utils
command! HiGroupInfo exe ':verbose hi '.synIDattr(synstack(line('.'), col('.'))[-1], 'name')

" }}}
" General: Key remappings --------------------- {{{

" Disable the functionality of arrow keys
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Up> <nop>
noremap <Down> <nop>

" Omnicompletion now works with Ctrl-Space
" inoremap <C-@> <C-x><C-o>
" inoremap <C-space> <C-x><C-o>
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> <C-]> <Plug>(coc-definition)

" GoTo code navigation.
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)

nnoremap <silent> <leader>d <cmd>call CocActionAsync('diagnosticToggle')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'help' . expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use C-e & C-y to scroll down/up when there's an opened floating window
nnoremap <expr><C-e> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-e>"
nnoremap <expr><C-y> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-y>"

" inoremap <CR> <ESC><Plug>(coc-snippets-expand)i<CR>
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Buffers
augroup buffer_navigation
  au!
  au BufEnter,WinEnter * if &bt == '' | nnoremap <buffer><silent> L :bnext<CR> | endif
  au BufEnter,WinEnter * if &bt == '' | nnoremap <buffer><silent> H :bprev<CR> | endif

  au BufEnter,WinEnter * if &bt == '' | nnoremap <buffer><silent> <leader>t :enew<CR> | endif

" Smartly close buffers/quit vim
  au BufEnter * if len(getbufinfo({'buflisted':1})) > 1 | nnoremap <buffer><silent> <localleader>q :bw<CR>
        \ | else |
        \ nnoremap <buffer><silent> <localleader>q :q<CR>
        \ | endif
augroup END

nnoremap <silent><leader>r :NumbersToggle<CR>

" Exit: Preview and Help && QuickFix and Location List
inoremap <silent> <C-c> <Esc>:pclose <BAR> helpclose <BAR> cclose <BAR> lclose<CR>a
nnoremap <silent> <C-c> :pclose <BAR> helpclose <BAR> cclose <BAR> lclose<CR>

" Toggle Defx
nnoremap <silent> <space>j :Defx -toggle<CR>
nnoremap <silent><space>J :Defx `expand('%:p:h')` -toggle<CR>

" Toggle Vista.vim
nnoremap <silent> <space>f :Vista!!<CR>

nnoremap <silent> <esc> :noh<return><esc>

" Search and Replace
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

nnoremap <F2> "zyiw:exe "Ack ".@z.""<CR>

" Make CTRL-P and CTRL-N behave like <Up> & <Down>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Toggle Spell Check
nnoremap <leader>ss :setlocal spell!<cr>
" Move to next bad word
nnoremap <leader>sn ]s
" Move to previous bad word
nnoremap <leader>sp [s
" Open Suggestion for bad word
nnoremap <leader>s? z=
" Add current word in dictionary
nnoremap <leader>sa zg

" Util remappings

" Reload config
nnoremap <silent> <leader>` :source ~/.vimrc<CR>:echo "Re-loaded config"<CR>

" Why not?
nnoremap ; :

" Like i_o & i_O but returns to normal mode
nnoremap <leader>o moo<ESC>k`o
nnoremap <leader>O moO<ESC>k`o

" Navigate with C-hjkl in insert mode
" inoremap <C-h> <C-o>h
" inoremap <C-j> <C-o>j
" inoremap <C-k> <C-o>k
" inoremap <C-l> <C-o>l

" Shifting: in visual mode, make shifts keep selection
vnoremap <C-d> <gv
vnoremap <C-t> >gv

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" }}}
" General: File type detection ---------------- {{{
augroup file_extensions
  autocmd!
  autocmd BufNewFile,BufRead,BufEnter *.zsh-theme,.zprofile set filetype=zsh
  autocmd BufNewFile,BufRead,BufEnter *.jsx set filetype=javascript
  autocmd BufRead poetry.lock set filetype=toml
  autocmd BufRead .pylintrc set filetype=dosini
augroup end

augroup filetype_specific_configs
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup end

" }}}
"  Plugin: Configure --------------------------- {{{

" Python highlighting
let g:python_highlight_space_errors = 0
let g:python_highlight_all          = 1

" Numbers
let g:enable_numbers = 0
let g:numbers_exclude               = ['defx']

" CtrlP
" let g:ctrlp_working_path_mode     = 'ca'

if executable('fd')
  let g:ctrlp_user_command          = 'fd --type=f --type=l --search-path=%s'
  let g:ctrlp_use_caching           = 0
else
  let g:ctrlp_custom_ignore         = {
        \   'dir' : '\.git$\|build$\|node_modules\|dist'
        \ }
  let g:ctrlp_user_command          = ['.git', 'cd %s && git ls-files']
endif

" Indent Lines Plugin settings
let g:indentLine_enabled         = v:false
let g:indentLine_char_list       = ['|', '¦', '┆', '┊']
let g:indentLine_color_gui       = '#44475a'
let g:indentLine_fileTypeExclude = ['defx']

" GitMessenger
" let g:git_messenger_include_diff = "current"

"  }}}
" Plugin: Lightline --------------------------- {{{
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'right': [ [ 'position' ],
  \              [ 'fileencoding', 'filetype' ],
  \              [ 'branch' ] ]
  \ },
  \ 'component': {
  \   'position': '%l/%L:%c'
  \ },
  \ 'component_function': {
  \   'branch': 'LightlineBranch'
  \ },
  \ 'enable': {
  \   'tabline': v:false
  \ }
  \ }

function! LightlineBranch()
  let branch = FugitiveHead()
  let prefix = branch != '' ? ' ' : ''

  return &filetype !~# '\v(help|defx)' ? prefix . branch : ''
endfunction
" }}}
" Plugin: Defx -------------------------------- {{{

function! s:defx_custom_init() abort
  if !exists('g:loaded_defx')
    return
  endif
  call defx#custom#option('_', {
        \ 'buffer_name'  : 'defx',
        \ 'columns'      : 'git       :indent:icon:filename',
        \ 'direction'    : 'topleft',
        \ 'ignored_files': join([
        \   '*.egg-info/',
        \   '*.pyc',
        \   '.git',
        \   '.mypy_cache',
        \   '.pytest_cache',
        \   '.python-version',
        \   '.tox',
        \   '.venv/',
        \   '.vim/',
        \   '__pycache__/',
        \   'node_modules/',
        \   'pip-wheel-metadata',
        \   'Session.vim',
        \], ','),
        \ 'root_marker'  : '[>]',
        \ 'search'       : '`expand("%:p")`',
        \ 'session_file' : tempname(),
        \ 'split'        : 'vertical',
        \ 'winwidth'     : 31,
        \ })
endfunction

function! s:defx_keybindings()
  nnoremap <silent><buffer><expr> <CR>
        \                               defx#is_directory() ?
        \                               defx#do_action('open_or_close_tree') :
        \                               defx#async_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> <C-c> defx#do_action('quit')

  nnoremap <silent><buffer><expr> <C-t> defx#do_action('open', 'tabe')
  nnoremap <silent><buffer><expr> <C-s> defx#do_action('multi', ['quit', ['open', 'split']])
  nnoremap <silent><buffer><expr> <C-v> defx#do_action('multi', ['quit', ['open', 'vsplit']])

  nnoremap <silent><buffer><expr> R     defx#do_action('redraw')
  nnoremap <silent><buffer><expr> q     defx#do_action('quit')
  nnoremap <silent><buffer><expr> H     defx#do_action('toggle_ignored_files')

  nnoremap <silent><buffer><expr> ma    defx#do_action('new_file')
  nnoremap <silent><buffer><expr> md    defx#do_action('remove')
  nnoremap <silent><buffer><expr> mm    defx#do_action('rename')

  nnoremap <silent><buffer><expr> u     defx#do_action('cd', '..')

  nnoremap <silent><buffer><expr> h     defx#do_action('resize', 31)
  nnoremap <silent><buffer><expr> l     defx#do_action('resize', 62)
endfunction

augroup configure_defx
  autocmd!
  autocmd VimEnter * call s:defx_custom_init()
  autocmd Filetype defx call s:defx_keybindings()
  autocmd BufLeave,BufWinLeave  \[defx\]* call defx#call_action('add_session')
  autocmd Filetype defx setlocal nonumber norelativenumber
augroup end

" }}}
"  Plugin: Buffet -------------------------- {{{

" Show cardinal indexes
let g:buffet_show_index = v:true

" Do not configure any key binding
let g:buffet_max_plug = 0

function! g:BuffetSetCustomColors()
" Default tabline colors
    hi! TabLineFill ctermbg=Magenta guibg=#909181
    hi! BuffetCurrentBuffer guibg=#00d75f guifg=#000000
    hi! BuffetBuffer guifg=#000000
    hi! BuffetTab guibg=#282a36 guifg=#6272a4
endfunction

" }}}
" Plugin: Autocompletion and LSP -------------- {{{
" Coc.vim


" Vista.vim
let g:vista_default_executive = 'lcn'
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "λ",
\   "variable": "ν",
\   "module"  : "ϟ",
\   "class"   : "ͼ",
\  }
let g:vista_echo_cursor_strategy = 'floating_win'

" Echodoc
let g:echodoc#enable_at_startup    = v:true
let g:echodoc#highlight_arguments  = "QuickScopePrimary"
let g:echodoc#highlight_identifier = "Identifier"
let g:echodoc#highlight_trailing   = "Type"
let g:echodoc#type                 = "floating"

" }}}
" Plugin: Ragtag ------------------------------ {{{

" Load mappings on every filetype
let g:ragtag_global_maps = 1

" Additional files for whice ragtag will initialize
augroup ragtag_config
 autocmd FileType javascript,typescript call RagtagInit()
augroup end

" }}}
" Config: Code Formatting --------------------- {{{

let g:vim_filetype_formatter_commands = {
      \ 'python': 'black -l 79 -q - | isort -',
      \ }

augroup formatting
  au!
  command! -nargs=0 Format :call CocAction('format')
  au Filetype * nnoremap <silent> <buffer> <leader>f :FiletypeFormat<cr>
  au Filetype * vnoremap <silent> <buffer> <leader>f :FiletypeFormat<cr>
augroup END
" }}}
" Config: Preview ----------------------------- {{{
function! _Preview()
  if &filetype ==? 'plantuml'
    exec 'PlantumlOpen'
  else
    exec 'Preview'
  endif
endfunction

command! PreviewCmd call _Preview()

nmap <silent><leader>p :PreviewCmd<CR>
" }}}
" Config: Abbreviations ----------------------- {{{
augroup python_ab
  au!
  au Filetype python iab ifmain if __name__ == '__main__':<CR>main()<ESC>
  au Filetype python iab ffaker factory.Faker()<ESC>
  au Filetype python iab pdis # pylint: disable= <ESC>
augroup END

augroup js_ab
  au!
  au Filetype javascript iab constcomp const = (props) => {<CR>}<ESC>Oreturn ()<ESC>k0ea
  au Filetype javascript iab cdbg console.debug('[DEBUG]')<ESC>F]a
augroup END
" }}}
" Config: Comment strings --------------------- {{{
augroup comment_str_config
  au!
  au BufNew,BufRead kitty.conf setlocal commentstring=#:\ %s
  au Filetype dosini setlocal commentstring=#\ %s
  au Filetype dosini setlocal comments=:#,:;
augroup END
" }}}
" Config: Ridiculous settings ----------------- {{{
augroup hide_column_on_test_files
  au!
  " au BufNew,BufRead test_*.py setlocal colorcolumn=
augroup END
" }}}
" Config: Custom functions -------------------- {{{
function! MakePhony(confirm)
  let line = getline('.')
  let target = matchstr(line, '^\zs\f*\ze:')

  if a:confirm
    let answer = confirm('Insert ".PHONY: ' . target . '"?', "&Yes\n&No", 1)
    if answer != 1
      return
    endif
  endif

  " Workaround to remove the auto-indentation
  execute "normal! O"
  execute "normal! a.PHONY: " . target
endfunction

command! -nargs=? MakePh call MakePhony(<args>)

augroup activate_make_phony_on_makefiles
  autocmd!
  autocmd Filetype make nnoremap <localleader>m :MakePh v:false<CR>
  autocmd Filetype make nnoremap <localleader>M :MakePh v:true<CR>
augroup end

" }}}
" General: Cleanup ---------------------------- {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure

" ShowCommand: turn off character printing to vim status line
set noshowcmd

" }}}
