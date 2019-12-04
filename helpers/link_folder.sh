#!/bin/bash

set -o errexit;
set -o nounset;

TARGET=$1
DESTINATION=$2

is_directory() {
    if [ ! -d $1 ]; then
        echo "$1 is not a directory. Exiting...";
        exit 1;
    fi;
}

is_directory $TARGET;
is_directory $DESTINATION;

echo "Creating symbolic links...";
if [ ! cp -rs $1 $2 > /dev/null 2>&1 ]; then
    echo "Successfully symbolic link created from $TARGET to $DESTINATION";
else
    echo "Failed to create symbolic link from $TARGET to $DESTINATION";
fi;
