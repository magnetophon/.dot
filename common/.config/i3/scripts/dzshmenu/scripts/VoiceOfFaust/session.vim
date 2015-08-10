let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.dot/common/.config/i3/scripts/dzshmenu/scripts
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +31 lib/general.lib
badd +1 stringSinger.dsp
badd +1 VocSynthFull.dsp
badd +1 FOFvocoder.dsp
badd +1 classicVocoder.dsp
badd +1 PAFvocoder.dsp
badd +1 lib/FOFvocoder.lib
badd +1 todo.txt
badd +1 lib/pitchtracker.lib
badd +1 lib/KarplusStrongFX.lib
badd +1 lib/FullGUI.lib
badd +1 lib/PAFvocoder.lib
badd +1 lib/CZringmod.lib
badd +1 CZringmod.dsp
badd +1 Karplus-StrongSingerMaxi.dsp
badd +1 lib/common.lib
badd +1 launchers/synthWrapper
badd +4 launchers/FMsinger_PT
argglobal
silent! argdel *
edit lib/KarplusStrongFX.lib
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
let s:l = 1 - ((0 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/.dot/common/.config/i3/scripts/dzshmenu/scripts
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filmnrxoOtT
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
