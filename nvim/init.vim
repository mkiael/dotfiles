let vimrepodir = fnamemodify(resolve(expand('<sfile>:p')), ':h')"
let dotfilesdir = fnamemodify(vimrepodir, ':h')

"******************************************************************************
" Load plugins
"******************************************************************************
call plug#begin('~/.local/share/nvim/plugged')

Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'nelstrom/vim-visual-star-search'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'rhysd/vim-clang-format'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'johnor/neogoto'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'aklt/plantuml-syntax'
Plug 'iamcco/markdown-preview.nvim'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-system-copy'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'machakann/vim-highlightedyank'

call plug#end()

colorscheme gruvbox

set nowrap                     " don't wrap lines
set linebreak                  " break on words
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent                 " always set autoindenting on
set copyindent                 " copy the previous indentation on autoindenting
set number                     " always show line numbers
set relativenumber             " Use relative line numbers
set shiftround                 " use multiple of shiftwidth when indenting with '<' and '>'
set hidden                     " When on a buffer becomes hidden when it is abandoned
set wildmenu                   " Turn on WiLd menu
set wildmode=longest,list,full " Bash style completion
set sidescroll=5               " (ss) the minimal number of columns to scroll horizontally
set diffopt+=vertical          " use veritcal diffs, usefull for fugitive
set formatoptions-=cro         " turn off continuation of comments to next line
set scrolloff=5                " always show x lines below/above the cursor
set showbreak=↪                " show symbol before wrapped lines when wrap is on
set colorcolumn=80             " Show vertical line at 80

" Vim can highlight whitespaces for you in a convenient way:
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Tabs
set tabstop=3      " a tab is three spaces
set shiftwidth=3   " number of spaces to use for autoindenting
set softtabstop=3
set expandtab
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop

" History
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set noswapfile

" Show command in bottom right portion of the screen
set showcmd

" Leader
set timeoutlen=500

" No gui elements
set guioptions=

set splitright
set splitbelow

" Searching
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

" Info
set showmode

set completeopt=menuone,noinsert,noselect " Show completion menu if only one match, force user to select

autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

"******************************************************************************
" Mappings
"******************************************************************************
" Exit insert mode with jj
imap jj <Esc>

" Next prev buffer
nnoremap <silent> <TAB> :bn<CR>
nnoremap <silent> <S-TAB> :bp<CR>

" Switch between the most recently used buffers
nnoremap ,, <c-^>

" Save all files
noremap <Leader>s :wall<CR>

" Disable highlight
noremap <silent> <Leader>hs :silent :nohlsearch<CR>

" Close current buffer and keep layout
nnoremap <Leader>q :Sayonara!<cr>
" Close current buffer and windows
nnoremap <Leader>Q :Sayonara<cr>

" Allows you to easily substitute the current word and all its occurrences.
nnoremap <Leader>sw :%s/\<<C-r><C-w>\>/
vnoremap <Leader>sw y:%s/<C-r>"/

" Allows you to easily change the current word and all occurrences to something
" else. The difference between this and the previous mapping is that the mapping
" below pre-fills the current word for you to change.
nnoremap <Leader>cw :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cw y:%s/<C-r>"/<C-r>"
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

nnoremap <silent>s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent>s* "sy:let @/=@s<CR>cgn

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Ctrl-n/m deletes blank line below/above, and Alt-n/m inserts.
"nnoremap <silent><C-n> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-m> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-n> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-m> :set paste<CR>m`O<Esc>``:set nopaste<CR>

"******************************************************************************
" Grepper
"******************************************************************************
let g:grepper={}
let g:grepper.tools=["rg"]

nnoremap <Leader>R
         \ :let @s='\<'.expand('<cword>').'\>'<CR>
         \ :Grepper -cword -noprompt<CR>
         \ :cfdo %s/<C-r>s// \| update
         \ <Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

"******************************************************************************
" Airline
"******************************************************************************
let g:airline#extensions#tabline#enabled=1   " Smarter tab line

"******************************************************************************
" EasyMotion
"******************************************************************************
let g:EasyMotion_do_mapping = 0 " Disable default mappings

nmap <space>f <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 0

