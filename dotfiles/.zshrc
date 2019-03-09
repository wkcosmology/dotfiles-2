# Based on @pappasam's dotfiles
#     https://github.com/pappasam/dotfiles
#

######################################################
#                                                    #
#                 Environment setup                  #
#                                                    #
######################################################
# Functions ------------------------------------------------------- {{{

path_ladd() {
  # Takes 1 argument and adds it to the beginning of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

path_radd() {
  # Takes 1 argument and adds it to the end of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

include () {
  [[ -f "$1" ]] && source "$1"
}

# }}}
# Exported variable: LS_COLORS ------------------------------------ {{{

# Colors when using the LS command
# NOTE:
# Color codes:
#   0   Default Colour
#   1   Bold
#   4   Underlined
#   5   Flashing Text
#   7   Reverse Field
#   31  Red
#   32  Green
#   33  Orange
#   34  Blue
#   35  Purple
#   36  Cyan
#   37  Grey
#   40  Black Background
#   41  Red Background
#   42  Green Background
#   43  Orange Background
#   44  Blue Background
#   45  Purple Background
#   46  Cyan Background
#   47  Grey Background
#   90  Dark Grey
#   91  Light Red
#   92  Light Green
#   93  Yellow
#   94  Light Blue
#   95  Light Purple
#   96  Turquoise
#   100 Dark Grey Background
#   101 Light Red Background
#   102 Light Green Background
#   103 Yellow Background
#   104 Light Blue Background
#   105 Light Purple Background
#   106 Turquoise Background
# Parameters
#   di 	Directory
LS_COLORS="di=1;34:"
#   fi 	File
LS_COLORS+="fi=0:"
#   ln 	Symbolic Link
LS_COLORS+="ln=1;36:"
#   pi 	Fifo file
LS_COLORS+="pi=5:"
#   so 	Socket file
LS_COLORS+="so=5:"
#   bd 	Block (buffered) special file
LS_COLORS+="bd=5:"
#   cd 	Character (unbuffered) special file
LS_COLORS+="cd=5:"
#   or 	Symbolic Link pointing to a non-existent file (orphan)
LS_COLORS+="or=31:"
#   mi 	Non-existent file pointed to by a symbolic link (visible with ls -l)
LS_COLORS+="mi=0:"
#   ex 	File which is executable (ie. has 'x' set in permissions).
LS_COLORS+="ex=1;92:"
# additional file types as-defined by their extension
LS_COLORS+="*.rpm=90"

# Finally, export LS_COLORS
export LS_COLORS

# }}}
# Exported variables: General ------------------------------------- {{{

# React
export REACT_EDITOR='less'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Configure less (de-initialization clears the screen)
# Gives nicely-colored man pages
export PAGER=less
export LESS='--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --clear-screen'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# tmuxinator
export EDITOR=vim
export SHELL=bash

# environment variable controlling difference between HI-DPI / Non HI_DPI
# turn off because it messes up my pdf tooling
export GDK_SCALE=0

# History: How many lines of history to keep in memory
export HISTSIZE=5000

# XDG Base directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# }}}
# Path appends + Misc env setup ----------------------------------- {{{

PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
  export PYENV_ROOT
  path_radd "$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

NODENV_ROOT="$HOME/.nodenv"
if [ -d "$NODENV_ROOT" ]; then
  export NODENV_ROOT
  path_radd "$NODENV_ROOT/bin"
  eval "$(nodenv init -)"
fi

HOME_BIN="$HOME/bin"
if [ -d "$HOME_BIN" ]; then
  path_ladd "$HOME_BIN"
fi

STACK_LOC="$HOME/.local/bin"
if [ -d "$STACK_LOC" ]; then
  path_ladd "$STACK_LOC"
fi

YARN_BINS="$HOME/.yarn/bin"
if [ -d "$YARN_BINS" ]; then
  path_ladd "$YARN_BINS"
fi

POETRY_BINS="$HOME/.poetry/bin"
if [ -d "$POETRY_BINS" ]; then
  path_ladd "$POETRY_BINS"
fi

CARGON_BINS="$HOME/.cargo/bin"
if [ -d "$CARGON_BINS" ]; then
  path_ladd "$CARGON_BINS"
fi

# EXPORT THE FINAL, MODIFIED PATH
export PATH

# Remove duplicates in $PATH
# https://til.hashrocket.com/posts/7evpdebn7g-remove-duplicates-in-zsh-path
typeset -aU path

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
# }}}
# Colors ---------------------------------------------------------- {{{
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
NC='\033[0m'

function bold() { echo -e "${BOLD}$@${NC}" }
function red() { echo -e "${RED}$@${NC}" }
function green() { echo -e "${GREEN}$@${NC}" }
function yellow() { echo -e "${YELLOW}$@${NC}" }
# function green_bold() { bold $(green $@) }

# }}}

######################################################
#                                                    #
#                 Session setup                      #
#                                                    #
######################################################
# Plugins --------------------------------------------------------- {{{
source ~/.zplug/init.zsh

# Old Oh-my-zsh setup
# zplug "plugins/magic-enter", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-flow", from:oh-my-zsh
zplug "plugins/pylint", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh

zplug "lib/completion", from:oh-my-zsh
zplug "lib/compfix", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/git", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh

zplug "richin13/0i0.zsh-theme", use:0i0.zsh-theme, as:theme

# Cool stuff
zplug "paulirish/git-open", as:plugin
zplug "supercrabtree/k"

# Final thoughts
if ! zplug check; then
  zplug install
fi

zplug load

# }}}
# ZSH setup ------------------------------------------------------- {{{
function chpwd() {
  local opts="--group-directories-first -h"
  local cmd="ls -l"

  if command -v k 2>&1 > /dev/null;then
    cmd="k"
  fi

  if [[ $(ls -l) = 'total 0' ]]; then
    opts+="A"
  fi

  eval $cmd $opts
}

setopt auto_cd

# Completion settings
zstyle ':completion:*' ignored-patterns '__pycache__' '*?.pyc' 'poetry.lock' 'yarn.lock' 'node_modules'

bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
# }}}
# Exports --------------------------------------------------------- {{{
export MANPAGER="nvim -c 'set ft=man' -"
export DOCS_DIRECTORY=$HOME/.config/docs
# }}}
# Functions ------------------------------------------------------- {{{
# Creates a directory and cd into it
function mkcd() { mkdir -p "$@" && cd "$_" }

function sa() { alias | grep "${*}" }

function ignore() { curl -L -s "https://gitignore.io/api/$@" ;}

function wttr() {
  curl "wttr.in/?0"
}

# Edit the file manipulated in the last command
function manipulate_last_file() {
  cmd="vim" # Default is vim

  if [[ $# -ge 1 ]]; then
    cmd=$@
  fi
  file=$(fc -ln -1 | cut -d " " -f 2-)

  if [[ $file =~ "[\w\d\./]" ]]; then
    eval "$cmd $file"
  else
    echo "$file is not a file"
  fi
}

function clubhouse() {
  echo -e "## Goal\n## Reason\n## Acceptance Criteria" | xsel -ib
}

function exclude() {
  if [ ${#} -ne 1 ]; then
    red "Missing expression"
    bold "Usage: $0 <expression>"
    return 1
  fi

  [[ -f .git/info/exclude ]] && echo $1 >> .git/info/exclude
}

function de4k() {
  if [[ $# -ne 1 ]]; then
    red "Need to specifiy a video filename"
    bold "Usage: $0 <video>"
    return 1
  fi

  video=$1

  ffmpeg -i $video -c:v libx264 -vf scale=1920x1080 -c:a copy "1080-$video"
}

function rndpw() {
  </dev/urandom tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' | head -c 13  ; echo
}

function kplr() {
  cd "$KEPLER_FOLDER/$1"
}

_kplr() {
  local state

  _arguments \
    '1: :->dir'

  case $state in
    (dir) _arguments '1:projects:($(ls $KEPLER_FOLDER))' ;;
  esac
}

compdef _kplr kplr

function cloneme() {
  if [[ $# -ne 1 ]]; then
    red "Need to specify a repo to clone."
    return 1
  fi

  gcl "git@github.com:richin13/$1.git"
}

function docs() {
  if [[ $# -lt 1 ]]; then
    bold "Available documentations:"
    ls $DOCS_DIRECTORY
  else
    pushd $DOCS_DIRECTORY/$1 > /dev/null
    shift
    python -m http.server $@
    popd > /dev/null
  fi
}

_docs() {
  local state

  _arguments \
    '1: :->dir'

  case $state in
    (dir) _arguments '1:documentations:($(ls $DOCS_DIRECTORY))' ;;
  esac
}

compdef _docs docs

function review-pr() {
  if [[ $# -lt 1 ]]; then
    red "Invalid use: Specify the PR #"
    return 1
  fi
  local pr=$1
  local branch=${2:-"pr-$pr"}

  git fetch origin pull/$1/head:$branch

  if [[ $? -eq 0 ]]; then
    bold "You can review the changes by typing:"
    green "git checkout $branch"
  fi
}

# }}}
# Aliases --------------------------------------------------------- {{{
# Check whether NeoVIM is installed and alias it to vim
[[ -x "$(command -v nvim)" ]] && alias vim="nvim"

alias ls="ls --color=auto"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -Iv"
alias mkdir="mkdir -v"
alias rf="rm -rf"
alias rmdir="rm -rf"
alias sudo="sudo "
alias o=xdg-open
alias itree="tree -I '__pycache__|venv|node_modules'"
alias srm="shred -n 100 -z -u"
alias ff="grep -rnw . -e"
alias m="make"
alias dc="docker-compose"
alias dcbuild="dc build"
alias dcup="dc up"
alias dcdown="dc down"

# Execute the previous command
alias jk="fc -e -"

# APT aliases
alias apti="sudo apt install -y"
alias apts="apt search"
alias aptu="sudo apt remove -y"
alias aptup="sudo apt update && sudo apt upgrade -y"

# Pacman aliases
alias pac="pacman"
alias pacs="sudo pacman -S"
alias pacss="pacman -Ss"
alias pacsy="pacman -Sy"
alias pacsyu="pacman -Syu"
alias pacr="sudo pacman -R"
alias pacrs="sudo pacman -Rs"

# Js ecosystem aliases
alias yadd="yarn add"
alias yrm="yarn remove"
alias cra="create-react-app"

############# Utils ###############
alias so="clear && source ~/.zshrc"
alias cpwd="pwd | xclip"
alias ppwd="cd \`xclip -o\`"

# Join a Zoom Meeting
# (export defined in `sensitive` file)
alias jm="o $ZOOM_MEETING"
alias kgaws="o $AWS_CONSOLE"

alias el="manipulate_last_file"

# I surf these alot :D
alias sam-dotfiles="o https://github.com/pappasam/dotfiles/tree/master/dotfiles"
###################################
# }}}
# Extra scripts: -------------------------------------------------- {{{
include "$HOME/.zsh-scripts/python.zsh"
include "$HOME/.zsh-scripts/git.zsh"

# Sensitive information includes
include ~/.bash/sensitive
# }}}
# Extra swag: ----------------------------------------------------- {{{
fortune ~/.fortunes/zen | cowsay
# }}}
