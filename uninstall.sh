#!/bin/bash
export THIS_DIR=`dirname $0`
source $THIS_DIR/vars.sh

restore_backup() {
  if [ -f $HOME/.$1.$BAK ]; then
    mv $HOME/.$1.$BAK $HOME/.$1
  fi
}

remove_symlink() {
  if [ -h $HOME/.$1 ]; then
    rm $HOME/.$1
  fi
}

for f in $files
do
  remove_symlink $f
  restore_backup $f
done
