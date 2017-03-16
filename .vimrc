"filetype off
call pathogen#infect()



set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

let mapleader = ","


" Backups
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

set undodir=~/.vim/tmp/undo//
set undofile
set undoreload=10000

" Status line
set statusline=%F%m%r%h%w%=(%02n)\ (%{&ff}/%Y)\ (%l\/%L,%c)

" add for Syntaxtic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_c_include_dirs = ['../sttruc', 'src']

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
runtime macros/matchit.vim
nmap <tab> %
vmap <tab> %

" Soft/hard wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
"set colorcolumn=85

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

set list
"set listchars=tab:▸\ ,eol:¬
set listchars=tab:▸\ ,trail:·
"set listchars=tab:
nnoremap <F5> :GundoToggle<CR>

set background=dark
colorscheme solarized



"http://stackoverflow.com/questions/1005/getting-root-permissions-on-a-file-inside-of-vi
cmap w!! w !sudo tee >/dev/null %

"cscope search
"cnoreabbrev csf cs find e 

"associate config.in with makefile
au BufRead,BufNewFile config.in set filetype=make
au BufRead,BufNewFile *.mkf set filetype=make


"edit file in same directory with ,e
if has("unix")
    nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
else
    nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '\'<CR>
endif

"set font
if has('gui_running')
   set guifont=Source\ Code\ Pro\ Medium\ 10
endif

" Auto indent depending of file type
filetype plugin indent on

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
noremap <Leader>t :execute "!echo -e 'awful = require(\"awful\")\\nawful.tag.selected().name = \"" . v:servername . "\"' \| awesome-client" <cr>

" manage session
" Sessions restore
function! RestoreSession(name)
  if a:name != ""
    if "GVIM" !=? matchstr(a:name, "GVIM")
      if filereadable($HOME . "/.vim/sessions/" . a:name)
        execute 'source ' . $HOME . "/.vim/sessions/" . a:name
      end
    end
  end
endfunction

" Sessions save.
function! SaveSession(name)
  if a:name != ""
    if "GVIM" !=? matchstr(a:name, "GVIM")
      execute 'mksession! ' . $HOME . '/.vim/sessions/' . a:name
    end
  end
endfunction

" Restore and save sessions.
" if "GVIM" !=? matchstr(v:servername, "GVIM")
" test useless when this line are evaluated I suspect v:servername is
" not yet set..., so we check its value in the RestoreSession and
" SaveSession function
autocmd VimEnter * call RestoreSession(v:servername)
autocmd VimLeave * call SaveSession(v:servername)
"end


"swap two buffer
"from http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" Set tab size as I expect
"autocmd FileType * set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
autocmd FileType make nnoremap <leader><tab> :set tabstop=4 shiftwidth=4 noexpandtab <CR><esc>
autocmd FileType python nnoremap <leader><tab> :set tabstop=2 shiftwidth=2 expandtab <CR><esc>
autocmd FileType * nnoremap <leader><tab> :set tabstop=4 shiftwidth=4 expandtab <CR><esc>
" set linux specific tab
nnoremap <Leader><tab>k :set noexpandtab tabstop=8 shiftwidth=8 <CR><esc>

"format your code using [rustfmt][rfmt] every time a rust buffer is written.
"let g:rustfmt_autosave = 1
