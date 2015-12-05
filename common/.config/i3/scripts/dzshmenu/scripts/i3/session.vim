let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <C-Space> 
imap <Nul> <C-Space>
inoremap <expr> <Up> pumvisible() ? "\" : "\<Up>"
inoremap <expr> <S-Tab> pumvisible() ? "\" : "\<S-Tab>"
inoremap <expr> <Down> pumvisible() ? "\" : "\<Down>"
inoremap <silent> <Plug>NERDCommenterInsert  <BS>:call NERDComment('i', "insert")
nnoremap  :nohlsearch:redraw:checktime 
nnoremap <silent>  :CtrlP
noremap   :
nnoremap <silent> # #zz
vnoremap $ :call WrapRelativeMotion("$", 1)
onoremap $ v:call WrapRelativeMotion("$")
nnoremap $ :call WrapRelativeMotion("$")
nnoremap <silent> * *zz
nnoremap ,d :YcmShowDetailedDiagnostic
nmap <silent> ,w,t <Plug>VimwikiTabMakeDiaryNote
nmap <silent> ,w,w <Plug>VimwikiMakeDiaryNote
nmap <silent> ,w,i <Plug>VimwikiDiaryGenerateLinks
nmap <silent> ,wi <Plug>VimwikiDiaryIndex
nmap <silent> ,ws <Plug>VimwikiUISelect
nmap <silent> ,wt <Plug>VimwikiTabIndex
nmap <silent> ,ww <Plug>VimwikiIndex
nmap ,ca <Plug>NERDCommenterAltDelims
xmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
xmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
xmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cA <Plug>NERDCommenterAppend
xmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
xmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
xmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
nmap ,c$ <Plug>NERDCommenterToEOL
xmap ,cn <Plug>NERDCommenterNested
nmap ,cn <Plug>NERDCommenterNested
xmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
xmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
xmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
nnoremap ,u :UndotreeToggle
vmap ,a| :Tabularize /|
nmap ,a| :Tabularize /|
vmap ,a,, :Tabularize /,\zs
nmap ,a,, :Tabularize /,\zs
vmap ,a, :Tabularize /,
nmap ,a, :Tabularize /,
vmap ,a:: :Tabularize /:\zs
nmap ,a:: :Tabularize /:\zs
vmap ,a: :Tabularize /:
nmap ,a: :Tabularize /:
vmap ,a=> :Tabularize /=>
nmap ,a=> :Tabularize /=>
vmap ,a= :Tabularize /^[^=]*\zs=
nmap ,a= :Tabularize /^[^=]*\zs=
vmap ,a& :Tabularize /&
nmap ,a& :Tabularize /&
nnoremap ,r :RainbowParenthesesToggle
nnoremap <silent> ,gg :SignifyToggle
nnoremap <silent> ,gi :Git add -p %
nnoremap <silent> ,ge :Gedit
nnoremap <silent> ,gw :Gwrite
nnoremap <silent> ,gr :Gread
nnoremap <silent> ,gp :Git push
nnoremap <silent> ,gl :Glog
nnoremap <silent> ,gb :Gblame
nnoremap <silent> ,gc :Gcommit
nnoremap <silent> ,gd :Gdiff
nnoremap <silent> ,gs :Gstatus
vnoremap . :normal .
vnoremap 0 :call WrapRelativeMotion("0", 1)
nnoremap 0 :call WrapRelativeMotion("0")
onoremap 0 :call WrapRelativeMotion("0")
vnoremap < <gv
vnoremap > >gv
vnoremap H ^
nnoremap H ^
vnoremap L g_
nnoremap L g_
nnoremap <silent> N Nzz
nnoremap Y y$
noremap \aps : if filereadable('pkgs/top-level/all-packages.nix') | e pkgs/top-level/all-packages.nix | else | exec 'e '.expand("$NIXPKGS_ALL") | endif
noremap \gf :call on_thing_handler#HandleOnThing()
vnoremap ^ :call WrapRelativeMotion("^", 1)
nnoremap ^ :call WrapRelativeMotion("^")
onoremap ^ :call WrapRelativeMotion("^")
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> g# g#zz
nnoremap <silent> g* g*zz
noremap j gj
noremap k gk
nnoremap <silent> n nzz
nnoremap <silent> p p`]
vnoremap <silent> y y`]
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
xnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("x", "Uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("n", "Uncomment")
xnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("x", "AlignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("n", "AlignBoth")
xnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("x", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("n", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAppend :call NERDComment("n", "Append")
xnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("x", "Yank")
nnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("n", "Yank")
xnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("x", "Sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("n", "Sexy")
xnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("x", "Invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("n", "Invert")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment("n", "ToEOL")
xnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("x", "Nested")
nnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("n", "Nested")
xnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("x", "Minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("n", "Minimal")
xnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("x", "Toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("n", "Toggle")
xnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("x", "Comment")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("n", "Comment")
nmap <silent> <Right> :bn
nmap <silent> <Left> :bp
vnoremap <Home> :call WrapRelativeMotion("0", 1)
vnoremap <End> :call WrapRelativeMotion("$", 1)
onoremap <End> v:call WrapRelativeMotion("$")
nnoremap <Home> :call WrapRelativeMotion("0")
onoremap <Home> :call WrapRelativeMotion("0")
nnoremap <End> :call WrapRelativeMotion("$")
inoremap <expr> 	 pumvisible() ? "\" : "\	"
cmap Tabe tabe
let &cpo=s:cpo_save
unlet s:cpo_save
set autochdir
set autoindent
set backspace=indent,eol,start
set backup
set backupdir=~/.vim/backup//
set clipboard=unnamed,unnamedplus
set completefunc=youcompleteme#Complete
set completeopt=menuone
set cpoptions=aAceFsB
set directory=~/.vim/swap//
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set gdefault
set helplang=en
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=tab:���\ ,trail:���,extends:#,nbsp:.
set mouse=a
set pastetoggle=<F2>
set ruler
set rulerformat=%30(%=:b%n%y%m%r%w\ %l,%c%V\ %P%)
set runtimepath=~/.vim,/nix/store/j77mng9la5ily24vxjrhlnbgwbs1craf-vimplugin-vim-airline-2015-07-08/share/vim-plugins/vim-airline,/nix/store/i8b7cjyrvqw4cmn2cnqr4riq26xvp0l2-vimplugin-Solarized-2011-05-09/share/vim-plugins/Solarized,/nix/store/v6cjb7b2qvb3gclil6zqqgmm12m08vy8-vimplugin-ctrlp-2013-07-29/share/vim-plugins/ctrlp,/nix/store/5nqjgircz8pwrs5xi8gmb23s5ila7bp8-vimplugin-fugitive-2015-07-20/share/vim-plugins/fugitive,/nix/store/vvkm2g8x2kz297r9z0iwkcc42jv800ia-vimplugin-The_NERD_Commenter-2015-07-26/share/vim-plugins/The_NERD_Commenter,/nix/store/g01p5x18743gdzc06nmqp7p73jb0gwrh-vimplugin-The_NERD_tree-2015-07-13/share/vim-plugins/The_NERD_tree,/nix/store/vpfap80dp25wk7zsc356lz7ligxx0g7k-vimplugin-rainbow_parentheses-2013-03-04/share/vim-plugins/rainbow_parentheses,/nix/store/hyjv40vkmlzvgpqh98vz5iprbzm9p2wl-vimplugin-Tabular-2013-05-16/share/vim-plugins/Tabular,/nix/store/ppzqshiwgx43jqigymh4f48d177w3vlq-vimplugin-undotree-2015-03-01/share/vim-plugins/undotree,/nix/store/rnh9ksxb4bljjm3mmmjap48xp94kcpkr-vimplugin-tlib-2015-05-20/share/vim-plugins/tlib,/nix/store/5ki0105qr7zxc3wcja317gjnbaxl9yrv-vimplugin-vim-addon-completion-2015-02-10/share/vim-plugins/vim-addon-completion,/nix/store/yx13faxwhvcn8yviicjncp1m5dklra61-vimplugin-vim-addon-goto-thing-at-cursor-2012-01-11/share/vim-plugins/vim-addon-goto-thing-at-cursor,/nix/store/03ddwdhzk2w6r4yyrqhy39i3ggdllpn4-vimplugin-vim-addon-errorformats-2014-11-05/share/vim-plugins/vim-addon-errorformats,/nix/store/z3yfp2ciqk64p2ib41wqf95qm64155i4-vimplugin-vim-addon-mw-utils-2012-11-05/share/vim-plugins/vim-addon-mw-utils,/nix/store/ph25p01ni1cqr4s386x56zrmi2hlgxm8-vimplugin-vim-addon-actions-2014-09-22/share/vim-plugins/vim-addon-actions,/nix/store/wxnsl06s3s1dqqa9w34qrjraz9kc1c55-vimplugin-vim-addon-nix-2015-03-10/share/vim-plugins/vim-addon-nix,/nix/store/w54vlsshsm044yda1gvps0baaphqka7a-vimplugin-VimOutliner-2015-01-09/share/vim-plugins/VimOutliner,/nix/store/hqi39w395xma755c83jwb5k4iq5nhpgv-vimplugin-vimwiki-2014-02-21/share/vim-plugins/vimwiki,/nix/store/463x0pxzrkhpc8rj3dvvvlj8p3xa0hli-vimplugin-youcompleteme-2015-07-08/share/vim-plugins/youcompleteme,/nix/store/ccl88myhqb36vinn0iv3qlhbmr8av0ss-vim_configurable-7.4.826/share/vim/vimfiles,/nix/store/ccl88myhqb36vinn0iv3qlhbmr8av0ss-vim_configurable-7.4.826/share/vim/vim74,/nix/store/ccl88myhqb36vinn0iv3qlhbmr8av0ss-vim_configurable-7.4.826/share/vim/vimfiles/after,~/.vim/after,/nix/store/hyjv40vkmlzvgpqh98vz5iprbzm9p2wl-vimplugin-Tabular-2013-05-16/share/vim-plugins/Tabular/after,/nix/store/gwaamw8bb3narikkcblrwl1y8nfzjrjm-vimplugin-vim-addon-manager-2014-12-03/share/vim-plugins/vim-addon-manager
set scrolljump=5
set scrolloff=3
set shiftwidth=4
set shortmess=filmnrxoOtTc
set showcmd
set showmatch
set showtabline=2
set smartcase
set softtabstop=4
set splitbelow
set splitright
set statusline=%<%f\ %w%h%m%r%{fugitive#statusline()}\ [%{&ff}/%Y]\ [%{getcwd()}]%=%-14.(%l,%c%V%)\ %p%%
set tabline=%!airline#extensions#tabline#get()
set tabpagemax=15
set tabstop=4
set undodir=~/.vim/undo//
set undofile
set updatetime=2000
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=block,insert,onemore
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set wildmode=list:longest,full
set window=55
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.dot/common/.config/i3
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +276 ~/.dot/common/.config/i3/config
badd +65 ~/.dot/common/.config/i3status/config
badd +0 ~/.dot/.git/index
badd +0 ~/.dot/common/.config/i3/scripts/dzshmenu/scripts/nixos/session.vim
badd +0 fugitive:///home/bart/.dot/.git//0/common/.config/i3/scripts/dzshmenu/scripts/nixos/session.vim
argglobal
silent! argdel *
edit fugitive:///home/bart/.dot/.git//0/common/.config/i3/scripts/dzshmenu/scripts/nixos/session.vim
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 40 + 28) / 56)
exe 'vert 1resize ' . ((&columns * 106 + 106) / 212)
exe '2resize ' . ((&lines * 40 + 28) / 56)
exe 'vert 2resize ' . ((&columns * 105 + 106) / 212)
exe '3resize ' . ((&lines * 12 + 28) / 56)
argglobal
vnoremap <buffer> <silent> [" :exe "normal! gv"|call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
nnoremap <buffer> <silent> [" :call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
vnoremap <buffer> <silent> [] m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "bW")
nnoremap <buffer> <silent> [] m':call search('^\s*endf*\%[unction]\>', "bW")
vnoremap <buffer> <silent> [[ m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "bW")
nnoremap <buffer> <silent> [[ m':call search('^\s*fu\%[nction]\>', "bW")
vnoremap <buffer> <silent> ]" :exe "normal! gv"|call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
nnoremap <buffer> <silent> ]" :call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
vnoremap <buffer> <silent> ][ m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "W")
nnoremap <buffer> <silent> ][ m':call search('^\s*endf*\%[unction]\>', "W")
vnoremap <buffer> <silent> ]] m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "W")
nnoremap <buffer> <silent> ]] m':call search('^\s*fu\%[nction]\>', "W")
inoremap <buffer> <expr>  vam#utils#CompleteWith("vam#install#CompleteAddonName")
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=delete
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
set colorcolumn=80
setlocal colorcolumn=80
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
setlocal commentstring=\"%s
setlocal complete=.,w,b,u,t,i
set concealcursor=i
setlocal concealcursor=i
set conceallevel=2
setlocal conceallevel=2
setlocal completefunc=youcompleteme#Complete
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'vim'
setlocal filetype=vim
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetVimIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,#
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=/usr/include,,
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%!airline#statusline(1)
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'vim'
setlocal syntax=vim
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=78
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 209 - ((19 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
209
normal! 0
lcd ~/.dot/common/.config/i3/scripts/dzshmenu/scripts/nixos
wincmd w
argglobal
edit ~/.dot/common/.config/i3/scripts/dzshmenu/scripts/nixos/session.vim
vnoremap <buffer> <silent> [" :exe "normal! gv"|call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
nnoremap <buffer> <silent> [" :call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
vnoremap <buffer> <silent> [] m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "bW")
nnoremap <buffer> <silent> [] m':call search('^\s*endf*\%[unction]\>', "bW")
vnoremap <buffer> <silent> [[ m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "bW")
nnoremap <buffer> <silent> [[ m':call search('^\s*fu\%[nction]\>', "bW")
vnoremap <buffer> <silent> ]" :exe "normal! gv"|call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
nnoremap <buffer> <silent> ]" :call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
vnoremap <buffer> <silent> ][ m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "W")
nnoremap <buffer> <silent> ][ m':call search('^\s*endf*\%[unction]\>', "W")
vnoremap <buffer> <silent> ]] m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "W")
nnoremap <buffer> <silent> ]] m':call search('^\s*fu\%[nction]\>', "W")
inoremap <buffer> <expr>  vam#utils#CompleteWith("vam#install#CompleteAddonName")
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
set colorcolumn=80
setlocal colorcolumn=80
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
setlocal commentstring=\"%s
setlocal complete=.,w,b,u,t,i
set concealcursor=i
setlocal concealcursor=i
set conceallevel=2
setlocal conceallevel=2
setlocal completefunc=youcompleteme#Complete
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'vim'
setlocal filetype=vim
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetVimIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,#
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%!airline#statusline(2)
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'vim'
setlocal syntax=vim
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=78
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 209 - ((19 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
209
normal! 0
lcd ~/.dot/common/.config/i3/scripts/dzshmenu/scripts/nixos
wincmd w
argglobal
edit ~/.dot/.git/index
nnoremap <buffer> <silent> C :Gcommit
nnoremap <buffer> <silent> R :edit
nnoremap <buffer> <silent> cvc :Gcommit --verbose
nnoremap <buffer> <silent> cva :Gcommit --amend --verbose
nnoremap <buffer> <silent> ca :Gcommit --amend
nnoremap <buffer> <silent> cA :Gcommit --amend --reuse-message=HEAD
nnoremap <buffer> <silent> cc :Gcommit
nnoremap <buffer> <silent> g? :help fugitive-:Gstatus
nnoremap <buffer> <silent> q :bdelete
nnoremap <buffer> <silent> r :edit
let s:cpo_save=&cpo
set cpo&vim
nnoremap <buffer> <silent> <F1> :help fugitive-:Gstatus
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=delete
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
set colorcolumn=80
setlocal colorcolumn=80
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
set concealcursor=i
setlocal concealcursor=i
set conceallevel=2
setlocal conceallevel=2
setlocal completefunc=youcompleteme#Complete
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'gitcommit'
setlocal filetype=gitcommit
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=1
setlocal foldmarker={{{,}}}
setlocal foldmethod=syntax
setlocal foldminlines=1
setlocal foldnestmax=20
set foldtext=fugitive#foldtext()
setlocal foldtext=fugitive#foldtext()
setlocal formatexpr=
setlocal formatoptions=cqtl
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=substitute(v:fname,'^[^/]\\+/','','')
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=git\ --git-dir='/home/bart/.dot/.git'\ show
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal nomodeline
setlocal nomodifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=~/.dot/.git,~/.dot,
setlocal nopreserveindent
setlocal previewwindow
setlocal quoteescape=\\
setlocal readonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%!airline#statusline(3)
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'gitcommit'
setlocal syntax=gitcommit
endif
setlocal tabstop=8
setlocal tags=
setlocal textwidth=72
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal winfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 11 - ((8 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
normal! 0
lcd ~/.dot/.git
wincmd w
exe '1resize ' . ((&lines * 40 + 28) / 56)
exe 'vert 1resize ' . ((&columns * 106 + 106) / 212)
exe '2resize ' . ((&lines * 40 + 28) / 56)
exe 'vert 2resize ' . ((&columns * 105 + 106) / 212)
exe '3resize ' . ((&lines * 12 + 28) / 56)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filmnrxoOtTc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
