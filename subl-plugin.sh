#!/bin/bash
SUBL_PLUGIN_PATH=~/.config/sublime-text-3/Packages
PLUGIN_LIST_FILE=plugin-list
SCRIPT_NAME=subl-plugin.sh
CURRENT_PATH=$PWD

install()
{
  cd $SUBL_PLUGIN_PATH
  for item in `cat $CURRENT_PATH/$PLUGIN_LIST_FILE`
  do
    echo 'install ' $item
    git clone $item
  done
  cd $CURRENT_PATH
}

update()
{
  cd $SUBL_PLUGIN_PATH
  for item in `ls`
  do
    cd $item
    if [ -d '.git' ]; then
      echo 'upload ' $item
      git pull --rebase origin
    fi
    cd ..
  done
  cd $CURRENT_PATH
}

help()
{
  echo "usage: $SCRIPT_NAME install|update"
}

if ! type git &>/dev/null;then
  echo 'Please install Git first'
  exit 1
fi

if [ $# -le 0 ]; then
  help
elif [ $1 = 'install' -o $1 = 'update' ]; then
  $1
else
  help
fi
