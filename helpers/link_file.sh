#!/bin/bash

set -o nounset;
set -o errexit;

TARGET=$1
LINK_NAME=$2

link_file() {
    ln -s TARGET LINK_NAME;
}

link_file TARGET LINK_NAME;

exit 0;
