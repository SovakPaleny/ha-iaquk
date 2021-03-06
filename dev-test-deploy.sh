#!/usr/bin/env bash

readonly __COLORS_ESCAPE="\033[";
readonly __COLORS_RESET="${__COLORS_ESCAPE}0m"
readonly __COLORS_RED="${__COLORS_ESCAPE}31m"
readonly __COLORS_GREEN="${__COLORS_ESCAPE}32m"
readonly __COLORS_MAGENTA="${__COLORS_ESCAPE}35m"

log.fatal() {
    local message=$*
    echo -e "${__COLORS_RED}${message}${__COLORS_RESET}" >&2
}

log.error() {
    local message=$*
    echo -e "${__COLORS_MAGENTA}${message}${__COLORS_RESET}" >&2
}

log.info() {
    local message=$*
    echo -e "${__COLORS_GREEN}${message}${__COLORS_RESET}" >&2
}

die() {
    local message=${1:-}
    local code=${2:-1}
    if [[ -n "${message}" ]]; then
        log.fatal "${message}"
    fi
    exit "${code}"
}



ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

HASSIO_CONFIG="${ROOT}/dev-config"

if [[ -d "${HASSIO_CONFIG}/custom_components" ]]; then
    log.info "Removing old versions of custom components..."
    cd "${HASSIO_CONFIG}/custom_components"
    rm -Rf $(ls -q "${ROOT}/custom_components/")
fi

log.info "Copy new versions of custom components..."
cp -R "${ROOT}/custom_components" "${HASSIO_CONFIG}/"
