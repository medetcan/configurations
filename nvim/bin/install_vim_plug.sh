#!/bin/bash

VIM_PLUG="$HOME/.local/share/nvim/site/autoload/plug.vim"

if [ ! -f "$VIM_PLUG" ]; then
  echo "Vim plug is not installed."
  curl -fLo "$VIM_PLUG" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null 2>&1;
  echo "Vim plug is installed";
  nvim +PlugInstall +UpdateRemotePlugins +qall
else
  echo "Vim Plug is already installed"
fi
