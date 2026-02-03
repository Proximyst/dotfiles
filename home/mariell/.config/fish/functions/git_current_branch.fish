function git_current_branch --description "Print the current branch name, if any"
    command git symbolic-ref --short HEAD 2>/dev/null;
        or command git name-rev --name-only HEAD 2>/dev/null
end
