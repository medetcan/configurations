#!/bin/bash

set -o errexit;

PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath "$0"))))
DEPENDENCIES="$PROJECT_ROOT/packages/configuration/dependencies.json";
FILTER="";
OKAY=$'\u2714';
FAILED=$'\u2715';
SNAP="snap install";
APT="apt install";
declare -A INSTALLED_PACKAGES=()

display_help() {
cat <<HEREDOC
----------------------------------------------------------------------------------------------------------------------------------------------------------------
Usage: $0 --filter type=server --exclude name=git --list
----------------------------------------------------------------------------------------------------------------------------------------------------------------
[--list, -l]            List packages to be installed.
[--filter, -f]          Filters packages by a given criteria.
[--filter, -f]          Excludes packages by a given criteria.
[--help, -h]            Help.
----------------------------------------------------------------------------------------------------------------------------------------------------------------
HEREDOC
exit 0;
}

command_exists() {
    if ! $PROJECT_ROOT/helpers/command_exists.sh "jq" > /dev/null 2>&1 ; then
        echo "jq command does not exist. Installing..." 
        if sudo apt install jq -y -qq > /dev/null 2>&1; then
            echo "jq installed.";
        else
            echo "Unable to install jq. Exiting...";
            exit 1;
        fi;
    fi;
}

display_packages() {
    echo "Following Packages Will Be Installed;"
    if [ -n "${1}" ]; then
        while read -r PACKAGE; do
            echo -e "[] $PACKAGE"
        done <<< $1;
    fi;
}

display_installed_packages() {
    echo "Following Packages Are Installed;"
    for package in "${INSTALLED_PACKAGES[@]}"; do
        IFS=" " read -r NAME STATUS <<<"$package"
        echo -e "["$STATUS"] $NAME"
    done;
}

install_package() {
    echo "Installing $2..."
    if ! $1 $3 $2 > /dev/null 2>&1; then
        echo "Failed to install $2"
        INSTALLED_PACKAGES+=([$2]="$2 $FAILED")
    else
        echo "$2 installed"
        INSTALLED_PACKAGES+=([$2]="$2 $OKAY")
    fi;
}

install_packages() {
    local KEYS="$1";
    local VALUES="$2";
    while read KEY; do
        local NAME=$(jq -r ".[$KEY] | .name" <<< "$VALUES");
        local TYPE=$(jq -r ".[$KEY] | .pm" <<< "$VALUES");
        local ARGS=$(jq -r ".[$KEY] | .arguments | join(\" \")" <<< "$VALUES");
        case "$TYPE" in
            "apt")
                install_package "$APT" "$NAME" "$ARGS"
                ;;
            "snap")
                install_package "$SNAP" "$NAME" "$ARGS"
                ;;
        esac
    done <<< $KEYS;
}

filter_packages() {
    IFS="=" read KEY VALUE <<< $1;
    FILTER+=" | select ( .${KEY}$2\"${VALUE}\" )";
}

main() {
    while [ -n "${1}" ]; do
        case "$1" in
            --list | -l)
                display_packages "$(jq ".[] ${FILTER} | .name" $DEPENDENCIES)";
                exit 0;
                ;;
            --exclude | -e)
                filter_packages "$2" "!=";
                shift;
                ;;
            --filter | -f)
                filter_packages "$2" "==";
                shift;
                ;;
            --help)
                display_help;
                ;;
            *)
                display_help;
                ;;
        esac;
        shift;
    done;
}

${PROJECT_ROOT}/helpers/is_root.sh;
command_exists;
main "$@";
display_packages "$(jq ".[] ${FILTER} | .name" $DEPENDENCIES)";
install_packages "$(jq "[.[] ${FILTER}] | keys | .[]" $DEPENDENCIES)" "$(jq "[.[] ${FILTER}]" $DEPENDENCIES)";
display_installed_packages;
