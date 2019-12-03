#!/bin/bash

set -o nounset;
set -o errexit;

command_exists() {
    if ! command -v "${1}" > /dev/null; then
        echo "Command ${1} not exists. Exiting...";
        exit 1;
    fi;
}
