#!/bin/bash

set -o errexit;


PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath "$0"))))

display_help() {
    echo "Help!";
}

# Command Exist?
command_exists() {
    if ! $PROJECT_ROOT/helpers/command_exists.sh "jq" > /dev/null 2>&1 ; then
        echo "jq command does not exist. Installing..." 
        if sudo apt install jq -y -qq > /dev/null 2>&1; then
            echo "jq installed.";
        else
            echo "Unable to install jq. Exiting...";
        fi;
    fi;
}

display_packages() {
    local PACKAGES=$@;
    echo "Following Packages Will Be Installed;"
    for PACKAGE in $PACKAGES; do
        echo "[] $PACKAGE";
    done;
}

display_installed_packages() {
    echo "Hello";
}

filter_packages() {
    while [ -n "${1}" ]; do
        case "$1" in
            --exclude)
                echo "$2";
                shift;
                ;;
            --select)
                echo "$2";
                shift;
                ;;
            --help)
                display_help;
                shift;
                ;;
            *)
                display_help;
                shift;
                ;;
        esac;
    done;
}

command_exists;
PACKAGES=$(jq '.[] | select( .type =="server" or .type=="workstation" ) | (.name)' $PROJECT_ROOT/packages/configuration/dependencies.json);

#echo $PACKAGES;
#display_packages $PACKAGES;

filter_packages --select type=server,name=intellij-idea;
