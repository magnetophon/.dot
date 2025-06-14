if status is-interactive
    # Commands to run in interactive sessions can go here

fish_vi_key_bindings
set fish_cursor_insert line

set fish_greeting

set -U tide_context_color_root red

# don't use ? as a wildcard, so youtube links can be pasted in
set -U fish_features qmark-noglob

# starship init fish | source

set fzf_preview_dir_cmd ='eza --all --color=always'
fzf_configure_bindings --history=\cr --directory=\cf --variables=\cv --git_log=\cl

function fzg
    sk -i -c 'rg  --glob "*$1*" --smart-case --no-messages --color always --line-number --hidden --follow '{}'' --preview '~/.local/bin/fzg_preview.sh {}' --header 'enter to view, alt-z toggle preview, alt-a toggle all, ctrl-a select all' --ansi --reverse --bind 'enter:execute($EDITOR +{2} {1} &)' --bind 'alt-z:toggle-preview,alt-a:toggle-all,ctrl-a:select-all' --multi --exact --no-height --color=light -d':'
end

alias la='eza --long --grid --header --git --git-ignore --classify --extended --group-directories-first --group  --links --time-style=long-iso --all'


alias doom '~/.config/emacs/bin/doom'
alias vi 'emacseditor --create-frame --quiet --no-wait $argv'

alias fh _fzf_search_history


zoxide init fish --cmd z | source
alias j __zoxide_z
alias fj __zoxide_zi
alias fz __zoxide_zi

# alias frga rga-fzf

function rga-fzf
    set RG_PREFIX 'rga --files-with-matches'
    if test (count $argv) -gt 1
        set RG_PREFIX "$RG_PREFIX $argv[1..-2]"
    end
    set -l file $file
    set file (
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$argv[-1]'" \
        fzf --sort \
            --preview='test ! -z {} && \
                rga --pretty --context 5 {q} {}' \
            --phony -q "$argv[-1]" \
            --bind "change:reload:$RG_PREFIX {q}" \
            --preview-window='50%:wrap'
    ) && \
    echo "opening $file" && \
    open "$file"
end

# NixOS: get the link to a binary
function wh
  command which $argv
  command readlink $(command which $argv)
end

function flv2
    lv2ls | fzf --query="$argv" --no-sort --reverse --tiebreak=index --no-multi --preview "lv2info {}" --header "enter to run, alt-y to copy url" --bind "enter:execute:jalv.gtk {}" --bind 'alt-y:execute:echo {} | xclip'
end

function pr
    cd $NIXPKGS
    nixpkgs-review pr --print-result $argv && fish
end

function up
    unbuffer nixos-rebuild test --upgrade  &| nom
end

alias no nixos-option

function upn
    cd $NIXPKGS
    if not string length -q --  (git status --porcelain)
        echo "checking out commit " (nixos-version --hash) " under branch name " (nixos-version | cut -d" " -f1)
        git fetch upstream && git checkout (nixos-version --hash) -b (nixos-version | cut -d" " -f1)
    else
        git status
    end
end

alias gcn 'cd $NIXPKGS && git checkout (nixos-version | cut -d" " -f1)'

alias te 'unbuffer nixos-rebuild build -p rt -I nixos-config=/home/bart/nixosConfig/machines/(hostname | cut -d"-" -f1)/rt.nix &| nom; unbuffer nixos-rebuild test &| nom'
alias ten 'unbuffer nixos-rebuild build -p rt -I nixos-config=/home/bart/nixosConfig/machines/(hostname | cut -d"-" -f1)/rt.nix -I nixpkgs=$NIXPKGS &| nom; unbuffer nixos-rebuild test -I nixpkgs=$NIXPKGS &| nom'
alias sw 'unbuffer nixos-rebuild boot -p rt -I nixos-config=/home/bart/nixosConfig/machines/(hostname | cut -d"-" -f1)/rt.nix &| nom; unbuffer nixos-rebuild switch &| nom'
alias swn 'unbuffer nixos-rebuild boot -p rt -I nixos-config=/home/bart/nixosConfig/machines/(hostname | cut -d"-" -f1)/rt.nix -I nixpkgs=$NIXPKGS &| nom; unbuffer nixos-rebuild switch -I nixpkgs=$NIXPKGS &| nom'

