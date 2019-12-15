#!/bin/bash

set -o nounset;
set -o errexit;


PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath "$0"))))

help() {
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

# --filter; type=server,type=workstation...
#
# --exclude; intellij-idea-ultimate
filter_packages() {
    echo "Hello";
}

command_exists;
#jq '.[] | .type=="server" ' $PROJECT_ROOT/packages/configuration/dependencies.json;
PACKAGES=$(jq '.[] | select( .type =="server") | (.name)' $PROJECT_ROOT/packages/configuration/dependencies.json);

display_packages $PACKAGES;
