#!/bin/bash

set -o errexit;


PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath "$0"))))
FILTER="";
EXCLUDE=".";
DEPENDENCIES="$PROJECT_ROOT/packages/configuration/dependencies.json";
IFS=;

display_help() {
    echo "Help!";
}

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
    echo "Following Packages Will Be Installed;"
    if [ -n "${1}" ]; then
        while read -r PACKAGE; do
            echo "[] $PACKAGE"
        done <<< $1;
    fi;
}

display_installed_packages() {
    echo "Hello";
}

filter_packages() {
    local OLDIFS=$IFS
    IFS="="; read -r KEY VALUE <<< $1;
    FILTER+=" | select ( .${KEY}==\"${VALUE}\" )";
    IFS=$OLDIFS
}

exclude_packages() {
    local OLDIFS=$IFS
    IFS="="; read -r KEY VALUE <<< $1;
    FILTER+=" | select ( .${KEY}!=\"${VALUE}\" )";
    IFS=$OLDIFS
}

install_packages() {
    while [ -n "${1}" ]; do
        case "$1" in
            --list | -l)
                display_packages $(jq ".[] ${FILTER} | .name" $DEPENDENCIES);
                exit 0;
                ;;
            --exclude | -e)
                exclude_packages $2;
                shift;
                ;;
            --filter | -f)
                filter_packages $2;
                shift;
                ;;
            --help)
                display_help;
                exit 0;
                ;;
            *)
                display_help;
                exit 0;
                ;;
        esac;
        shift;
    done;
}

command_exists;
install_packages --filter type=server --exclude name=node -e name=cmake --list;
PACKAGES=$(jq ".[] ${FILTER}" $DEPENDENCIES);
#echo $PACKAGES;


