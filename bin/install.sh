#!/bin/bash

set +o errexit
set -o nounset;

PROJECT_ROOT=$(dirname $(dirname $(realpath "$0")));
PACKAGES="${PROJECT_ROOT}/packages/bin/install.sh";
NVIM="${PROJECT_ROOT}/nvim/bin/install.sh";
VSCODE="${PROJECT_ROOT}/vscode/bin/install.sh";
RUST="${PROJECT_ROOT}/rust/bin/install.sh";
TEX="${PROJECT_ROOT}/tex/bin/install.sh";

$PACKAGES;
$NVIM;
$VSCODE;
$RUST;
$TEX;
