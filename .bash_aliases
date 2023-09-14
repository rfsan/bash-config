,l() { ls -ghGAF --group-directories-first --time-style=long-iso --color=auto; }
,exit() { echo $?; }
,paths() { printenv PATH | tr ':' '\n'; }

,mcd() {
  : ,mcd DIRECTORY
  : Create a directory and move inside it. Nested directories are valid
  if [[ -z $1 ]]; then
    echo "Missing directory name"
    return 1
  else
    mkdir -p "$1"
    cd "$1"
  fi
}

,apt() {
  if [[ $1 = "check" ]]; then
    sudo apt update && apt list --upgradable
  elif [[ $1 = "up" ]]; then
    sudo apt upgrade -y
  else
    echo "Missing subcommand. Valid subcommands: check, up"
    return 1
  fi
}

,c() {
  : Move one or more directories up
  if [[ $# -gt 0 ]]; then
    for ((i=1; i<=$1; i++)); do
      cd ..
    done
  else
    cd ..
  fi    
}

# MODULES

source $BASH_ALIASES/modules/python
source $BASH_ALIASES/modules/git

# PRIVATE

for file in $BASH_ALIASES/private/*; do
  if [ -f "$file" ]; then
    source "$file"
  fi
done