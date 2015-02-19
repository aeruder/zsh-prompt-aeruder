zmodload zsh/stat

function pr_aeruder_byte_size() {
    local str sizes divs ans

    divs=0
    str=${1:-0}
    sizes=( "b" "k" "M" "G" )

    while (( str >= 100.0 )); do
        divs=$(( divs + 1 ))
        str=$(( str / 1024. ))
    done

    str="${(l.3.. .)"${${str[1,3]}%%.}"}"
    echo ${str}${sizes[divs+1]}
}

function pr_aeruder_diskspace() {
    local files
    files=(${(f)"$(stat -L +size -- *(.ND) /dev/null /dev/null)"})

    files=`pr_aeruder_byte_size $(( ${(j: + :)${(@)files##* }} ))`
    files=${${files%% #}## #}

    echo $files
}

PR_FLAGS+=(pr_aeruder_diskspace)

