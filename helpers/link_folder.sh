#!/bin/bash

set -o errexit;
set -o nounset;

PROJECT_ROOT=$(dirname $(dirname $(realpath $0)));

TARGET=$1;
DESTINATION=$2;

$PROJECT_ROOT/helpers/is_directory.sh $TARGET;
$PROJECT_ROOT/helpers/is_directory.sh $DESTINATION;
echo "Creating symbolic links...";
if ! cp -rfs $TARGET $DESTINATION > /dev/null 2>&1; then
    echo "Failed to create symbolics link from $TARGET to $DESTINATION";
else
    echo "Successfully symbolic link created from $TARGET to $DESTINATION";
fi;

exit 0;
