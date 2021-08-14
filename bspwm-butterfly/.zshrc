source $HOME/.profile

# {{{ oh-my-zsh
# Path to your oh-my-zsh installation.
export ZSH="/home/proximyst/.oh-my-zsh"

# this theme was modified to my liking
ZSH_THEME="robbyrussell"

# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  git
  sudo
  history-substring-search
  zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
  jump
  sdk
)

source $ZSH/oh-my-zsh.sh
# }}}

# {{{ util functions
dockerjava() {
  if [ -z "$1" ]
  then
    echo "fatal: no java version specified"
    return 1
  fi

  sudo docker run --rm -v "$(pwd)":/data -it "adoptopenjdk:${1}-${2:-hotspot}-bionic" bash
}

mkdire() {
  if [ -z "$1" ]
  then
    echo "fatal: no dir name specified"
    return 1
  fi

  mkdir -p "$1" && cd "$1"
}

shadow() {
  if [ ! -f "build.gradle" ] && [ ! -f "build.gradle.kts" ]
  then
    echo "fatal: no build.gradle{,.kts}"
    return 1
  fi

  if [ -f "gradlew" ]
  then
    ./gradlew shadowJar "$@"
  else
    gradle shadowJar "$@"
  fi
}
# }}}

# {{{ aliases
alias vim=nvim
alias v=nvim
alias vi=nvim
alias q=exit
alias :q=exit
alias :x=exit
alias :wq=exit
alias vvim=/bin/vim
alias copy="xclip -i -sel clipboard"
alias paste="xclip -o -sel clipboard"
alias shut="sudo shutdown -h now"
alias zzz="sudo /usr/bin/zzz"
alias f="fzf -i"
alias ff="vim \$(fzf -i)"
alias ssh="env TERM=xterm-256color /usr/bin/ssh"
alias coin="echo -e 'heads\ntails' | shuf -n 1"
alias ls="exa -F"
alias l="ls -l --git"
alias ll="l -h"

alias gc="git commit -S -s"
alias gcmsg="gc -m"
alias gcf="gc --fixup"
alias gp!="gp --force"
alias gpu!="gpu --force"
alias gpsup!="gpsup --force"
alias gg="glods"
alias gcB="gco -B"
alias grbip="grbi upstream/master --autosquash --allow-empty"
alias gdh="gd HEAD"
alias gdm="gd \$(git_main_branch)"
alias grbum="grb upstream/\$(git_main_branch)"
alias grboum="grb --onto upstream/\$(git_main_branch)"
alias grbom="grb origin/\$(git_main_branch)"
alias grboom="grb --onto origin/\$(git_main_branch)"
alias gfu="gf upstream"
alias grhum="grh upstream/\$(git_main_branch)"
alias grhom="grh origin/\$(git_main_branch)"
alias grhhum="grhh upstream/\$(git_main_branch)"
alias grhhom="grhh origin/\$(git_main_branch)"
alias gcbom="gco origin/\$(git_main_branch) -b"
alias gcbum="gco upstream/\$(git_main_branch) -b"
alias gcBom="gco origin/\$(git_main_branch) -B"
alias gcBum="gco upstream/\$(git_main_branch) -B"

alias la="ls -laF" # common aliases is wrong
alias j=jump
# }}}

export SDKMAN_DIR="$HOME/.sdkman"
source "$SDKMAN_DIR/bin/sdkman-init.sh"
source ~/.local/share/icons-in-terminal/icons_bash.sh

eval `ssh-agent` >/dev/null
ssh-add 2>/dev/null

eval "$(starship init zsh)"
