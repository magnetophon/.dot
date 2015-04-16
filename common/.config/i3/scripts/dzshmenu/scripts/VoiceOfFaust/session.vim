let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/faust/VoiceOfFaust
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +31 lib/general.lib
badd +45 stringSinger.dsp
badd +54 VocSynthFull.dsp
badd +25 FOFvocoder.dsp
badd +15 classicVocoder.dsp
badd +25 PAFvocoder.dsp
badd +45 lib/FOFvocoder.lib
badd +16 todo.txt
badd +23 lib/pitchtracker.lib
badd +63 lib/KarplusStrongFX.lib
badd +1 lib/FullGUI.lib
badd +30 lib/PAFvocoder.lib
badd +21 lib/CZringmod.lib
badd +23 CZringmod.dsp
badd +25 Karplus-StrongSingerMaxi.dsp
badd +6 lib/common.lib
badd +2 launchers/synthWrapper
badd +4 launchers/FMsinger_PT
argglobal
silent! argdel *
edit lib/common.lib
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
let s:l = 6 - ((5 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
6
normal! 012|
lcd ~/faust/VoiceOfFaust/lib
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
