#!/bin/bash

set -o errexit;
set -o nounset;

PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath "$0"))))
RUST_PATH="~/.cargo/bin";

echo "Installing Rust...";
if ! curl -f --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y > /dev/null 2>&1 && $PROJECT_ROOT/helpers/is_directory.sh $RUST_PATH; then
 echo "Unable to install rust";
 exit 1;
else
 echo "Rust installed.";
 exit 0;
fi;

