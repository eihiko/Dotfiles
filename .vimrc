"Eliminates OS defaults
set nocompatible

"Pathogen package manager for vim
execute pathogen#infect()

"Unix fileformats only! (Fuck carriage returns!)
set ffs=unix

"Line numbers
"
set number

"Syntax highlighting
syntax on

"Force vim to use my 16 terminal colors >:D
let &t_Co=16

"Allow filetypes
filetype plugin on

"Auto-Indent per filetype
filetype indent plugin on

"Better command-line completion
set wildmenu
set wildmode=list:longest,full

"Show partial commands in the last line of the screen
set showcmd

"Highlight searches (use <C-L> to temporarily turn off highlighting; see the mapping of <C-L> below)
set hlsearch

"Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

"Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

"Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

"When adding a new line, keep the indentation of the previous line (filetype-specific indentation takes priority)
set autoindent

"Stop certain movements from always going to the first character of a line (deviates from Vi)
"set nostartofline

"Display the cursor position (numerically, in the status line)
set ruler

"Always display the status line
set laststatus=2

"Instead of failing a command due to unsaved files, ask to save.
set confirm

"Use visual notification instead of beeping when doing something wrong.
set visualbell

"This overrides the visualbell. Use it in conjunction with set visualbell to turn off beep and visual notifications
"set t_vb=

"Enable use of the mouse for all modes
set mouse=a

"Set the command window height to 2 lines, instead of 1
set cmdheight=2

"All tabs and indentations are 2 spaces by default.
"Pressing F9 toggles between the default and 8-column hardtabs.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
function TabToggle()
  if &expandtab
    set tabstop=3
    set shiftwidth=3
    set softtabstop=3
    set noexpandtab
  else
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab
  endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z

function ToUnix()
  update
  e ++ff=dos
  setlocal ff=unix
  w
endfunction

"Have VIM automatically set the title to the current file
set title
set titlestring=%F%r%m

"JJ = ESC
:imap jj <Esc>

:imap <S-Tab> <C-N>

:nmap <Enter> o<Esc>k 

"Autocomplete using Tab
"function! Tab_Or_Complete()
"  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"    return "\<C-N>"
"  else
"    return "\<Tab>"
"  endif
"endfunction
":inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_rust_checkers = ["cargo"]


"rustfmt settings
let g:rustfmt_autosave = 1
