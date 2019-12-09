#!/bin/bash

set -o errexit;
set -o nounset;

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1;
fi

exit 0;
