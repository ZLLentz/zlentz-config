#!/usr/bin/env bash
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Let's be group-writable by default.
# Keep near top of bashrc because I may change this on some systems.
umask 002

# Initialize bash-it. This also collects aliases from my config repo.
export BASH_IT="${HOME}/.config/bash-it"
export BASH_IT_THEME='zlentz'
export BASH_IT_CUSTOM="${HOME}/.config/zlentz-config/bash-it"
export SCM_CHECK=true
export TODO="t"

source "${BASH_IT}"/bash_it.sh

# Add my home bin directory to the path
if [ -d "${HOME}/bin" ]; then
  pathmunge "${HOME}/bin"
fi

# Please no more false mail messages
unset MAILCHECK

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Yay vim
export EDITOR=vim

# Place me in home, not desktop
if [ "$(pwd)" == "$HOME/Desktop" ]; then
  cd
fi

# If I have system-specifc configurations, pull them in now
if [ -f $HOME/.bashrc_site ]; then
  source $HOME/.bashrc_site
fi
