#!/bin/bash
THIS_DIR=`dirname $0`
source $THIS_DIR/vars.sh

backup() {
  mv $HOME/.$1 $HOME/.$1.$BAK
}

make_link() {
  ln -s $THIS_DIR/$1 $HOME/.$1
}

for f in $files
do
  backup $f
  make_link $f
done
