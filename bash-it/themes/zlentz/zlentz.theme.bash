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

function prompt_command() {
    my_user="${cyan}\u@\h"
    my_pwd="${green}\w"
    my_end="${normal}\\$ "
    PS1="${lb}$(clock_prompt)${rb}$(my_env_ps1)${lb}${my_user} ${my_pwd}${rb}$(my_vcs)${my_end}"
}

safe_append_prompt_command prompt_command
