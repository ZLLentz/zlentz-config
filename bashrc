# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

setterm -blength 0
export orig_path=$PATH

# Do the default stuff or w/e
if [ -f ~/.bashrc_defaults ]; then
  . ~/.bashrc_defaults
fi

# Include home bin directory
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

export my_path=$PATH

umask 002

# Define environments
clear_env() {
  if [ -z "$1" ]; then
    envname "-"
    export PATH=$my_path
  else
    envname clean
    export PATH=$orig_path
  fi
  unset LD_LIBRARY_PATH
  unset PYTHONPATH
}

reset_env() {
  clear_env nopath
  source ~/.bashrc
}

envname() {
  export ENVNAME=$1
}

conda_env() {
  clear_env
  export PATH="$HOME/conda/bin:$PATH"
  envname conda
  if ! [ -z $1 ]; then
      source activate "$1"
  fi
}
clear_env

# Shortcuts
go_up() {
  COUNTER=0
  while [ $COUNTER -lt $1 ]; do
    cd ..
    let COUNTER=COUNTER+1
  done
}
alias ..='go_up 1'
alias ..1='go_up 1'
alias ..2='go_up 2'
alias ..3='go_up 3'
alias ..4='go_up 4'
alias ..5='go_up 5'
alias ..6='go_up 6'
alias ..7='go_up 7'
alias ..8='go_up 8'
alias ..9='go_up 9'

# Yay vim
export EDITOR=vim

# Custom PS1
pwd_short() {
  dir=`pwd | sed "s:^${HOME}:~:"`
  cols=`tput cols`
  maxcols=$(( $cols / 5 ))
  if [ "${#dir}" -gt $maxcols ]; then
    while [ "${#dir}" -gt $(( $maxcols - 4)) ]
    do
      prevdir="$dir"
      dir="${dir#*/}"
      if [ "$dir" == "$prevdir" ]; then
        break
      fi
    done
    dir=".../${dir}"
  fi
  echo $dir
}
export PS1='\u@${HOSTNAME,,}:[$ENVNAME][$(pwd_short)]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME,,}: ${PWD/#$HOME/~}\007"'
