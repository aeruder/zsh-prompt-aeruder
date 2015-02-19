function pr_aeruder_sig_num {
    local val
    val=$PR_SAVED_STATUS
    if ((val == 0)); then
        return 0
    fi

    echo -n '%{${fg_bold[red]}%}'
    if ((val < 128)); then
        echo -n "$val"
    else
        ((val = val-128))
        echo -n `kill -l $val`
    fi
    return 0
}

PR_FLAGS+=(pr_aeruder_sig_num)

