#!/bin/bash
export THIS_DIR=`dirname $0`
source $THIS_DIR/vars.sh

restore_backup() {
  if [ -f $HOME/.$1.$BAK ]; then
    rm $HOME/.$1
    mv $HOME/.$1.$BAK $HOME/.$1
  fi
}

for f in $files
do
  restore_backup $f
done
