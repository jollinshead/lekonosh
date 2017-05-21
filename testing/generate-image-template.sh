#!/usr/bin/env bash

makeBanner() {
    local FILE="${1:-}";
    echo "FILE: ${FILE}"
    if [ ${FILE: -4} == ".jpg" ] || [ ${FILE: -5} == ".jpeg" ] || [ ${FILE: -4} == ".png" ] ; then
        NEWFILE=$(basename "${1}" | cut -f 1 -d '.')_banner.jpg
        cp -f "${FILE}" "${NEWFILE}"
        sips --resampleWidth 500 "${NEWFILE}"
        sips --cropToHeightWidth 50 500 "${NEWFILE}"
    fi
}

PrevPWD="${PWD}"
for var in "$@"; do
    cd "${PrevPWD}"
    if [[ -d "${var}" ]]; then
        cd "${var}"
        for file in "${var}/*/"; do
            makeBanner "${file}"
        done
    elif [[ -f "${var}" ]]; then
        cd $(dirname "${var}")
        makeBanner "${var}"
    fi
done