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

# not using fzf yet
alias v='fasd -f -t -e vim -b viminfo'
alias gs='git status'
alias gst='git stash'
alias ra=ranger


# speed up completion of paths
zstyle ':completion:*' accept-exact '*(N)'
# speed up completion using the cache for packages and other stuff
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

fpath=($HOME/.dot/nix-zsh-completions/.nix-zsh-completions $fpath)
autoload -U compinit && compinit

##################################################################
# fzf bindings
##################################################################
# fe [FUZZY PATTERN] - Open the selected file with the default editor
# - Bypass fuzzy finder if there's only one match (--select-1)
# - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Modified version where you can press
# - CTRL-O to open with `open` command,
# - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  out=$(fzf --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
-o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
#Searching file contents

#grep --line-buffered --color=never -r "" * | fzf

## with ag - respects .agignore and .gitignore
#ag --nobreak --nonumbers --noheading . | fzf

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

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
fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
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
fzf --no-hscroll  +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}
# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  local out sha q
  while out=$(
git log --decorate=short --graph --oneline --color=never |
fzf  --multi --no-sort --reverse --query="$q" --print-query); do
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
cut -c1-80 | fzf --nth=1,2
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
zle-keymap-select () {
if [ $KEYMAP = vicmd ]; then
echo -ne "\033]12;Red\007"
else
echo -ne "\033]12;Grey\007"
fi
}
zle -N zle-keymap-select
zle-line-init () {
zle -K viins
echo -ne "\033]12;Grey\007"
}
zle -N zle-line-init
bindkey -v
#PATH="/home/bart/perl5/bin${PATH+:}${PATH}"; export PATH;
#PERL5LIB="/home/bart/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/bart/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/bart/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/bart/perl5"; export PERL_MM_OPT;
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
