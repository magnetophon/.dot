# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

##################################################################
# general functions
##################################################################
# a visual recursive list of all files and dirs
# WIP:
#function treedir()
  #{
    #find . | sed -e 's/[^\/]*\//|--/g' -e 's/-- |/    |/g' | $PAGER
  #}

## recursive text search
#function f() {
  #find . | sed -e 's/[^\/]*\//|--/g' -e 's/-- |/  |/g' | $PAGER
  #}

HISTSIZE=100000
SAVEHIST=$HISTSIZE

# make a dir and go to it
mkcd() { mkdir -p "$1" && cd "$_"; }

##################################################################
# aliases
##################################################################
# not using fzf yet
# alias vi='emacseditor --no-wait --create-frame'
vi() {emacseditor --create-frame --quiet --no-wait "$@"}
alias vh='vim -M ~/.vim/vim_keys.txt'
alias v='fasd -f -t -e vim -b viminfo'
alias j=fasd_cd
alias gs='git status'
alias gst='git stash'
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
alias gl="glNoGraph --graph"
alias ra=ranger
alias ua='dtrx --recursive --one=here --verbose'
# alias wn=lr $(which "$1")
#Install a package I don’t have but tried to use
alias ok='eval $($(fc -ln -1) 2>&1 | sed -n 2p)'
#Find a file or directory in working dir matching a string.
alias lsg='ls -laR| grep -ni'

# fuzzy run:
alias fr='print -z $(print -l ${(ok)commands} | fzf --preview="MANWIDTH=150 man {}" --preview-window=right:75%)'

# fuzzy jump
alias fj='cd $(fasd -l | fzf -e -i --tac --no-sort --preview "tree -L 4 -d -C --noreport -C {} | head -200"  )'
# alias fj='cd $(fasd | fzf -e -i --tac --no-sort | awk '{print $2}')'

# fzf alias
alias fa='print -z $( alias | tr = "\t" | fzf --preview-window=right:hidden | cut -f 1)'
 # fuzzy i3 binding reminder
alias fb="grep '^bind' ~/.config/i3/config | cut -d ' ' -f 2- | sed 's/ //' | column --table --separator  | fzf --preview-window=hidden"

# fuzzy unmount
alias fu="mount | sed 's/ on / /' | sed 's/ type / /'  | column --table --table-columns SOURCE,TARGET,TYPE,OPTIONS -o'|' | fzf  --preview-window right:33%:wrap --preview 'tree -L 4 -d -C --noreport -C $(echo {} | cut -d"|" -f2)' | cut -d'|' -f2 | /run/current-system/sw/bin/xargs umount"

# pick a function or an alias
ff() {
    (print -l ${(ok)functions} | grep -v '^_' | sed 's/^/function: /' &&  alias | tr = "\t"| cut -f 1 | sed 's/^/alias: /' ) |
        fzf --preview="
                which $(echo {} | sed 's/function: //' | sed 's/alias: //')" \
        --preview-window=bottom | sed 's/^function: //' | sed 's/^alias: //'
}

# NixOS: get the link to a binary
wh() {
    command ls -lR $(command which $1)
}

# fuzzy get the link to a binary
fw() {
    whence -pm '*' | xargs ls -lR --color |
        fzf --preview="echo {} | grep -o '[^ ]*$' | xargs ~/.local/bin/preview.sh" \
            --preview-window=down:wrap |
        grep -o '[^ ]*$'
}

# fuzzy search content of a file
# alias  fzg="sk -i -c 'rg  --smart-case --no-messages --color always --line-number --hidden --follow '{}'' --preview '~/.local/bin/fzg_preview.sh {}' -d':' --header 'enter to view, alt-z toggle preview, alt-a toggle all, ctrl-a select all'  --ansi --reverse --bind 'enter:execute($EDITOR +{2} {1} &)' --bind 'alt-z:toggle-preview,alt-a:toggle-all,ctrl-a:select-all' --multi --exact --no-height --color=light"
alias  fzg="sk -i -c 'rg  --smart-case --no-messages --color always --line-number --hidden --follow '{}'' --preview '~/.local/bin/fzg_preview.sh {}' -d':' --header 'enter to view, alt-z toggle preview, alt-a toggle all, ctrl-a select all'  --ansi --reverse --bind 'enter:execute($EDITOR +{2} {1} &)' --bind 'alt-z:toggle-preview,alt-a:toggle-all,ctrl-a:select-all' --multi --exact --no-height --color=light"
alias fzga="sk -i -c 'rga --smart-case --no-messages --hidden --follow --files-with-matches '{}'' --preview 'rga --smart-case --hidden --follow --pretty --context 10 {cq} {}' --header 'enter to view, alt-z toggle preview, alt-a toggle all, ctrl-a select all'  --ansi --reverse --bind 'enter:execute(xdg-open {1} &)' --bind 'alt-z:toggle-preview,alt-a:toggle-all,ctrl-a:select-all' --multi --exact --no-height --color=light"



