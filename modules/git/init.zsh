function pr_aeruder_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null || git rev-list --abbrev-commit -1 HEAD 2> /dev/null) || return
  echo "%{$fg_no_bold[yellow]%}${ref#refs/heads/}"
}

PR_FLAGS+=(pr_aeruder_git_branch)
