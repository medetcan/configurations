#!/bin/bash

set -o nounset
set -o errexit

PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath "$0"))));
OKAY=$'\u2714'
FAILED=$'\u2715'
SNAP="snap install"
APT="apt install"
declare -A installed_packages=()
declare -A packages=(
  ["node"]="snap node --classic --channel=12"
  ["code"]="snap code --classic"
  ["postman"]="snap postman"
  ["cmake"]="snap cmake --classic"
  ["clion"]="snap clion --classic"
  ["datagrip"]="snap datagrip --classic"
  ["intellij-idea-ultimate"]="snap intellij-idea-ultimate --classic"
  ["webstorm"]="snap webstorm --classic"
  ["pycharm-professional"]="snap pycharm-professional --classic"
  ["android-studio"]="snap android-studio --classic"
  ["default-jdk"]="apt default-jdk -y -qq"
  ["openjdk-8-jdk"]="apt openjdk-8-jdk -y -qq"
  ["openjdk-11-jdk"]="apt openjdk-11-jdk -y -qq"
  ["openjdk-13-jdk"]="apt openjdk-13-jdk -y -qq"
  ["neovim"]="apt neovim -y -qq"
  ["pip3"]="apt python3-pip -y -qq"
  ["python3-dev"]="apt python3-dev -y -qq"
  ["build-essential"]="apt build-essential -y -qq"
  ["git"]="apt git -y -qq"
  ["gnome-tweaks"]="apt gnome-tweaks -y -qq"
  ["dash-to-dock"]="apt gnome-shell-extension-dashtodock -y -qq"
)

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

${PROJECT_ROOT}/helpers/is_root.sh;
display_packages
install_packages 
display_installed_packages
