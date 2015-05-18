syntax on
"make the backspace work
set backspace=2
set ts=2 shiftwidth=2 expandtab

"setup over column color
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"load the skeliton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e

"special syntax
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.handlebars set filetype=html
au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.md set filetype=markdown

"Special Compile commands
map <F2> :call Compile() <CR>
au BufNewFile,BufRead *.js map <F2> :exec "!jslint %" <CR>
au BufNewFile,BufRead *.json map <F2> :exec "!jslint %" <CR>
"Special Run commands
au BufNewFile,BufRead *.r map <F3> :exec "!Rscript %" <CR>
au BufNewFile,BufRead *.js map <F3> :exec "!node %" <CR>
au BufNewFile,BufRead *.cpp map <F3> :exec "!make run" <CR>

filetype plugin on

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
