"Ryan Lee's vimrc.
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/tpope/vim-sensible'
Plug 'https://github.com/aperezdc/vim-template.git'
Plug 'https://github.com/scrooloose/syntastic'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/sheerun/vim-polyglot.git'
"Plug 'https://github.com/MaxMEllon/vim-jsx-pretty'
"Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/ryan-sandy/tender.vim'
Plug 'https://github.com/mtscout6/syntastic-local-eslint.vim.git'
call plug#end()

set ts=2 shiftwidth=2 expandtab

set clipboard=unnamed

"colors
colorscheme tender

"use the templates directory
let g:templates_directory = ['~/.vim/templates']
let g:templates_debug = 0

"setup over column color
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%l,%c%=%t%m

"syntastic configs
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(yarn bin)/eslint'

function! FindConfig(prefix, what, where)
    let cfg = findfile(a:what, escape(a:where, ' ') . ';')
    return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

autocmd FileType javascript let b:syntastic_javascript_eslint_args =
    \ get(g:, 'syntastic_javascript_eslint', '') .
    \ FindConfig('-c', '.eslintrc.json', expand('<afile>:p:h', 1))
"special syntax
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.handlebars set filetype=html
au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.md set filetype=markdown

"JSX Config
let g:jsx_ext_required = 0

"Special Compile commands
map <F2> :call Compile() <CR>
au BufNewFile,BufRead *.js map <F2> :exec "!jshint %" <CR>
au BufNewFile,BufRead *.json map <F2> :exec "!jshint %" <CR>
"Special Run commands
au BufNewFile,BufRead *.r map <F3> :exec "!Rscript %" <CR>
au BufNewFile,BufRead *.js map <F3> :exec "!node %" <CR>
au BufNewFile,BufRead *.cpp map <F3> :exec "!make run" <CR>

filetype plugin on

"wrap
"see https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj

"better window moving
noremap wj <C-W><C-J>
noremap wk <C-W><C-K>
noremap wl <C-W><C-L>
noremap wh <C-W><C-H>

"short cuts
abb ifn if (err) { return next(err); }
abb ifc if (err) { return cb(err); }
abb ifcn if (err) { return cb(err, conn); }

"map stuff
map <F4> :call Test() <CR>
map <F5> :call RunBase() <CR>
map <F7> :tabp <CR>
map <F8> :tabn <CR>

func! Compile()
  exe "!make"
endfun

func! RunBase()
  exec "!make run"
endfunc

func! Test()
  exec "!make test"
endfunc

"hardcopy
set printoptions=paper:letter
