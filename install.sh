#!/bin/bash
THIS_DIR=`readlink -f "$(dirname $0)"`
INSTALL_DIR="${HOME}/.config/zlentz-config"
FULL_INSTALL_DIR="$(readlink -f $INSTALL_DIR)"
if [ "$THIS_DIR" != "$FULL_INSTALL_DIR" ]; then
  echo "You should have put me in ${INSTALL_DIR}"
  exit
fi
source $INSTALL_DIR/vars.sh

backup() {
  if [ -f $HOME/.$1 ]; then
    mv $HOME/.$1 $HOME/.$1.$BAK
  fi
}

make_link() {
  ln -s $INSTALL_DIR/$1 $HOME/.$1
}

# Place soft-links
for f in $files
do
  backup $f
  make_link $f
done
