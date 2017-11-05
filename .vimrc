version 6.0

" key mappings
map  <F3>    <Plug>ShowFunc

" mappings related to print_r
imap <C-P>   <Esc><C-P>
map  <C-O>   yOprintf("<pre>In %s, @LINE %s, %s = \n%s\n</pre>", __FILE__, __LINE__, '<Esc>pa', print_r(<Esc>pa, true));<Esc>^
nmap <C-P>   viw<C-O>
vmap <C-P>   <C-O>

" set mouse wheel to 6 lines per scroll
map <MouseDown> 6<C-U>
map <MouseUp>   6<C-D>

" mappings related to htmlspecialchars
imap <C-H>   <Esc><C-H>i
map  <C-Q>   xihtmlspecialchars(<Esc>pa)<Esc>
nmap <C-H>   viw<C-Q>
vmap <C-H>   <C-Q>

" mappings related to addslashes
imap <C-A>   <Esc><C-H>i
map  <C-2>   xiaddslashes(<Esc>pa)<Esc>
nmap <C-A>   viw<C-2>
vmap <C-A>   <C-2>

nnoremap  <S-Tab> <<
nnoremap  <Tab>   >>

" let values
let php_htmlInStrings  = 1
let g:sql_type_default = 'mysql'

" custom values
set background   =dark
set backspace    =indent,eol,start               " enable backspacing over everything
set errorformat  =%m\ in\ %f\ on\ line\ %l       " used for php debugging
set fillchars    ="vert:|,fold: "                " used to remove the - chars from folded lines
set foldmarker   ={,}                            " folds switches, while loops, functions, classes
set foldmethod   =marker                         " uses above to detect method
set foldtext     =MyFoldText()                   " custom routine for foldtext
set hidden                                       " flag to allow buffer switching without closing unmodified buffers
set highlight    =sb                             " statusline bold
set history      =500                            " lines of history
set iskeyword    =@,$,48-57,_,192-255            " add $ to keyword def
set makeprg      =php\ -l\ %                     " for debugging php code -- sets cursorline to errors found!!
set mouse        =a                              " enable mouse support
set shiftwidth   =4                              " 4 spaces
set t_Co         =256                            " force 256 colors
set tabpagemax   =64                             " 64 tabs max
set tabstop      =4                              " 4 spaces
set textwidth    =0                              " no text margin
set vb t_vb      =                               " turn off the damn bell

" status line stuff
set laststatus  =2                               " turn on the statusline

" bool values
set autoindent                                   " automatically indents
set expandtab                                    " make tabs into spaces
set hlsearch                                     " highlight found searches
set modeline                                     " allow for vim comment configuration searching stuff
set nocursorline                                 " no cursorline
set nowrap                                       " turn off wrapping
set ruler                                        " enable basic ruler
set smarttab                                     " smarttab makes backspacing on new line remove sw # spaces.  (very cool)

colorscheme desert256
" colorscheme desert

" commands
syntax on                                       " force syntax highlighting

:hi ColorColumn ctermbg=240 guibg=#222222       " set custom cursor color position (note: must be after syntax on)

" buffergator settings
let g:buffergator_autoupdate            =1      " auto update the list when the buffers change
let g:buffergator_vsplit_size           =35     " width of split window
let g:buffergator_sort_regime           ='mru'  " sort by mru
let g:buffergator_autodismiss_on_select =0      " do not dismiss windows on selection

" airline settings
let g:airline#extensions#tabline#enabled         =1               " show all buffers as tabs when only one window is open
let g:airline#extensions#whitespace#checks       =[ 'trailing' ]  " check for trailing whitespace
let g:airline#extensions#tabline#buffer_idx_mode =1               " add id numbers to buffers
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep                     ='::'
let g:airline_right_sep                    ='::'
let g:airline_symbols.crypt                ='c'
let g:airline_symbols.linenr               =''
let g:airline_symbols.maxlinenr            =''
let g:airline_symbols.branch               ='b'
let g:airline_symbols.paste                ='p'
let g:airline_symbols.spell                ='s'
let g:airline_symbols.notexists            ='ne'
let g:airline_symbols.whitespace           ='WS'

map <C-n> :NERDTreeToggle<cr>

" custom foldtext function
function MyFoldText()
    let line = getline(v:foldstart)
    let sub  =  substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    let out  = ''
    if v:foldlevel - 2 > 0
        let out = repeat(' ', lvl)
    endif
    return out . sub
endfunction

" show the UTF8 sequence
function! ShowUtf8Sequence()
    let p = getpos('.')
    redir => utfseq
    sil normal! g8
    redir End
    call setpos('.', p)
    return substitute(matchstr(utfseq, '\x\+ .*\x'), '\<\x', '0x&', 'g')
endfunction

