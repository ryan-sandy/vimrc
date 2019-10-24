"Ryan Lee's vimrc.
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/tpope/vim-sensible'
Plug 'https://github.com/aperezdc/vim-template.git'
Plug 'https://github.com/scrooloose/syntastic'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/MaxMEllon/vim-jsx-pretty'
Plug 'https://github.com/pangloss/vim-javascript'
call plug#end()

set ts=2 shiftwidth=2 expandtab

set clipboard=unnamed

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
"local eslint
"NOTE: Future Ryan, figure out how to set eslint as a variable
if filereadable(substitute(system('npm bin'), '[\]\|[[:cntrl:]]', '', 'g').'/eslint')
  let g:syntastic_javascript_eslint_exec=substitute(system('npm bin'), '[\]\|[[:cntrl:]]', '', 'g').'/eslint'
endif
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
