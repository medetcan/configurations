#!/bin/bash

set -o errexit;
set -o nounset;


if [ ! -e $1 ]; then
    echo "$1 is not a file. Exiting..."
    exit 1;
fi;

exit 0;
