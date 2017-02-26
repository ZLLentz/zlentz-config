# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Let's be group-writable by default.
# Keep near top of bashrc because I may change this on some systems.
umask 002

################
# Environments #
################

# Record original path
export orig_path=$PATH

# Modify the path to my liking
pathmunge() {
  if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
  fi
}

for path in "$HOME/bin"
do
  pathmunge $path
done

# Record my path
export my_path=$PATH

# Undo changes to paths 
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

# Fully clear path and reload this file
reset_env() {
  clear_env nopath
  source $HOME/.bashrc
}

# Used to get environment name into my PS1
envname() {
  export ENVNAME=$1
}

# Get my conda environment
conda_env() {
  clear_env
  export PATH="$HOME/conda/bin:$PATH"
  envname conda
  if ! [ -z $1 ]; then
      source activate "$1"
  fi
}
# Start with consistent envname with clear_env
clear_env

# PS1 Wizardry
# Standard PS1 has just cwd's name with no context
# Accumulate context directories until we hit our length quota
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

# Set the window title to show full directory
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME,,}: ${PWD/#$HOME/~}\007"'

# Append to history, set file size
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Shorthand so I don't have to type cd ../../../..
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