map <space>l <Plug>(easymotion-lineforward)
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)
map <space>h <Plug>(easymotion-linebackward)
nmap <space>w <Plug>(easymotion-overwin-w)
nmap s <Plug>(easymotion-overwin-f2)

let g:EasyMotion_keys = 'asdfghjkl,qwertyuiopzxcvbnmj'

"******************************************************************************
" fzf
"******************************************************************************
function! ProjectRoot()
  let current_path = expand('%:p:h')

  if current_path =~ "^term:/" || current_path =~ "^fugitive:/" || !isdirectory(current_path)
     let current_path = getcwd()
  endif

  let gitroot = systemlist('git -C ' . current_path . ' rev-parse --show-toplevel')[0]
  if !v:shell_error
     return gitroot
  endif
endfunction

" Calls ag to get the files in the current project root
" Project root is the file's directory or the top level git directory
command! AgFiles call fzf#run(fzf#wrap(
         \ {'source': 'ag --hidden --ignore .git --ignore .hg -g ""',
         \         'dir': ProjectRoot(),
         \         'options': '--prompt "AgFiles> "'}
         \ ))


let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <C-p> :Files<CR>
map <leader>b :Buffers<CR>

nnoremap <leader>r :Rg<CR>
nnoremap <leader>rr :RG<CR>
nnoremap <leader>rc :RGCpp<CR>
nnoremap <silent> <leader>rw :RG <C-R><C-W><CR>
vnoremap <silent> <leader>rw :RG <C-R><CR>
nnoremap <silent> <leader>rwc :RGCpp <C-R><C-W><CR>
vnoremap <silent> <leader>rwc :RGCpp <C-R><CR>

nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen, glob)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s %s || true'
  let initial_command = printf(command_fmt, a:glob, shellescape(a:query))
  let reload_command = printf(command_fmt, a:glob,'{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0, '')
command! -nargs=* -bang RGCpp call RipgrepFzf(<q-args>, <bang>0, '-g "*.c" -g "*.cpp" -g "*.h" -g "*.hpp"')

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Use fzf for q: and q/
nnoremap q: :History:<CR>
nnoremap q/ :History/<CR>

"******************************************************************************
" Nerdtree
"******************************************************************************
nmap <Leader>n :NERDTreeToggle<CR>
nmap <silent> <F2> :NERDTreeFind<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

"******************************************************************************
" NERDCommenter
"******************************************************************************
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1

"******************************************************************************
" Neogoto
"******************************************************************************
nmap <silent> <Localleader>sf :NeogotoSwitch<cr>
nmap <silent> <Localleader>st :NeogotoTest<cr>
nmap <silent> <Localleader>sl :NeogotoSwitchRight<cr>
nmap <silent> <Localleader>sh :NeogotoSwitchLeft<cr>

"******************************************************************************
" lsp
"******************************************************************************
call luaeval('require("jlsp_config")')

command! LspRestart :lua vim.lsp.stop_client(vim.lsp.get_active_clients())
command! LspLog execute ':edit ' . v:lua.vim.lsp.get_log_path()
command! LspRename :lua vim.lsp.buf.rename()
command! LspActiveClients :lua print(vim.inspect(vim.lsp.get_active_clients()))
nnoremap <silent> g= <cmd>lua vim.lsp.buf.formatting()<CR>
xnoremap <silent> g= <cmd>lua vim.lsp.buf.range_formatting()<CR>

nnoremap ]w <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap [w <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

nnoremap <leader>f <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>fd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>fi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>fh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>fr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>fx <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <localleader>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <localleader>fs <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <localleader>ft <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <localleader>g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <localleader>gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Avoid showing message extra message when using completion
set shortmess+=c

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip'
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_ignore_case = 1

inoremap <silent><expr> <c-space> completion#trigger_completion()

"******************************************************************************
" tree-sitter
"******************************************************************************
lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "i",
      scope_incremental = "+",
      node_decremental = "-",
    },
  },
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF

"******************************************************************************
" vim-rooter
"******************************************************************************
let g:rooter_manual_only = 1

"******************************************************************************
" UltiSnip
"******************************************************************************
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=[vimrepodir.'/ultisnips']
