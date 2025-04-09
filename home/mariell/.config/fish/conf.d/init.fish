abbr --add dotdot --regex '^\.\.+$' --function multicd
abbr --add g 'git'
abbr --add v 'nvim'
abbr --add vi 'nvim'
abbr --add vim 'nvim'
abbr --add q 'exit'
abbr --add ls 'eza -F'
abbr --add l 'eza -F -l --git --icons'
abbr --add ll 'eza -F -l --git --icons -h'
abbr --add la 'eza -F -l --git --icons -aF'
abbr --add md 'mkdir -p'
abbr --add gg "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
abbr --add ga 'git add'
abbr --add gaa 'git add --all'
abbr --add gb 'git branch'
abbr --add gbd 'git branch --delete'
abbr --add gbv 'git branch --verbose'
abbr --add gc 'git commit'
abbr --add gcmsg 'git commit -m'
abbr --add 'gc!' 'git commit --amend'
abbr --add gcf 'git commit --fixup'
abbr --add gp 'git push'
abbr --add 'gp!' 'git push --force'
abbr --add gf 'git fetch'
abbr --add gcl 'git clone --recurse-submodules'
abbr --add gd 'git diff'
abbr --add gdh 'git diff @'
abbr --add gdm 'git diff (git_main_branch)'
abbr --add gdom 'git diff origin/(git_main_branch)'
abbr --add gmom 'git merge origin/(git_main_branch)'
abbr --add grb 'git rebase'
abbr --add grba 'git rebase --abort'
abbr --add grbc 'git rebase --continue'
abbr --add grbo 'git rebase --onto'
abbr --add grbom 'git rebase origin/(git_main_branch)'
abbr --add grboom 'git rebase --onto origin/(git_main_branch)'
abbr --add grbi 'git rebase --interactive'
abbr --add grh 'git reset'
abbr --add grhh 'git reset --hard'
abbr --add grhom 'git reset origin/(git_main_branch)'
abbr --add grhhom 'git reset --hard origin/(git_main_branch)'
abbr --add gst 'git status'
abbr --add grao 'git remote add origin'
abbr --add grseto 'git remote set-url origin'
abbr --add gcp 'git cherry-pick -x'
abbr --add gcpa 'git cherry-pick --abort'
abbr --add gcpc 'git cherry-pick --continue'
abbr --add gcpnc 'git cherry-pick --no-commit'
abbr --add gpr 'git pull --rebase'
abbr --add grev 'git revert'
abbr --add gsw 'git switch'
abbr --add gswc 'git switch -c'
abbr --add gswcm 'git switch -c mariell/'
abbr --add gswm 'git switch (git_main_branch)'
abbr --add grst 'git restore --staged'
abbr --add grm 'git rm'
abbr --add grmc 'git rm --cached'
abbr --add grmcf 'git rm --cached --force'
abbr --add gco 'git checkout'
abbr --add gwt 'git worktree'
abbr --add gwtl 'git worktree list'
abbr --add gwta 'git worktree add'
abbr --add gwtr 'git worktree remove'
abbr --add copy 'wl-copy'
abbr --add paste 'wl-paste'
abbr --add k 'kubectl'
abbr --add kx 'kubectx'
abbr --add kxc 'kubectx --current'
abbr --add kn 'kubens'
abbr --add knc 'kubens --current'
abbr --add calc 'fend'

set -g async_prompt_functions _pure_prompt_git
set fish_greeting
set pure_enable_container_detection false
set pure_enable_nixdevshell true
set pure_symbol_nixdevshell_prefix (string join "" \uf2dc " ")
set pure_symbol_prompt '$'
set pure_separate_prompt_on_error true
set pure_show_jobs true
set pure_enable_k8s true
fzf_configure_bindings --directory=\cf --git_log= --git_status=\cs --processes= --variables=
set fzf_diff_highlighter delta --paging=never --width=100
set fzf_directory_opts --bind "ctrl-v:execute($EDITOR {} &> /dev/tty)"
zoxide init fish | source
if test -d "$HOME/.local/bin"
  fish_add_path "$HOME/.local/bin"
end
if test -d "$HOME/go/bin"
  fish_add_path "$HOME/go/bin"
end
