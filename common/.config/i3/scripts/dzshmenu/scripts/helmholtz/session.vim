let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +25 source/nixpkgs/pkgs/applications/audio/pd-plugins/helmholtz/default.nix
badd +21 source/nixpkgs/pkgs/applications/audio/pd-plugins/maxlib/default.nix
badd +10350 source/nixpkgs/pkgs/top-level/all-packages.nix
badd +18 source/nixpkgs/pkgs/applications/audio/pd-plugins/puremapping/default.nix
badd +24 source/nixpkgs/pkgs/applications/audio/pd-plugins/zexy/default.nix
badd +17 source/nixpkgs/pkgs/applications/audio/pd-plugins/cyclone/default.nix
badd +51 source/nixpkgs/pkgs/applications/audio/pd-plugins/mrpeach/default.nix
badd +19 source/nixpkgs/pkgs/applications/audio/pd-plugins/osc/default.nix
badd +1 source/mrpeach/Makefile
badd +59 source/mrpeach/net/Makefile
argglobal
silent! argdel *
edit source/nixpkgs/pkgs/top-level/all-packages.nix
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
let s:l = 11124 - ((21 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11124
normal! 03|
lcd ~/source/nixpkgs/pkgs/top-level
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
