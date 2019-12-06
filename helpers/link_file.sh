#!/bin/bash

set -o nounset;
set -o errexit;

TARGET=$1;
DESTINATION=$2;

if ! ln -s $TARGET $DESTINATION > /dev/null 2>&1; then
    echo "Unable to create symbolic link from $TARGET to $DESTINATION. Exiting...";
    exit 1;
fi;

exit 0;
