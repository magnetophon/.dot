
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

# alt + . inserts the last argument of the previous command:
bindkey '\e.' insert-last-word

# make a dir and go to it
mkcd() { mkdir -p -- "$1" && cd -- "$_"; }


##################################################################
# aliases
##################################################################
# not using fzf yet
# alias vi='emacseditor --no-wait --create-frame'
vi() {emacseditor --create-frame --quiet --no-wait "$@"}
alias vh='vim -M ~/.vim/vim_keys.txt'
alias v='fasd -f -t -e vim -b viminfo'
alias j=fasd_cd
alias g='git --no-pager'
alias gs='git status'
alias gst='git stash'
alias gco='git checkout'
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
alias gl="glNoGraph --graph"
alias ra='echo "user r, ya dummy!"'
alias ua='dtrx --recursive --one=here --verbose'
alias  l='exa --long --grid --header --git --git-ignore --classify --extended --group-directories-first --group  --links --time-style=long-iso'
alias la='exa --long --grid --header --git --git-ignore --classify --extended --group-directories-first --group  --links --time-style=long-iso --all'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
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

alias h=hunter

alias ip='ip --color=auto'

#ranger filemanager
r() {
  if $(test -z $RANGER_LEVEL); then
    ranger_cd $*
  else
    echo $(pwd) > /tmp/rangerdir
    exit
  fi
}
ranger_cd() {
  temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
  ranger --choosedir="$temp_file" -- "${@:-$PWD}"
  if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
    cd -- "$chosen_dir"
  fi
  rm -f -- "$temp_file"
}
# nnn filemanager
export NNN_PLUG='c:fzcd;f:fzopen;r:_ranger*;'
n ()
{
  # Block nesting of nnn in subshells
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

  # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
  # To cd on quit only on ^G, remove the "export" as in:
  #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  # NOTE: NNN_TMPFILE is fixed, should not be modified
  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
  # stty start undef
  # stty stop undef
  # stty lwrap undef
  # stty lnext undef

  nnn "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  fi
}
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
# alias fzga="sk -i -c 'rga --smart-case --no-messages --hidden --follow --files-with-matches '{}'' --preview 'rga --smart-case --hidden --follow --pretty --context 10 {cq} {}' --header 'enter to view, alt-z toggle preview, alt-a toggle all, ctrl-a select all'  --ansi --reverse --bind 'enter:execute(xdg-open {1} &)' --bind 'alt-z:toggle-preview,alt-a:toggle-all,ctrl-a:select-all' --multi --exact --no-height --color=light"
fzga() {
  sk -i -c \
    'rga --smart-case --no-messages --hidden --follow --files-with-matches '{}'' \
    --preview 'rga --smart-case --hidden --follow --pretty --context 10 {cq} {}' \
    --header 'enter to view, alt-z toggle preview, alt-a toggle all, ctrl-a select all'  \
    --ansi --reverse --bind 'enter:execute(xdg-open {1} &)' \
    --bind 'alt-z:toggle-preview,alt-a:toggle-all,ctrl-a:select-all' \
    --multi --exact --no-height --color=light
}

          # --query="$*" \
          fzg() {
            sk -i -c  \
              'rg  --glob "*$1*" --smart-case --no-messages --color always --line-number --hidden --follow '{}'' \
              --preview '~/.local/bin/fzg_preview.sh {}' \
              --header 'enter to view, alt-z toggle preview, alt-a toggle all, ctrl-a select all' \
              --ansi --reverse --bind 'enter:execute($EDITOR +{2} {1} &)'\
              --bind 'alt-z:toggle-preview,alt-a:toggle-all,ctrl-a:select-all'\
              --multi --exact --no-height --color=light -d':'
          }

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
          # paste to the web:
          alias tb="nc termbin.com 9999"

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
          # out=$(fzf --query="$*" --expect=ctrl-o,ctrl-e)
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
            file=$(fzf --query="$*" )
            [ -n "$file" ] && xdg-open "$file" &
          }

          # fzd - cd to selected directory
          # fd is now a binary, replacing find
          fzd() {
            local dir
            dir=$(fd -t d | fzf  --no-multi) &&
              cd "$dir"
          }
          # fcd - fuzzy cd from anywhere via fd result
          fcd() {
            local dir
            dir="$(fd -t d "$1" | fzf --query="$*" --cycle --bind 'tab:down,btab:up' -1 -0 --no-sort)" && cd "${dir}" || return 1
          }

          # fda - including hidden directories
          fda() {
            local dir
            dir=$(fd -t d -H | fzf --query="$*" --no-multi) && cd "$dir"
          }
          # cdf - cd into the directory of the selected file
          cdf() {
            local file
            local dir
            file=$(fzf --no-multi --query="$1") && dir=$(dirname "$file") && cd "$dir"
          }

          s() {
            local file
            file=$(fasd -lR | fzf --query="$*" )
            [ -n "$file" ] && xdg-open "$file" &
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
            print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf --query="$*" --no-sort --tac --preview $_FZF_ZSH_PREVIEW_STRING --preview-window down:10:wrap | sed 's/ *[0-9]* *//')
          }
          # fk - kill process
          fk() {
            pid=$(ps -ef | sed 1d | fzf  --query="$*" --preview-window=right:hidden | awk '{print $1}')

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
                                   fzf --query="$*" --print0 --multi)"}"; do mpv $file; done
          }

          # always run mpv in the background
          function mpv() { command mpv "$@" & disown; }

          # flv2 - lv2 plugin finder and runner
          flv2() {
            lv2ls |
              fzf --query="$*" --no-sort --reverse --tiebreak=index --no-multi \
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

####################################################################################################
############################### make the prompt work in tty ########################################
####################################################################################################
autoload -Uz promptinit && promptinit

# Load the prompt theme.
zstyle -a ':prezto:module:prompt' theme 'prompt_argv'
if [[ "$TERM" == (dumb|bsd*) ]] || (( $#prompt_argv < 1 )); then
prompt 'off'
else
  prompt "$prompt_argv[@]"
fi
unset prompt_argv
          # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
          # [[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh
          # default location:
          # [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
  [[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh
else
  [[ ! -f ~/.config/.p10k.portable.zsh ]] || source ~/.config/.p10k.portable.zsh
fi

################################ alert on long commands ############################################
          [[ ! -f ~/.dot/zlong_alert.zsh/zlong_alert.zsh ]] || source ~/.dot/zlong_alert.zsh/zlong_alert.zsh
          zlong_use_notify_send=false
          zlong_duration=4
          zlong_ignore_cmds="vim nvim ssh"

################################### git fuzzy ######################################################
export PATH="/home/bart/source/git-fuzzy/bin:$PATH"

################################## fzf-tab previews ###############################################
# from: https://github.com/Aloxaf/fzf-tab/issues/79
# https://gist.github.com/adelin-b/53fecd0f9010819bae2e69792da29704


# auto completion {{

# zinit light Aloxaf/fzf-tab

FZF_TAB_COMMAND=(
  fzf
  --ansi   # Enable ANSI color support, necessary for showing groups
  --expect='$continuous_trigger,$print_query' # For continuous completion
  '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
  --nth=2,3 --delimiter='\x00'  # Don't search prefix
  --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
  --tiebreak=begin
  -m
  --bind=tab:down,change:top,ctrl-space:toggle,shift-tab:up,ctrl-j:down,alt-j:jump-accept,ctrl-d:preview-page-down,ctrl-u:preview-page-up,ctrl-p:toggle-preview --cycle
  '--query=$query'   # $query will be expanded to query string at runtime.
  '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
  --print-query
)


zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND

# disable sort when completing any command
zstyle ':completion:complete:*' sort false

# use input as query string when completing zlua
zstyle ':fzf-tab:complete:_zlua:*' query-string input

# (experimental, may change in the future)
local extract="
# trim input(what you select)
in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion(some thing before or after the current word)
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
"

mansubs() {
  man "$1" |col -bx|awk '/^[A-Z ]+$/ {print}'
}

manedit() {
  man "$1" |col -bx|awk -v S="$2" '$0 ~ S {cap="true"; print} $0 !~ S && /^[A-Z ]+$/ {cap="false"} $0 !~ S && !/^[A-Z ]+$/ {if(cap == "true")print}'
}

fzf_tab_preview_debug='echo "${~ctxt[hpre]}$in"'
fzf_tab_preview_commit='
# Show commits and branch commits
git show $( echo "${~ctxt[hpre]}$in" | cut -f 1 -d " " ) | diff-so-fancy --colors
'

fzf_tab_preview_options=''

fzf_tab_preview_command='
# Show information on command
which ${~ctxt[hpre]}$in | grep -v "not found" 2> /dev/null;
whatis ${~ctxt[hpre]}$in 2> /dev/null;

# Show my own snippets related to the command
grep -w "${~ctxt[hpre]}$in" ~/.config/clisnippets 2> /dev/null;

# tldr show cheatsheet of command
tldr ${~ctxt[hpre]}$in 2> /dev/null;

# Search through man and give the description segment
man "${~ctxt[hpre]}$in" 2> /dev/null |col -bx|awk -v S="$2" "DESCRIPTION ~ S {cap="true"; print} DESCRIPTION !~ S && /^[A-Z ]+$/ {cap="false"} DESCRIPTION !~ S && !/^[A-Z ]+$/ {if(cap == "true")print}" 2> /dev/null;
'

fzf_tab_preview_file='
# Display images
tiv -h ${FZF_PREVIEW_LINES} -w ${FZF_PREVIEW_COLUMNS} ${~ctxt[hpre]}$in  2> /dev/null;

# Display directory
# du -h ${~ctxt[hpre]}$in 2> /dev/null | tail -n1
# lsd --tree --icon --depth 2  --color=always ${~ctxt[hpre]}$in 2> /dev/null
exa --tree --level 1 --icons --color=always ${~ctxt[hpre]}$in 2> /dev/null;

# Display file
bat --theme="OneHalfDark" --style=numbers,changes --color always ${~ctxt[hpre]}$in 2> /dev/null | head -n50 | grep -v "bat warning"; 2> /dev/null;

# Display exif data
exiftool ${~ctxt[hpre]}$in  2> /dev/null;
'

fzf_tab_preview_yay_package='yay -Si "${~ctxt[hpre]}$in"'
fzf_tab_preview_pacman_package='pacman -Si "${~ctxt[hpre]}$in"'

fzf_tab_preview_docker_container_run='
docker history $(echo "${~ctxt[hpre]}$in" | cut -f 1 -d " ")
# docker stats ${~ctxt[hpre]}$in
# docker logs ${~ctxt[hpre]}$in
'
fzf_tab_preview_systemctl_service='
systemctl status ${~ctxt[hpre]}$in
systemctl help ${~ctxt[hpre]}$in
'

# zstyle ':fzf-tab:*:' prefix '·'
zstyle ':fzf-tab:complete:*' extra-opts --preview=$extract$fzf_tab_preview_file
zstyle ':fzf-tab:complete:*:options' extra-opts '' # --preview=$extract$fzf_tab_preview_options
zstyle ':fzf-tab:complete:-command-:*' extra-opts --preview=$extract$fzf_tab_preview_command
zstyle ':fzf-tab:complete:systemctl-*:*' extra-opts --preview=$extract$fzf_tab_preview_systemctl_service
zstyle ':fzf-tab:complete:git*:*' extra-opts --preview=$extract$fzf_tab_preview_commit$fzf_tab_preview_file
zstyle ':fzf-tab:complete:docker-run:*' extra-opts --preview=$extract$fzf_tab_preview_docker_container_run$fzf_tab_preview_file
zstyle ':fzf-tab:complete:yay:argument-rest' extra-opts --preview=$extract$fzf_tab_preview_yay_package
zstyle ':fzf-tab:complete:pacman:argument-rest' extra-opts --preview=$extract$fzf_tab_preview_yay_package
# }}
