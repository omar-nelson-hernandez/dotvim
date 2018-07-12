"-------------------------------------------------------------------------------
" Useful information
"
" convert spaces to tabs first
" set noexpandtab
"set tabstop=4
" set shiftwidth=4
" retab!
" " now you have tabs instead of spaces, so insert spaces according to
" " your new preference
" set tabstop=2
" set shiftwidth=2
" set expandtab
" retab!
" "
"-------------------------------------------------------------------------------
" To do {{{
" Fix issue where plugins overwrite the colorscheme, putting the colorscheme in after/colors doesn't work
" because pathogen loads the plugins even after the after/ folder
" }}}

" General options {{{
set nocompatible                                           " Resets all settings, make vim not behave like vi. First line of config file
runtime bundle/vim-pathogen/autoload/pathogen.vim          " Source pathogen
execute pathogen#infect()
execute pathogen#helptags()
filetype indent plugin on                                  " Enable automatic indentation, plugins and filetype detection
let mapleader=","                                          " Change the map leader, \ is very hard to press
set wildmenu                                               " Command line completition
set foldmethod=marker                                      " Fold on markers
set showcmd                                                " Show commands on the last line of the screen
set hlsearch                                               " Set highlight search
set nomodeline                                             " Disables the line that configures vim per file
set ignorecase                                             " Use case insensitive search, except when using capital letters
set smartcase                                              " Use case insensitive search, except when using capital letters
set backspace=indent,eol,start                             " Backspace over indent, eol and start of insert action
set autoindent                                             " Use indenting from file when no specific indenting is available
set nostartofline                                          " Don't allow commands to return to the start of the line
set ruler                                                  " Display line,col
set laststatus=2                                           " Always show status line
set confirm                                                " Ask for confirmation for unsaved changes
set mouse=a                                                " Enable use of mouse for all modes
set cmdheight=2                                            " Avoids "Press <Enter> to continue "
set number                                                 " Display line numbers
set notimeout ttimeout ttimeoutlen=200                     " Timeout on keycodes but not on mappings
set showmode                                               " Show the mode the editor is currently in
set showmatch                                              " Show matching brackets.
set incsearch                                              " Incremental search
set clipboard=unnamed                                      " Use a global clipboard
set encoding=utf-8
scriptencoding utf-8
set listchars=eol:$,trail:•,nbsp:~,tab:\|>                 " Define special characters
set list                                                   " Mark special characters
set formatoptions-=r                                       " Don't add comment after hitting <Enter>
set formatoptions-=o                                       " Don't add comment after hitting 'o'
set viewoptions=folds,options,cursor,unix,slash            " Better Unix / Windows compatibility
set history=1000                                           " Store a ton of history (default is 20)
set shellslash                                             " Replaces all back slashes with forward slashes
set cursorline                                             " Enable the cursor line
set relativenumber                                         " Enable numbers relative to the current line
set virtualedit=block                                      " Enable block editing past line end
" }}}

" Wrapping options {{{
set textwidth=0                                            " Disable line wrapping
set wrapmargin=0                                           " Disable line wrapping
set nowrap                                                 " Don't wrap lines, I don't like it
set formatoptions-=c                                       " Do not autowrap comments after textwidth
" }}}

" Indentation options {{{
set shiftwidth=2                                           " Size of tab
set softtabstop=2                                          " Size of tab
set tabstop=2                                              " Size of tabs
set expandtab                                              " Tabs expanded to spaces
set smartindent                                            " Smart indent enabled
" }}}

" Split preferences {{{
set splitbelow
set splitright
" }}}

" Color scheme settings {{{
syntax on
set t_Co=256
colorscheme tir_black
" }}}

" Setup directories for backup, swap and undo {{{
function! EnsureDirExists( dir )
  if !isdirectory( a:dir )
    if exists( "*mkdir" )
      call mkdir( a:dir, 'p' )
      echo "Created directory: " . a:dir
    else
      echo "Please create directory: " . a:dir
    endif
  endif
endfunction

call EnsureDirExists( $HOME . '/.vimbackups' )
call EnsureDirExists( $HOME . '/.vimswap' )
call EnsureDirExists( $HOME . '/.vimundo' )

if has("win32")
  set backupdir=~\\.vimbackups//,.
  set undodir=~\\.vimundo//,.
  set directory=~\\.vimswap//,.
