#!/bin/bash

set -o errexit;
set -o nounset;

OKAY=$'\u2714'
FAILED=$'\u2715'
VIM_PLUG="$HOME/.local/share/nvim/site/autoload/plug.vim"

echo "Installing Vim Plug...";
update_plugins() {
      echo "Installing and updating plugins...";
      if ! nvim --headless +PlugUpdate! +UpdateRemotePlugins +qa > /dev/null 2>&1; then
          echo "Unable to install and update plugins.";
          exit 1;
      else
          echo "Vim plugins are installed and updated.";
      fi
}

if [ ! -e "$VIM_PLUG" ]; then
  echo "Vim plug is not installed."
  if ! curl -fLo "$VIM_PLUG" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null 2>&1; then
      echo "Unable to install Vim plug.";
      exit 1;
  else
      echo "Vim plug is installed." 
      update_plugins;
      exit 0;
  fi
else
  echo "Vim Plug is already installed.";
  update_plugins;
  exit 0;
fi
