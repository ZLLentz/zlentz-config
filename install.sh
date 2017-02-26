#!/bin/bash
THIS_DIR=`readlink -f "$(dirname $0)"`
source $THIS_DIR/vars.sh

backup() {
  if [ -f $HOME/.$1 ]; then
    mv $HOME/.$1 $HOME/.$1.$BAK
  fi
}

make_link() {
  ln -s $THIS_DIR/$1 $HOME/.$1
}

for f in $files
do
  backup $f
  make_link $f
done
