pr_aeruder_vi_ins_mode="INS"
pr_aeruder_vi_cmd_mode="CMD"
pr_aeruder_vi_mode=$pr_aeruder_vi_ins_mode

function zle-keymap-select {
  pr_aeruder_vi_mode="${${KEYMAP/vicmd/${pr_aeruder_vi_cmd_mode}}/(main|viins)/${pr_aeruder_vi_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  pr_aeruder_vi_mode=$pr_aeruder_vi_ins_mode
}
zle -N zle-line-finish

function pr_aeruder_vi_mode_flag() {
    echo $pr_aeruder_vi_mode
}
PR_FLAGS+=pr_aeruder_vi_mode_flag
