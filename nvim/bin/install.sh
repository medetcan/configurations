#!/bin/bash

set -o nounset;
set -o errexit;

PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath $0))));
NVIM_HOME="${HOME}/.config/nvim";

if $PROJECT_ROOT/helpers/is_directory.sh $NVIM_HOME > /dev/null 2>&1; then
    if [ -h $NVIM_HOME ] && unlink $NVIM_HOME > /dev/null 2>&1 || rm -rf $NVIM_HOME > /dev/null 2>&1; then
            echo "Removed directory $NVIM_HOME";
        else
            echo "Unable to remove directory $NVIM_HOME";
            exit 1;
    fi;
fi
$PROJECT_ROOT/helpers/link_folder.sh "$PROJECT_ROOT/nvim/nvim/" "${HOME}/.config/";
$PROJECT_ROOT/nvim/bin/install_vim_plug.sh;
exit 0;
