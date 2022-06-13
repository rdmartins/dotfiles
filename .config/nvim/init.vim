exec 'so '.stdpath('config').'/plugins.vim'

colorscheme dracula
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
set colorcolumn=80
set cursorline
set expandtab
set gdefault
set guifont=Fira\ Code\ 12
set hidden
set hlsearch
set ignorecase
set list
set noshowmode
set noswapfile
set nowrap
set number
set relativenumber
set shiftwidth=2
set showtabline=2
set smartcase
set softtabstop=2
set spelllang=pt,en
set splitbelow
set splitright
set tabstop=2
set wildignore +=.git
set wildignore +=node_modules

" Mappings
let mapleader = ','
let maplocalleader = '\'
nmap <Leader>ev :exe 'edit '.stdpath('config').'/init.vim'<CR>
nmap <Leader>ep :exe 'edit '.stdpath('config').'/plugins.vim'<CR>
nmap <Leader>sc :SClose<cr>
nmap <Leader>ft :setfiletype
nmap <silent> <Leader>q :bd<CR> :echo 'Buffer deleted'<CR>
imap AA <C-O>A
imap II <C-O>I
nmap <Leader>g :e#<CR>
" Airline
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9
nmap <Leader>b <Plug>AirlineSelectPrevTab
nmap <Leader>f <Plug>AirlineSelectNextTab
" Asyncopmplete
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"imap <c-space> <Plug>(asyncomplete_force_refresh)

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_skip_empty_sections = 1

" ALE
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': 'prettier, eslint',
  \ 'json': 'prettier',
  \ 'yaml': 'prettier',
  \}

" CSV
let g:csv_autocmd_arrange = 1
let g:csv_autocmd_arrange_size = 1024*1024

" Ctrlp
let g:ctrlp_open_new_file = 'r'

" Deoplete
let g:deoplete#enable_at_startup = 1

" Gitgutter
let g:gitgutter_max_signs = 1000

" Rust
let g:rustfmt_autosave = 1

" Startify
let g:startify_session_persistence = 1
let g:startify_lists = [
  \ { 'type': 'sessions', 'header': ['   Sessions'] },
  \ { 'type': 'files',    'header': ['   MRU']      },
  \ ]
let g:startify_custom_header = [
  \ '   ██████╗ ██████╗ ███╗   ███╗ █████╗ ██████╗ ████████╗██╗███╗   ██╗███████╗ ',
  \ '   ██╔══██╗██╔══██╗████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██║████╗  ██║██╔════╝ ',
  \ '   ██████╔╝██║  ██║██╔████╔██║███████║██████╔╝   ██║   ██║██╔██╗ ██║███████╗ ',
  \ '   ██╔══██╗██║  ██║██║╚██╔╝██║██╔══██║██╔══██╗   ██║   ██║██║╚██╗██║╚════██║ ',
  \ '   ██║  ██║██████╔╝██║ ╚═╝ ██║██║  ██║██║  ██║   ██║   ██║██║ ╚████║███████║ ',
  \ '   ╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝ ',
  \ ]

" Autogroups
augroup init
  au!
  au BufWritePost init.vim source %
  au BufWritePost plugins.vim source %

  au WinEnter * set cul
  au WinLeave * set nocul
augroup END
