#!/bin/zsh

# A lot from http://www.aperiodic.net/phil/prompt/

PR_FLAGS=()
PR_SAVED_STATUS="0"
autoload -U colors
colors

function pr_aeruder_loadflags {
    local -a flag_strings
    for a in "$PR_FLAGS[@]"; do
        local thisflag="`eval $a`"
        if [[ -z "$thisflag" ]] ; then
            thisflag="-"
        fi
        flag_strings+=( '%{${fg_bold[white]}%}'"$thisflag"'%{${fg_bold[green]}%}' )
    done
    echo "${(e):-${(j/:/)flag_strings}}"
}

function pr_aeruder_host {
    if ! [ -z "$SSH_CLIENT" ]; then
        echo "%{${fg_no_bold[green]}%}%n@%m "
    fi
}

function pr_aeruder_pwd {
    local pwd="`print -P %~`"
    local i=0

    if [[ "$pwd" == (#m)(/|"~"[[:IDENT:]]#) ]]; then
        echo "$MATCH"
    else
        pwd=("${(@s:/:)pwd}")
        for (( i = 2; i < ${#pwd}; i++ )); do
            if [[ ${#pwd[i]} > 0 ]]; then
                pwd[i]="${pwd[i][1]}"
            fi
        done
        echo "${(@j:/:M)pwd}"
    fi
}

PROMPT='${${PR_SAVED_STATUS::=$?}##*}\
$(pr_aeruder_host)\
%{${fg_bold[magenta]}%}$(pr_aeruder_pwd)%{${fg_bold[white]}%} \
$(pr_aeruder_loadflags) %# %{$reset_color%}'

RPROMPT='\
%{${fg_bold[white]}%}[%{${fg_no_bold[yellow]}%}%D{%H:%M}%{$reset_color%}]'

