
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




##################################################################
# aliases
##################################################################
# not using fzf yet
alias vi=$EDITOR
alias vh='$EDITOR -M ~/.vim/vim_keys.txt'
alias v='fasd -f -t -e vim -b viminfo'
alias j=fasd_cd
alias gs='git status'
alias gst='git stash'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ra=ranger
alias ua=unarchive
# alias wn=lr $(which "$1")
#Install a package I don’t have but tried to use
alias ok='eval $($(fc -ln -1) 2>&1 | sed -n 2p)'
#Find a file or directory in working dir matching a string.
alias lsg='ls -laR| grep -ni'

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

fpath=($HOME/.dot/nix-zsh-completions/.nix-zsh-completions $fpath)
autoload -U compinit && compinit

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

#grep --line-buffered --color=never -r "" * | fzf

## with ag - respects .agignore and .gitignore
#ag --nobreak --nonumbers --noheading . | fzf

# fh - repeat history
fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf --no-sort --tac --preview-window=right:hidden | sed 's/ *[0-9]* *//')
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
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
    fzf --delimiter=$(( 2 + $(wc -l <<< "$branches") )) --no-multi --preview-window=right:hidden ) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
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
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 --preview-window=right:hidden  ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}
# fcoc - checkout git commit
# fcoc() {
    # local commits commit
    # commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
        # commit=$(echo "$commits" | fzf --tac --no-sort --no-multi --preview-window=right:hidden ) &&
        # git checkout $(echo "$commit" | sed "s/ .*//")
# }

fcoc() {
  local commit
    commit=$(git log --pretty=oneline --abbrev-commit --reverse | fzf --no-sort --no-multi --preview-window=right:hidden ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  local out sha q
  while out=$(
    git log --pretty=oneline --abbrev-commit --reverse |
    fzf --no-sort --query="$q" --print-query --preview-window=right:hidden ); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=never $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
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
