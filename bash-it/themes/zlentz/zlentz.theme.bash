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

function ps1_lines() {
  export my_lines_opt="$1"
}

ps1_lines 0
ver_short=$(echo $BASH_VERSION | cut -c 1,3)

function prompt_command() {
    PS1_MAIN="${lb}$(clock_prompt)${rb}$(my_env_ps1)${lb}${my_user} ${my_pwd}${rb}$(my_vcs)${my_end}"
    PS1="${PS1_MAIN}\$ "
    if [ $my_lines_opt == 1 ]; then
        return
    elif [ $my_lines_opt -gt 1 ]; then
        PS1="${PS1_MAIN}\n\$ "
    elif [ $ver_short -ge 44 ]; then
        PS1_RAW="${PS1_MAIN@P}"
        PS1_RAW=$(echo $PS1_RAW | sed -E "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
        PS1_RAW="${PS1_RAW//[$'\001'$'\002']}"
        PS1_SIZE="${#PS1_RAW}"
        MAX_PS1_SIZE="$(( $(tput cols) / 2 ))"
        if [ "${PS1_SIZE}" -gt "${MAX_PS1_SIZE}" ]; then
            PS1="${PS1_MAIN}\n\$ "
        fi
    fi
}

safe_append_prompt_command prompt_command
