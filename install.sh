#!/bin/bash
THIS_DIR=`readlink -f "$(dirname $0)"`
INSTALL_DIR="${HOME}/.config/zlentz-config"
if [ "$THIS_DIR" != "$INSTALL_DIR" ]; then
  echo "You should have put me in ${INSTALL_DIR}"
  exit
fi
source $THIS_DIR/vars.sh

backup() {
  if [ -f $HOME/.$1 ]; then
    mv $HOME/.$1 $HOME/.$1.$BAK
  fi
}

make_link() {
  ln -s $THIS_DIR/$1 $HOME/.$1
}

# Place soft-links
for f in $files
do
  backup $f
  make_link $f
done

# Initialize bash-it
if [ ! -f "${BASH_IT_DIR}" ]; then
  git clone --depth=1 "https://github.com/Bash-it/bash-it.git" "${BASH_IT_DIR}"
  sh ${BASH_IT_DIR}/install.sh --silent --no-modify-config
fi

# Install vim plugins
mkdir -p "${VIM_BUNDLE}"
if [ ! -f "${VIM_BUNDLE}/Vundle.vim" ]; then
  git clone "https://github.com/VundleVim/Vundle.vim" "${VIM_BUNDLE}"
fi
vim -c PluginInstall -c quitall
