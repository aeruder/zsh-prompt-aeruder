#!/bin/zsh

# A lot from http://www.aperiodic.net/phil/prompt/

PR_FLAGS=()
PR_SAVED_STATUS="0"
autoload -U colors
colors
setopt promptsubst

function pr_aeruder_solarized {
    pr_aeruder_fg_flag=$fg_bold[cyan]
    pr_aeruder_fg_flag_sep=$fg_no_bold[red]
    pr_aeruder_fg_host=$fg_no_bold[red]
    pr_aeruder_fg_clock=$reset_color
    pr_aeruder_fg_clock_sep=$fg_bold[cyan]
    pr_aeruder_fg_pwd=$fg_no_bold[blue]
    pr_aeruder_fg_root=$fg_no_bold[blue]
}

function pr_aeruder_normal {
    pr_aeruder_fg_flag=$fg_bold[white]
    pr_aeruder_fg_flag_sep=$fg_bold[green]
    pr_aeruder_fg_host=$fg_no_bold[green]
    pr_aeruder_fg_clock=$fg_no_bold[yellow]
    pr_aeruder_fg_clock_sep=$fg_bold[white]
    pr_aeruder_fg_pwd=$fg_bold[magenta]
    pr_aeruder_fg_root=$fg_bold[green]
}

pr_aeruder_normal

function pr_aeruder_loadflags {
    local -a flag_strings
    for a in "$PR_FLAGS[@]"; do
        local thisflag="`eval $a`"
        if [[ -z "$thisflag" ]] ; then
            thisflag="-"
        fi
        flag_strings+=( '%{${pr_aeruder_fg_flag}%}'"$thisflag"'%{${pr_aeruder_fg_flag_sep}%}' )
    done
    echo "${(e):-${(j/:/)flag_strings}}"
}

function pr_aeruder_host {
    if ! [ -z "$SSH_CLIENT" ] || ! [ -z "$SSH_CONNECTION" ]; then
        echo "%{${pr_aeruder_fg_host}%}%n@%m "
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
%{${pr_aeruder_fg_pwd}%}$(pr_aeruder_pwd) \
$(pr_aeruder_loadflags) %{${pr_aeruder_fg_root}%}%# %{$reset_color%}'
