#!/bin/bash

set -o nounset;
set -o errexit;

if ! command -v "${1}" > /dev/null; then
    echo "Command ${1} not exists. Exiting...";
    exit 1;
fi;

exit 0;
