#!/bin/bash

set -o errexit;
set -o nounset;

if [ ! -d $1 ]; then
    echo "$1 is not a directory. Exiting...";
    exit 1;
fi;

exit 0;
