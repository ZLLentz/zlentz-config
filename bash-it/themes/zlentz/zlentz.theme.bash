#!/usr/bin/env bash

lb="${yellow}["
rb="${yellow}]"

SCM_THEME_PROMPT_DIRTY=" ${red}+"
SCM_THEME_PROMPT_CLEAN=" ${green}-"
SCM_THEME_PROMPT_PREFIX="${lb}"
SCM_THEME_PROMPT_SUFFIX="${rb}"
SCM_THEME_BRANCH_PREFIX="${purple}"
SCM_THEME_DETACHED_PREFIX="Detached"

THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"${green}"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%-l:%M %P"}

export PROMPT_DIRTRIM=3

function my_vcs() {
  text="$(git_prompt_info)"
  detached="$(echo $text | grep Detached)"
  if [ -z "$detached" ]; then
    echo "$(git_prompt_minimal_info)"
  fi
}

function my_env_ps1() {
  if [ ! -z $ENVNAME ]; then
    if [ ! -z "${CONDA_DEFAULT_ENV}" ]; then
      ext=" ${CONDA_DEFAULT_ENV}"
    else
      ext=""
    fi
    echo "${lb}${purple}${ENVNAME}${ext}${rb}"
  fi
}

my_user="${cyan}\u@\h"
my_pwd="${green}\w"
my_end="${normal}"

ver_short=$(echo $BASH_VERSION | cut -c 1,3)

function expand_ps1() {
  if [ $ver_short -ge 44 ]; then
    echo "${1@P}"
  else
    echo $(PS1="$1" "$BASH" --norc -i </dev/null 2>&1 | sed -n '${s/^\(.*\)exit$/\1/p;}')
  fi
}

function decolor() {
  text=$(echo $1 | sed -E "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
  text="${text//[$'\001'$'\002']}"
  echo $text
}

function prompt_command() {
    PS1_MAIN="${lb}$(clock_prompt)${rb}$(my_env_ps1)${lb}${my_user} ${my_pwd}${rb}$(my_vcs)${my_end}"
    PS1_EXPAND="$(expand_ps1 "$PS1_MAIN")"
    PS1_RAW="$(decolor "$PS1_EXPAND")"
    PS1_SIZE="${#PS1_RAW}"
    MAX_PS1_SIZE="$(( $(tput cols) / 2 ))"
    if [ "${PS1_SIZE}" -gt "${MAX_PS1_SIZE}" ]; then
      PS1="${PS1_MAIN}\n\$ "
    else
      PS1="${PS1_MAIN}\$ "
    fi
}

safe_append_prompt_command prompt_command
