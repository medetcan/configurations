#!/bin/bash

set -o errexit;
set -o nounset;

PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath "$0"))));
TMP="${PROJECT_ROOT}/tex/tmp";
FILE_NAME="install-tl-unx.tar.gz";
TEXLIVE_URL="mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz";
INSTALLER="install-tl";
PROFILE="texlive.profile";

download_file() {
echo "Downloading the installer...";
if curl --create-dirs -fLo "$TMP/$FILE_NAME" $TEXLIVE_URL > /dev/null 2>&1; then
    echo "$FILE_NAME is downloaded.";
else
    echo "Unable to download into $TMP folder.";
    exit 1;
fi;
}

extract_file() {
    if tar xf "$TMP/$FILE_NAME" -C $TMP --strip-components=1 && rm "$TMP/$FILE_NAME" > /dev/null 2>&1; then
        echo "$FILE_NAME is extracted";
    else
        echo "Unable to extract $FILE_NAME";
        exit 1;
    fi;
}

install() {
    echo "Installing TeXLive...";
    if "./$TMP/$INSTALLER" --profile="$PROJECT_ROOT/config/$PROFILE" && rm -rf $TMP > /dev/null 2>&1; then
        echo "TeXLive is installed";
    else
        echo "Unable to install TeXLive";
        exit 1;
    fi;
}

download_file;
extract_file;
install
exit 0;
