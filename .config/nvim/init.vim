" update plugin manager with
" PlugUpgrade
"
" install/update plugins
"  PlugUpdate

"[[ Plug lines:
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" git info in the file
Plug 'airblade/vim-gitgutter'

" syntastic remplacement
Plug 'dense-analysis/ale'

" Undo tree
Plug 'mbbill/undotree'

" NeoSolarized
Plug 'overcache/NeoSolarized'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"PLUG lines ]]

set scrolloff=3
set visualbell
set cursorline

let mapleader = ","

" Backups
let &backupdir=stdpath('state') . '/backup//' " backups
let &directory=stdpath('state') . '/swap//'   " swap files
set backup                        " enable backups

let &undodir=stdpath('state') . '/undo//'
set undofile
set undoreload=10000

" Status line
set statusline=%F%m%r%h%w%=(%02n)\ (%{&ff}/%Y)\ (%l\/%L,%c)

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
map <leader><space> :noh<cr>
nmap <tab> %
vmap <tab> %

" Soft/hard wrapping
set wrap
set textwidth=79
"keep default set formatoption=jcroql

"force using hjkl
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

set list
"set listchars=tab:▸\ ,eol:¬
"set listchars=tab:▸\ ,trail:▓
set listchars=tab:▸\ ,trail:▓,extends:>,precedes:<,nbsp:+

nnoremap <F5> :UndotreeToggle<CR>

colorscheme NeoSolarized
set background=dark

"http://stackoverflow.com/questions/1005/getting-root-permissions-on-a-file-inside-of-vi
cmap w!! w !sudo tee >/dev/null %
"
"associate config.in with makefile
autocmd BufRead,BufNewFile config.in set filetype=make
autocmd BufRead,BufNewFile *.mkf set filetype=make

" Auto indent depending of file type
filetype plugin indent on
"
" higlight without moving cursor (in fact change search bufer)
" from http://superuser.com/a/255120/30031
" The leader defaults to backslash, so (by default) this
" maps \* and \g* (see :help Leader).
" These work like * and g*, but do not move the cursor and always set hls.
" my leader is ',' so ,* ,g*
noremap <Leader>* :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>
noremap <Leader>g* :let @/ = expand('<cword>')\|set hlsearch<C-M>
" in same superuser part :match command seem interresting, need to investigate

" rename current tab with servername
noremap <Leader>t :execute "!echo -e 'awful = require(\"awful\")\\nawful.tag.selected().name = \"" . fnamemodify(v:servername,':p:h:t') . "\"' \| awesome-client" <cr>

" manage session
let sessions_path=stdpath('state') . '/sessions/'

"default     blank,buffers,curdir,folds,help,                     tabpages,winsize,terminal
set sessionoptions=buffers,curdir,folds,help,localoptions,options,tabpages,winsize

" Sessions restore
function! RestoreSession(name)
  let l:session = fnamemodify(a:name, ":p:h:t")
  if match(l:session, '^\d\+$') == -1
    if filereadable(g:sessions_path . l:session)
      execute 'source ' . g:sessions_path . l:session
      "if bufexists(
    end
  end
endfunction

" Sessions save.
function! SaveSession(name)
  let l:session = fnamemodify(a:name, ":p:h:t") 
  if match(l:session, '^\d\+$') == -1
    execute 'mksession! ' . g:sessions_path . l:session
  end
endfunction

" Restore and save sessions.
autocmd VimEnter * nested call RestoreSession(v:servername)
autocmd VimLeave * call SaveSession(v:servername)
"end
"
" Set tab size as I expect
"autocmd FileType * set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
set tabstop=4 shiftwidth=4 expandtab
autocmd FileType make set tabstop=4 shiftwidth=4 noexpandtab textwidth=0
autocmd FileType rust set tabstop=4 shiftwidth=4 noexpandtab textwidth=0
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab textwidth=0
" set linux specific tab
nnoremap <Leader><tab>k :set noexpandtab tabstop=8 shiftwidth=8 <CR><esc>

" from Yann
" align at previous open (
set cinoptions=:0,l1,t0,g0,(0

let local_init=stdpath("config") ."/init." . substitute(system("hostname"), '\n', '', '') . ".vim"
if filereadable(local_init)
	execute "source" . local_init
end
