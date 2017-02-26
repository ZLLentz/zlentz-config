#!/bin/bash
BAK="bak.config"
THIS_DIR=`dirname $0`
files="bashrc gitconfig inputrc profile vimrc"

backup() {
  mv $1 $1.$BAK
}

make_link() {
  ln -s $THIS_DIR/$1 ~/.$1
}

for f in $files
do
  backup $f
  make_link $f
done
