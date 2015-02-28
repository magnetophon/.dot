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

alias v='fasd -f -t -e vim -b viminfo'
alias gs='git status'
alias gst='git stash'
alias ra=ranger


# speed up completion of paths
zstyle ':completion:*' accept-exact '*(N)'
# speed up completion using the cache for packages and other stuff
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

fpath=($HOME/.stowdotfiles/sourced/nix-zsh-completions $fpath)
source $HOME/.stowdotfiles/sourced/nix-zsh-completions/nix.plugin.zsh


##################################################################
# change cursor color in vi-mode
##################################################################
bindkey -v
zle-keymap-select () {
  if [ $TERM = "screen" ]; then
    if [ $KEYMAP = vicmd ]; then
      echo -ne '\033P\033]12;#ff6565\007\033\\'
    else
      echo -ne '\033P\033]12;grey\007\033\\'
    fi
  elif [ $TERM != "linux" ]; then
    if [ $KEYMAP = vicmd ]; then
      echo -ne "\033]12;#ff6565\007"
    else
      echo -ne "\033]12;grey\007"
    fi
  fi
}; zle -N zle-keymap-select
zle-line-init () {
  zle -K viins
  if [ $TERM = "screen" ]; then
    echo -ne '\033P\033]12;grey\007\033\\'
  elif [ $TERM != "linux" ]; then
    echo -ne "\033]12;grey\007"
  fi
}; zle -N zle-line-init


#PATH="/home/bart/perl5/bin${PATH+:}${PATH}"; export PATH;
#PERL5LIB="/home/bart/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/bart/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/bart/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/bart/perl5"; export PERL_MM_OPT;