function nga
    if confirm "Delete all generations and vacuum the systemd journal?"
        nix-collect-garbage -d && journalctl --vacuum-time=2d
    else
        echo "OK, we'll keep it all"
    end
end
function ngd
    if string match -qr '^-?[0-9]+(\.?[0-9]*)?$' --  "$argv[1]"
        if confirm "Delete all generations and vacuum the systemd journal except for the last $argv[1] days?"
            nix-collect-garbage --delete-older-than $argv[1]d && journalctl --vacuum-time=$argv[1]d
        else
            echo \n"OK, we'll keep it all."
        end
    else
        echo \n"You need to give the number of days you want to keep!"
    end
end

function lg
    echo "System generations"\n
    nix-env -p /nix/var/nix/profiles/system --list-generations
    echo \n\n"RT generations:"\n
    nix-env -p /nix/var/nix/profiles/system-profiles/rt --list-generations
end

function lgs
    echo "System generations"\n
    nix-env -p /nix/var/nix/profiles/system --list-generations
end

function lgr
    echo "RT generations:"\n
    nix-env -p /nix/var/nix/profiles/system-profiles/rt --list-generations
end

function dgs
    if test -n "$argv"
        for i in $argv
            if not string match -qr '^-?[0-9]+(\.?[0-9]*)?$' --  "$i"
                echo \n"You need to tell me which generations to delete!"
                kill -INT $fish_pid.
            end
        end
        if confirm "Delete system generations $argv"
            nix-env -p /nix/var/nix/profiles/system --delete-generations $argv
        end
    else
        echo \n"You need to tell me which generations to delete!"
    end
end

function dgr
    if test -n "$argv"
        for i in $argv
            if not string match -qr '^-?[0-9]+(\.?[0-9]*)?$' --  "$i"
                echo \n"You need to tell me which generations to delete!"
                kill -INT $fish_pid.
            end
        end
        if confirm "Delete realtime generations $argv"
            nix-env -p /nix/var/nix/profiles/system-profiles/rt --delete-generations $argv
        end
    else
        echo \n"You need to tell me which generations to delete!"
    end
end






function confirm --description 'Ask the user for confirmation' --argument prompt
    if test -z "$prompt"
        set prompt "Continue?"
    end

    while true
        read -p 'set_color green; echo -n "$prompt [y/N]: "; set_color normal' -l confirm

        switch $confirm
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end




# Read a single char from /dev/tty, prompting with "$*"
# Note: pressing enter will return a null string. Perhaps a version terminated with X and then remove it in caller?
# See https://unix.stackexchange.com/a/367880/143394 for dealing with multi-byte, etc.
function get_keypress
    set REPLY ""
    set IFS
    echo -n "$argv"
    if test "$status" -eq 0
        read -n 1 -s
    else
        read -n 1
    end
    echo $REPLY
end




function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end




function frg --description "rg tui built with fzf and bat"
    rg --ignore-case --color=always --line-number --no-heading "$argv" |
        fzf --ansi \
            --color 'hl:-1:underline,hl+:-1:underline:reverse' \
            --delimiter ':' \
            --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind "enter:become($EDITOR +{2} {1})"
end

function frga --description "rga tui built with fzf and bat"
    rga --ignore-case --color=always --line-number --no-heading "$argv" |
        fzf --ansi \
            --color 'hl:-1:underline,hl+:-1:underline:reverse' \
            --delimiter ':' \
            --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind "enter:become($EDITOR +{2} {1})"
end



# Commands to run in interactive sessions end here
end
