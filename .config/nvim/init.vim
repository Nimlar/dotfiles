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
"Plug 'overcache/NeoSolarized'
" Solarized
Plug 'ishan9299/nvim-solarized-lua'

"testing part
"firenvim
"Plug 'glacambre/firenvim'

" floating terminal
Plug 'voldikss/vim-floaterm'

"tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }

" supercollider
Plug 'supercollider/scvim'

" autopairs
" Plug 'windwp/nvim-autopairs'

" transfert
Plug 'coffebar/transfer.nvim'

" auto sudo
Plug 'lambdalisue/suda.vim'

"Plug 'zbirenbaum/copilot.lua'
" or
Plug 'github/copilot.vim', { 'tag': 'v1.43.0' }
" from  1.44.0 need node.js > 20.x ! but 20.x need newe gcc :-(

" ibl => may need a better configuration I am missing when tab are use instead
" of space)
" Plug 'lukas-reineke/indent-blankline.nvim'

"  https://github.com/CopilotC-Nvim/CopilotChat.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

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

set colorcolumn=+1,80,100

set list
"set listchars=tab:▸\ ,eol:¬
"set listchars=tab:▸\ ,trail:▓
set listchars=tab:▸\ ,trail:▓,extends:>,precedes:<,nbsp:+

nnoremap <F5> :UndotreeToggle<CR>

colorscheme solarized

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
set sessionoptions=buffers,curdir,folds,help,localoptions,options,tabpages,winsize,terminal

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
autocmd VimLeave * nested call SaveSession(v:servername)
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

"open from current  file directory
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" for our weekly utf8 bullet
autocmd Filetype text setlocal comments+=fb:•
" for our weekly specific testwid(th
autocmd BufRead,BufNewFile /local/starkl/TODO/* setlocal textwidth=70
"autocmd BufRead,BufNewFile /local/starkl/TODO/* setlocal filetype=rst


"disable linter for C,C++ files
autocmd Filetype c ALEDisableBuffer
autocmd Filetype cpp ALEDisableBuffer
autocmd Filetype asm ALEDisableBuffer

let local_init=stdpath("config") ."/init." . substitute(system("hostname"), '\n', '', '') . ".vim"
if filereadable(local_init)
	execute "source" . local_init
end

"set efm=%A%trror (%m),%+P%f:%r,  line%l: %m
set clipboard+=unnamed


"FloatTerm
nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
" To simulate i_CTRL-R in terminal-mode:
tnoremap   <expr>     <C-R>   '<C-\><C-N>"'.nr2char(getchar()).'pi'

lua << EOF
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "python", "vim", "lua", "bash", "query",
                       "git_config",  "gitignore", "git_rebase", "gitcommit"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --    local max_filesize = 100 * 1024 -- 100 KB
    --    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --    if ok and stats and stats.size > max_filesize then
    --        return true
    --    end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
}
EOF

"" autopairs
"lua << EOF
"
"local npairs = require("nvim-autopairs")
"
"-- Expand pair only on enter key
"local Rule = require('nvim-autopairs.rule')
"npairs.setup {}
"
"npairs.clear_rules()
"
"for _,bracket in pairs { { '(', ')' }, { '[', ']' }, { '{', '}' } } do
"  npairs.add_rules {
"    Rule(bracket[1], bracket[2])
"      :end_wise(function() return true end)
"  }
"end
"EOF

"" Copilot.lua
"lua << EOF
"    require("copilot").setup({})
"EOF
"" Copilot vim
let g:copilot_workspace_folders = ["~/git/default_project"]
"let g:copilot_proxy = ""
"let g:copilot_proxy_strict_ssl = v:false

"
" indent_blankline
"lua << EOF
"local highlight = {
"    "CursorColumn",
"    "Whitespace",
"}
"require("ibl").setup {
"    indent = { highlight = highlight,
"              char = " ",
"              },
"    whitespace = {
"        highlight = highlight,
"        remove_blankline_trail = false,
"    },
"    scope = { enabled = true,
"              char = "│",
"           -- char = "▏",
"           -- char = "⎸",
"           -- char = "⎢"
"           -- char = "▏",
"           -- char = "⎢",
"              },
"
"}
"local hooks = require("ibl.hooks")
"hooks.register(hooks.type.VIRTUAL_TEXT, function(_, bufnr, row, virt_text)
"    local config = require("ibl.config").get_config(bufnr)
"    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
"    if line == "" then
"        for _, v in ipairs(virt_text) do
"            if v[1] == config.scope.char then
"                v[1] = "┊"
"            --    v[1] = "┆"
"            end
"            if v[1] == "▸" then
"                v[1] = " "
"            end
"
"        end
"    end
"    return virt_text
"end)
"EOF

" tranfer
lua << EOF
      require("transfer").setup({
        -- opts
      })
EOF


function! SshTo(dest, ...)
    augroup ssh
    autocmd! ssh
    let args = a:000[0:]
    for arg in args
        let l:autocmd_str = "autocmd ssh BufWritePost * silent! execute '! scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no % root@" . arg . ":" . a:dest . "'"
        "let l:autocmd_str = "autocmd ssh BufWritePost * silent! jobstart('scp % " . arg . ":" . a:dest . "', {'detach' : v:true})"
        echo l:autocmd_str
        execute l:autocmd_str
    endfor
endfunction

function! RsyncTo(src, dest, reinit, ...)
    augroup rsync
    if a:reinit
        autocmd! rsync
    endif
    let args = a:000[0:]
    for arg in args
        let l:autocmd_str = "autocmd rsync BufWritePost * silent! execute '! rsync --exclude=host_tools/ -av " . a:src . " " . arg . ":" . a:dest . "'"
        "let l:autocmd_str = "autocmd rsync BufWritePost * silent! jobstart('scp % " . arg . ":" . a:dest . "', {'detach' : v:true})"
        echo l:autocmd_str
        execute l:autocmd_str
    endfor
endfunction

" sudo
"let g:suda_smart_edit = 1

" https://github.com/CopilotC-Nvim/CopilotChat.nvim
lua << EOF
require("CopilotChat").setup()
EOF
