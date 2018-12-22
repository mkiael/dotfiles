set shellslash

" Store the path to this file
let vimrepodir = fnamemodify(resolve(expand('<sfile>:p')), ':h')"
let dotfilesdir = fnamemodify(vimrepodir, ':h')

" Include this directory for runtimepath in order to load plugins later
let &runtimepath.=','.escape(vimrepodir, '\,')

"******************************************************************************
" Load plugins
"******************************************************************************
call plug#begin('~/.local/share/nvim/plugged')

Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'wesQ3/vim-windowswap'
" Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer', 'frozen': 1 }
" Plug 'lyuts/vim-rtags'
Plug 'derekwyatt/vim-fswitch'
" Plug 'SirVer/ultisnips'

" Plug 'Chiel92/vim-autoformat'
" Plug 'johnor/vim-sort-motion'
" Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign', 'LiveEasyAlign'] }
" Plug 'junegunn/vim-slash'
" Plug 'justinmk/vim-gtfo'
" Plug 'justinmk/vim-sneak'
" Plug 'lambdalisue/vim-gita', { 'on': ['Gita'] }
" Plug 'majutsushi/tagbar'
Plug 'matze/vim-move'
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" Plug 'michaeljsmith/vim-indent-object'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-unimpaired'
" Plug 'vim-scripts/ReplaceWithRegister'
" Plug 'vim-scripts/ReplaceWithSameIndentRegister'
" Plug 'wellle/targets.vim'
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-clang-format'

" Color scheme
Plug 'ml85/papercolor-theme'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

" My plugins
Plug 'ml85/neortags'

call plug#end()

set background=dark

" Enabled Solarized color scheme
"colorscheme PaperColor
"colorscheme molokai
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

" Disable highlight
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

"******************************************************************************
" Some utility functions
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

  let hgroot = systemlist('hg root')[0]
  return v:shell_error ? current_path : hgroot
endfunction

"******************************************************************************
" Airline
"******************************************************************************
let g:airline#extensions#tabline#enabled=1   " Smarter tab line
let g:airline_powerline_fonts=1

"******************************************************************************
" Fzf
"******************************************************************************
" From: https://github.com/junegunn/fzf/wiki/Examples-(vim)
function! s:tags_sink(line)
   let parts = split(a:line, '\t\zs')
   let excmd = matchstr(parts[2:], '^.*\ze;"\t')
   execute 'silent e' parts[1][:-2]
   let [magic, &magic] = [&magic, 0]
   execute excmd
   let &magic = magic
endfunction

function! s:tags()
   if empty(tagfiles())
      echohl WarningMsg
      echom 'Preparing tags'
      echohl None
      call system('ctags -R')
   endif

   call fzf#run({
   \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
   \            '| grep -v -a ^!',
   \ 'options': '+m -d "\t" --with-nth 1,2,4,3 -n 1,2,3 --tiebreak=index --prompt "TagNames> "',
   \ 'down':    '40%',
   \ 'sink':    function('s:tags_sink')})
endfunction

command! TagNames call s:tags()

""""""""""""""""""""""""""""""
" Call ag directly
command! -nargs=+ -complete=file AgRaw call fzf#vim#ag_raw(<q-args>)

" Calls ag to get the files in the current project root
" Project root is the file's directory or the top level git directory
command! AgFiles call fzf#run(fzf#wrap(
         \ {'source': 'ag --hidden --ignore .git --ignore .hg -g ""',
         \         'dir': ProjectRoot(),
         \         'options': '--prompt "AgFiles> "'}
         \ ))

nnoremap <C-p> :AgFiles<cr>
nnoremap <leader>lg :GFiles --cached --others --exclude-standard<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>t :TagNames<cr>
nnoremap <leader>gt :Tags '<c-r><c-w><cr>

nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Use fzf for q: and q/
nnoremap q: :History:<CR>
nnoremap q/ :History/<CR>

"******************************************************************************
" EasyMotion
"******************************************************************************
let g:EasyMotion_do_mapping = 0 " Disable default mappings

nmap <space>f <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)
map <space>w <Plug>(easymotion-w)

let g:EasyMotion_keys = 'asdfghjkl,qwertyuiopzxcvbnmj'

"******************************************************************************
" Nerdtree
"******************************************************************************
nmap <Leader>n :NERDTreeToggle<CR>
nmap <silent> <F2> :NERDTreeFind<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

"******************************************************************************
" EditorConfig
"******************************************************************************
let g:EditorConfig_core_mode = 'external_command'
"
"******************************************************************************
" neortags
"******************************************************************************
noremap <Leader>rf :NeortagsFindReferences<CR>
noremap <Leader>rv :NeortagsFindVirtuals<CR>
noremap <Leader>rj :NeortagsJumpTo<CR>

"******************************************************************************
" Ale
"******************************************************************************
"let g:ale_linters = { 'javascript': ['standard'], 'c': [], 'c++': [] }
"let g:airline#extensions#ale#enabled = 1

"******************************************************************************
" YouCompleteMe
"******************************************************************************
" let g:ycm_global_ycm_extra_conf = vimrepodir.'/ycm_extra_conf.py'

" let g:ycm_python_binary_path = 'python3'
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_extra_conf_globlist = ['~/dev/*']

" nnoremap <Leader>fd :YcmDiags<CR>
" nnoremap <Leader>fc :YcmCompleter GoToDeclaration<CR>
" nnoremap <Leader>fg :YcmCompleter GoToDefinition<CR>
" nnoremap <Leader>f  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap <Leader>h  :YcmCompleter GoToInclude<CR>
" nnoremap <Leader>fx :YcmCompleter FixIt <CR>
" nnoremap <Leader>ft :YcmCompleter GetType <CR>
" nnoremap <Leader>fh :YcmCompleter GetDoc <CR>

"******************************************************************************
" FSwitch
"******************************************************************************
au! BufEnter *.cpp let b:fswitchdst = 'h' | let b:fswitchlocs = 'reg:/src/include/'
au! BufEnter *.h let b:fswitchdst = 'cpp,hpp' | let b:fswitchlocs = 'reg:/include/src/,./,./detail'

nmap <silent> <Leader>of :FSHere<CR>

"******************************************************************************
" UltiSnip
"******************************************************************************
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=[vimrepodir.'/ultisnips']

"******************************************************************************
" Clang format
"******************************************************************************
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