else
  if has("unix")
    set backupdir=~//.vimbackups//,.
    set undodir=~//.vimundo//,.
    set directory=~//.vimswap//,.
  endif
endif

set backup
set undofile
set swapfile
"}}}

" Mappings {{{

" Mapping <FX> keys {{{
" Use F2 to cycle forward through the bookmarks
nmap <F2> ']
" Use F2 to cycle backward through the bookmarks
nmap <S-F2> '[
" Use Ctrl + F2 to toogle a bookmark
nmap <C-F2> m.
" Use <F3> to toggle between 'paste' and 'nopaste'
nnoremap <F3> :set invpaste paste?<CR>
" Obtain the name of the current file
nnoremap <F4> :let @* = expand("%:p")<CR>
map <F5> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
" Beautify line
nnoremap <F8> :call Beautify()<CR>
" Convert all tabs to spaces
nnoremap <F9> :call Tabs2Spaces()<CR>
" Toggle indent guides
nnoremap <F12> <Plug>IndentGuidesToggle
" }}}
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Block comment (double slash)
nnoremap <C-z> i/**/<ESC>h78i*<ESC>a<CR> * <CR><ESC>77a*<ESC>

" Block comment (Number symbol)
nnoremap <C-x> I#<ESC>79a-<ESC>a<CR># <CR><ESC>I#<ESC>79a-<ESC>k
" }}}

" Functions {{{
function! Beautify()
  " Add space after opening bracket
  s/(\s*/( /eg
  " Add space before closing bracket
  s/\s*)/ )/eg
  " Remove spaces in empty brackets
  s/(\s*)/()/eg
  " Fix spaces around brackets
  "s/\s*(\s*\(.\{-}\)\s*)\s*/( \1 )/eg
  " Fix empty brackets
  s/(\s*)/()/eg
  " Fix space after comma
  s/,\s*/, /eg
  " Fix spaces around operators
  s,\s*\(+\|-\|*\|/\|>\|<\|=\|!\|\)=\s*, \1= ,eg
  " Fix space after opening square bracket
  s/\[\s*/\[ /eg
  " Fix space before closing square bracket
  s/\s*\]/ \]/eg
  " Remove spaces in empty square brackets
  s/\[\s*\]/\[\]/eg
endfunction
function! Tabs2Spaces()
" Convert spaces to tabs first
  set noexpandtab
  set tabstop=4
  set shiftwidth=4
  retab!
" Now you have tabs instead of spaces, so insert spaces according to your new preference
  set tabstop=2
  set shiftwidth=2
  set expandtab
  retab!
" Remove trailing spaces
  s/\s\+$//e
endfunction
" }}}

" NetRW settings {{{
" Slim list
"   = 0: thin listing (one file per line)
"   = 1: long listing (one file per line with time
"        stamp information and file size)
"   = 2: wide listing (multiple files in columns)
"   = 3: tree style listing
let g:netrw_liststyle = 1
" Split vertically new files
"   =0: re-using the same window
"   =1: horizontally splitting the window first
"   =2: vertically   splitting the window first
"   =3: open file in new tab
"   =4: act like "P" (ie. open previous window)
let g:netrw_browse_split = 3
" Split windows is 20%
let g:netrw_winsize = 20
" 0 use 1 ignore
let g:netrw_ignorenetrc = 1
" let g:netrw_scp_cmd           = 'psftp'
let g:netrw_sftp_cmd = 'psftp'
" }}}

" CtrlP plugin settings {{{
let g:ctrlp_clear_cache_on_exit = 0                        " Don't allow the cache to be cleared when the sessions exits
let g:ctrlp_show_hidden = 1                                " Scan for hidden files/folders
" Modify scanning rules
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|vimbackups|vimswap|vimundo)$',
  \ 'file': '\v\.(exe|so|dll|doc|png)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }
" }}}

" Cannot use automatic removal of trailing spaces in the office because it
" will mess up existing sources
"autocmd BufWritePre * %s/\s\+$//e

" Text templates {{{
command! InsCodixHeader :read ~/.vim/text-templates/codix-header.txt
command! InsCodixFooter :normal i$Log: $<ESC>
command! InsKshHeader :normal i#!/usr/bin/env ksh<CR><ESC>
" }}}

" Autocommands {{{
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Except when the filetype is a git commit
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
" }}}

" NerdCommenteer settings {{{
let g:NERDSpaceDelims = 1
" }}}
