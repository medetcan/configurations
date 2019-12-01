#!/bin/bash

set -o nounset
set -o errexit

OKAY=$'\u2714'
FAILED=$'\u2715'
SNAP="snap install_packages"
APT="apt install_packages"

source './packages.sh';

display_packages() {
  for package in "${packages[@]}"; do
    IFS=" " read -r TYPE NAME ARGS <<<"$package"
    echo "[-] $NAME"
  done
}

display_installed_packages() {
  for package in "${installed_packages[@]}"; do
    IFS=" " read -r NAME STATUS <<<"$package"
    echo -e "["$STATUS"] $NAME"
  done
}

install_package() {
  echo "Starting to install_packages $2"
  if ! $1 $3 $2 >/dev/null 2>&1; then
    echo "Failed to install_packages $2"
    installed_packages+=([$2]="$2 $FAILED")
  else
    echo "$2 installed"
    installed_packages+=([$2]="$2 $OKAY")
  fi
}

install_packages() {
  for package in "${packages[@]}"; do
    IFS=" " read TYPE NAME ARGS <<<"$package"
    case "$TYPE" in
    "apt")
      install_package "$APT" "$NAME" "$ARGS"
      ;;
    "snap")
      install_package "$SNAP" "$NAME" "$ARGS"
      ;;
    esac
  done
}

display_packages
install_packages packages
display_installed_packages
