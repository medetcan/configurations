#!/bin/bash

set -o nounset;
set -o errexit;

PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath $0))))
OKAY=$'\u2714'
FAILED=$'\u2715'
declare -A installed_plugins=()
declare -a plugins=(
    "vscodevim.vim"
    "zhuangtongfa.material-theme"
)

display_plugins() {
    echo -e "Installing following VS Code plugins:"
    for plugin in "${plugins[@]}"; do
        echo "[-] $plugin"
    done
}

display_installed_plugins() {
    echo -e "\nInstalled following VS Code plugins:"
    for plugin in "${installed_plugins[@]}"; do
    IFS=" " read -r NAME STATUS <<< $plugin;
    echo "[$STATUS] $NAME"
    done
}

install_plugins() {
    for plugin in "${plugins[@]}"; do
        if ! code --install-extension "$plugin" > /dev/null 2>&1; then
            installed_plugins+=([$plugin]="$plugin $FAILED")
        else
            installed_plugins+=([$plugin]="$plugin $OKAY")
        fi
    done
}

$PROJECT_ROOT/helpers/command_exists.sh "code";
display_plugins
install_plugins
display_installed_plugins

exit 0;
