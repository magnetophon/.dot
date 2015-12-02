let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.dot/common/.config/i3/scripts/dzshmenu/scripts/dzshmenu
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +29 ~/.dot/common/.config/i3/scripts/dzshmenu/new_zsh
badd +4 ~/.dot/common/.config/i3/scripts/dzshmenu/launch_zsh
badd +27 ~/.dot/common/.config/i3/scripts/dzshmenu/edit_zsh
badd +16 ~/.dot/common/.config/i3/scripts/dzshmenu/sessiontemplate
badd +9 ~/.dot/common/.config/i3/scripts/dzshmenu/status
badd +9 ~/.dot/common/.config/i3/scripts/dzshmenu/i3-layout-save
argglobal
silent! argdel *
edit ~/.dot/common/.config/i3/scripts/dzshmenu/i3-layout-save
set splitbelow splitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 28 - ((27 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
28
normal! 019|
lcd ~/.dot/common/.config/i3/scripts/dzshmenu
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=aoO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
