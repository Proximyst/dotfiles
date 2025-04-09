function git_main_branch
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}
    if command git show-ref -q --verify $ref 2>&1 >/dev/null
      echo (basename $ref)
      return
    end
  end
  echo (git remote show origin | sed -n '/HEAD branch/s/.*: //p')
end
