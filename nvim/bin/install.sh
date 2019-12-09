#!/bin/bash

set -o nounset;
set -o errexit;

PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath $0))));

$PROJECT_ROOT/helpers/is_directory.sh "${HOME}/.config/nvim/" > /dev/null 2>&1 || mkdir -p "${HOME}/.config/nvim/" > /dev/null 2>&1;
$PROJECT_ROOT/helpers/link_folder.sh "$PROJECT_ROOT/nvim/configuration/*" "${HOME}/.config/nvim/";
$PROJECT_ROOT/nvim/bin/install_vim_plug.sh;

exit 0;
