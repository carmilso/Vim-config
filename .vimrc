set number              " Show line number.
set expandtab           " Convert tabs to spaces.
set shiftwidth=2        " Number of spaces for each step of (auto)indent <<, >>.
set tabstop=2           " Number of spaces when indent with <Tab>.
set autoindent          " Copy indent from current line when starting a new line.
set laststatus=2        " Show all possible info in the status line.
set t_Co=256            " Enable 256 colors.
set wildmenu            " Command-line completion operates in an enhanced mode.
set wildmode=full       " Complete the next full match.
set hlsearch            " Highlight matches when there is a previous search.
set incsearch           " Show matches at the same time pattern is typed.
set ignorecase          " Ignore case in search patterns.
set smartcase           " Override ignorecase if the search pattern contains upper case characters.
set splitright          " Put new window right when using :vsplit.
set updatetime=1000     " Milliseconds in which to write swap file.
set pastetoggle=<f5>    " Key sequence that toggles the 'paste' option.
set scrolloff=3         " Number of screen lines to keep above and below the cursor.

syntax on               " Enable syntax.

" Init Vundle config.

set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

let g:vundle_default_git_proto = 'git'

" Let Vundle manage Vundle, required.
Plugin 'VundleVim/Vundle.vim'

Plugin 'jiangmiao/auto-pairs'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'mhinz/vim-startify'
Plugin 'alvan/vim-closetag'

call vundle#end()

filetype plugin indent on

" End Vundle config.

colorscheme spacegray   " Name of the currently active color scheme.

nnoremap <C-l> :nohlsearch<CR><C-l>   " Map <Ctrl-l> to disable highlight.
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]' " Map gp to start visual mode over the last pasted text.

runtime macros/matchit.vim   " Enable % over xml tags.

" Persistent undo.
set undofile                   " Save undo's after file closes
set undodir=$HOME/.vim/undo    " where to save undo histories
set undolevels=100             " How many undos
set undoreload=100             " number of lines to save for undo

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  %s/\($\n\s*\)\+\%$//e
  call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()  " Autotrim file before saving it.

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  " Disable automatic comment insertion.

autocmd Filetype tex setlocal updatetime=500  " Save swap file each 500 milliseconds when editing a tex file.

" Some buffer maps.
map <Tab>h :bprev!<CR>
map <Tab>l :bnext!<CR>
map <Tab>d :bdelete!<CR>
map <Tab>H :bfirst!<CR>
map <Tab>L :blast!<CR>
map <Tab>b :<C-U>exe 'buffer' v:count<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'  " Expand editing file path with %%
map <Leader>r :set relativenumber!<CR>  " Toggle relativenumber with \p

" Gitgutter plugin customization.
highlight GitGutterAdd ctermfg=82
highlight GitGutterChange ctermfg=190
highlight GitGutterDelete ctermfg=9

" Closetag plugin customization.
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.hbs"

filetype plugin on    " Enable loading the plugin files for specific file types.

" NERD plugin customization.
let g:NERDSpaceDelims = 1
let NERDTreeQuitOnOpen = 0
let g:NERDDefaultAlign = 'left'
map <F2> :NERDTree<CR>
map <F3> :NERDTreeClose<CR>

" CtrlP plugin customization
let g:ctrlp_map = '<leader>p'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'rw'
set wildignore+=*/tmp/*,*.so,*.swp,*/node_modules/*

" Begin Syntastic plugin customization.

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_w = 1

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_sh_shellcheck_args = ['-x']

let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '⚠'

let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" End Syntastic plugin customization.

" Startify plugin customization.
let g:startify_bookmarks = [ {'v': '~/.vimrc'}, {'z': '~/.zshrc'} ]
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 0
let g:startify_list_order = ['sessions', 'dir', 'files', 'bookmarks', 'commands']

" Begin Airline plugin customization.

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#branch#enabled = 1

let g:airline_powerline_fonts=1

let g:airline_theme='badwolf'

" End Airline plugin customization.

" Autopairs plugin customization.
let AutoPairsMultilineClose = 0

" You can get the information about the windows with first argument as a dictionary.
"
"   KEY              VALUE                      AVAILABILITY
"-----------------------------------------------------------------------------------
"   vcs            : vcs type (e.g. 'git')   -> all hooks
"   edit_winnr     : winnr of edit window    -> ditto
"   edit_bufnr     : bufnr of edit window    -> ditto
"   diff_winnr     : winnr of diff window    -> ditto
"   diff_bufnr     : bufnr of diff window    -> ditto
"   status_winnr   : winnr of status window  -> all hooks except for 'diff_open' hook
"   status_bufnr   : bufnr of status window  -> ditto

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end

    " Scroll the diff window from insert mode by half a screen
    " Map <C-j> and <C-k>
    imap <buffer><C-e> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-y> <Plug>(committia-scroll-diff-up-half)
    " Scroll the diff window from insert mode by a screen
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)

endfunction
