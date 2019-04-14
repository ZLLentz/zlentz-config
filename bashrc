#!/usr/bin/env bash
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Let's be group-writable by default.
# Keep near top of bashrc because I may change this on some systems.
umask 002

# Define pathmunge if no system pathmunge
if ! [ -x "$(command -v pathmunge)" ] then
  pathmunge () {
    if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
      if [ "$2" = "after" ] ; then
        PATH=$PATH:$1
          else
        PATH=$1:$PATH
      fi
    fi
  }
  export pathmunge
fi

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
cd $HOME

# Pull in all of the larger changes from my config
if [ -f $HOME/.config/zlentz-config/extensions ]; then
  source $HOME/.config/zlentz-config/extensions
fi

# If I have system-specifc configurations, pull them in now
if [ -f $HOME/.bashrc_site ]; then
  source $HOME/.bashrc_site
fi
