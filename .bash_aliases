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

,exit() { echo $?; }

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

# PYTHON

,py () {
  if [[ $1 = "venv" ]]; then
    shift
    if [[ -z $1 ]]; then
      echo "Missing Python version"
      return 1
    else
      pyenv shell $1
      python -m venv .venv --prompt $(basename "$PWD")
      source .venv/bin/activate
      python -m pip install --upgrade pip
    fi
  elif [[ $1 = 'a' ]]; then
    source .venv/bin/activate
  elif [[ $1 = "m" ]]; then
    shift
    python -m $@
  elif [[ $1 = "i" ]]; then
    shift
    python -m pip install $@
  elif [[ $1 = "pv" ]]; then
    shift
    python -m pip freeze | grep -i $1
  else
    echo "Missing subcommand. Valid subcommands: venv, a, m, i, pv"
    return 1
  fi
}


# PRIVATE

for file in $BASH_ALIASES/private/*; do
  if [ -f "$file" ]; then
    source "$file"
  fi
done