#
# RipGrep-All Integration
# -----------------------
# allows to search in PDFs, E-Books, Office documents, zip, tar.gz, etc.
# find-in-file - usage: fif <searchTerm>
if $( whence rga >/dev/null ); then
  fif() {
    if [ ! "$#" -gt 0 ]; then
      echo "Need a string to search for!"
      return 1
    fi
    rga --smart-case --files-with-matches --no-messages "$1" |
      fzf --preview-window=right:60% \
        --preview "rga --smart-case --pretty --context 10 "$1" {}"
  }
elif $( whence rg >/dev/null 2>&1 ); then
  fif() {
    if [ ! "$#" -gt 0 ]; then
      echo "Need a string to search for!"
      return 1
    fi
    rg --files-with-matches --no-messages "$1" |
      fzf --preview-window=right:60% \
        --preview "highlight -O ansi -l {} 2> /dev/null |
                           rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' ||
                           rg --ignore-case --pretty --context 10 '$1' {}"
  }
fi

alias iotop="sudo iotop"

##################################################################
# completions
##################################################################
# speed up completion of paths
zstyle ':completion:*' accept-exact '*(N)'
# speed up completion using the cache for packages and other stuff
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# man page completion
#zstyle ':completion:*:manuals' separate-sections true
#zstyle ':completion:*:manuals.*'  insert-sections true
#zstyle ':completion:*:man.*' group-name manual

autoload -U compinit && compinit

##################################################################
# source fzf bindings and completions
##################################################################

if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/key-bindings.zsh"
fi

# todo: get working:
if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/completion.zsh"
fi

##################################################################
# fzf bindings
##################################################################

# fe [fuzzy pattern] - Open the selected file with the default editor
# - Bypass fuzzy finder if there's only one match (--select-1)
# - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf --query="$1")
  [ -n "$file" ] && ${EDITOR:-vim} "$file" &
}

# Modified version where you can press
# - CTRL-O to open with `open` command,
# - CTRL-E or Enter key to open with the $EDITOR
# fo() {
  # local out file key
  # out=$(fzf --query="$1" --expect=ctrl-o,ctrl-e)
  # key=$(head -1 <<< "$out")
  # file=$(head -2 <<< "$out" | tail -1)
  # if [ -n "$file" ]; then
    # [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  # fi
# }

# fo [fuzzy pattern] - Open the selected file with xdg-open
# - Bypass fuzzy finder if there's only one match (--select-1)
# - Exit if there's no match (--exit-0)
fo() {
    local file
    file=$(fzf --query="$1" )
    [ -n "$file" ] && xdg-open "$file" &
}

# fzd - cd to selected directory
# fd is now a binary, replacing find
fzd() {
  local dir
  dir=$(fd -t d | fzf  --no-multi) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(fd -t d -H | fzf --no-multi) && cd "$dir"
}
# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf --no-multi --query="$1") && dir=$(dirname "$file") && cd "$dir"
}

#Searching file contents
# fzg() {
    # local query="$1"
    # rg $query --files-with-matches |
        # fzf \
            # --preview-window=bottom --preview="rg $query --no-filename --color ansi --context 15 --glob {}" \
            # --header="rg query: $query"
# }


#grep --line-buffered --color=never -r "" * | fzf

## with ag - respects .agignore and .gitignore
#ag --nobreak --nonumbers --noheading . | fzf

# fh - repeat history
# see common.nix:
# _FZF_ZSH_PREVIEW_STRING="echo {} | sed 's/ *[0-9]* *//' | highlight --syntax=zsh --out-format=ansi";

fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf --no-sort --tac --preview $_FZF_ZSH_PREVIEW_STRING --preview-window down:10:wrap | sed 's/ *[0-9]* *//')
}
# fk - kill process
fk() {
    pid=$(ps -ef | sed 1d | fzf  --preview-window=right:hidden | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(
    git branch --all | grep -v HEAD |
        sed "s/.* //" | sed "s#remotes/[^/]*/##" |
        sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  branch=$(echo "$branches" |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$branch" | awk '{print $2}')
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
git branch --all | grep -v HEAD |
sed "s/.* //" | sed "s#remotes/[^/]*/##" |
sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
(echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# fcheckout - checkout git commit with previews
fcoc() {
    local commit
    commit=$( glNoGraph |
                  fzf --no-sort --reverse --tiebreak=index --no-multi \
                      --ansi --preview="$_viewGitLogLine" ) &&
        git checkout $(echo "$commit" | sed "s/ .*//")
}
# fshow - git commit browser with previews
fshow() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
            --header "enter to view, alt-y to copy hash" \
            --bind "enter:execute:$_viewGitLogLine   | less -R" \
            --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2 --preview-window=right:hidden
) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}


# fm - fuzzy music player
fm() {
    cd ~
    for file in "${(0)"$(rg --smart-case --follow --iglob '*.{mp3,wav,flac,ogg,,mpg,avi,mpeg,flv,mov,m2v,mp4,m4a,aif,aiff,wma,mkv}' --glob '!Impulses/' --glob '!ardour/*/interchange/' --files |
        fzf --print0 --multi)"}"; do mpv $file; done
}

# always run mpv in the background
function mpv() { command mpv "$@" & disown; }

# flv2 - lv2 plugin finder and runner
flv2() {
    lv2ls |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --preview "lv2info {}" \
            --header "enter to run, alt-y to copy url" \
            --bind "enter:execute:jalv.gtk {}" \
            --bind 'alt-y:execute:echo {} | xclip' \
}

# gdb backtrace to file:
# bt $crashing_application
# This will create gdb.bt in your current directory.
alias bt='echo 0 | gdb -batch-silent -ex "run" -ex "set logging overwrite on" -ex "set logging file gdb.bt" -ex "set logging on" -ex "set pagination off" -ex "handle SIG33 pass nostop noprint" -ex "echo backtrace:\n" -ex "backtrace full" -ex "echo \n\nregisters:\n" -ex "info registers" -ex "echo \n\ncurrent instructions:\n" -ex "x/16i \$pc" -ex "echo \n\nthreads backtrace:\n" -ex "thread apply all backtrace" -ex "set logging off" -ex "quit" --args'

# v - open files in ~/.viminfo
#v() {
  #local files
  #files=$(grep '^>' ~/.viminfo | cut -c3- |
#while read line; do
#[ -f "${line/\~/$HOME}" ] && echo "$line"
#done | fzf -d -m -q "$*" -1) && vim ${files//\~/$HOME}
#}
# jump to dirs
#unalias j 2> /dev/null
#j() {
  #if [[ -j "$*" ]]; then
    #cd "$(_j -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  #else
    #_j "$@"
  #fi
#}
#Here is another version that also supports relaunching j with the arguments for the previous command as the default input by using jj
#unalias j
#j() {
  #if [[ -j "$*" ]]; then
    #cd "$(_j -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  #else
    #_last_j_args="$@"
    #_j "$@"
  #fi
#}

#jj() {
  #cd "$(_j -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q $_last_j_args)"
#}

##################################################################
# change cursor color in vi-mode
##################################################################

# zle-keymap-select () {
#     if [ $TERM = "rxvt-unicode-256color" ]; then
#         if [ $KEYMAP = vicmd ]; then
#             echo -ne "\033]12;Red\007"
#         else
#             echo -ne "\033]12;Grey\007"
#         fi
#     fi
# }
# zle -N zle-keymap-select
# zle-line-init () {
#     zle -K viins
#     if [ $TERM = "rxvt-unicode-256color" ]; then
#         echo -ne "\033]12;Grey\007"
#     fi
# }
# zle -N zle-line-init

# bindkey -v

# autoload -Uz up-line-or-beginning-search
# autoload -Uz down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
# bindkey '\eOA' up-line-or-beginning-search
# bindkey '\e[A' up-line-or-beginning-search
# bindkey '\eOB' down-line-or-beginning-search
# bindkey '\e[B' down-line-or-beginning-search

#PATH="/home/bart/perl5/bin${PATH+:}${PATH}"; export PATH;
#PERL5LIB="/home/bart/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/bart/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/bart/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/bart/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#. '/home/bart/promptless.sh'

source /home/bart/.config/broot/launcher/bash/br

[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'(in ranger) '

# if [[ $DISPLAY ]]; then
#   # If not running interactively, do not do anything
#   [[ $- != *i* ]] && return
#   [[ -z "$TMUX" ]] && exec tmux
# fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh
# default location:
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


[[ ! -f ~/.dot/zlong_alert.zsh/zlong_alert.zsh ]] || source ~/.dot/zlong_alert.zsh/zlong_alert.zsh
zlong_use_notify_send=false
zlong_duration=4
zlong_ignore_cmds="vim nvim ssh"
