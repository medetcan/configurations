#!/bin/bash

set -o errexit;
set -o nounset;

PROJECT_ROOT=$(dirname $(dirname $(dirname $(realpath "$0"))));
TMP="${PROJECT_ROOT}/tex/tmp";
FILE="install-tl-unx.tar.gz";
TEXLIVE_URL="mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz";
INSTALLER="install-tl";
PROFILE="texlive.profile";

download_file() {
    echo "Downloading the installer...";
    if curl --create-dirs -fLo "${TMP}/${FILE}" ${TEXLIVE_URL} > /dev/null 2>&1; then
        echo "${FILE} is downloaded.";
    else
        echo "Unable to download into ${TMP} folder.";
        exit 1;
    fi;
}

extract_file() {
    echo "Extracting the installer...";
    if tar xf "${TMP}/${FILE}" -C ${TMP} --strip-components=1 > /dev/null 2>&1 && rm "${TMP}/${FILE}" > /dev/null 2>&1; then
        echo "${FILE} is extracted";
    else
        echo "Unable to extract ${FILE}";
        exit 1;
    fi;
}

install() {
    echo "Installing TeXLive...";
    if "${TMP}/${INSTALLER}" --profile "${PROJECT_ROOT}/tex/config/${PROFILE}" > /dev/null 2>&1 && rm -rf ${TMP} > /dev/null 2>&1; then
        echo "TeXLive is installed";
    else
        echo "Unable to install TeXLive";
        exit 1;
    fi;
}

download_file;
extract_file;
install;
exit 0;
