#!/usr/bin/env bash
#
# Copyright © 2021 Serpent OS developers
#

function noisyFail () {
    if [[ -z "$1" ]]; then
       echo ""
       echo "\033[1;31mERROR:\033[0m\033[1m  No message parameter specified for noisyFail?\033[0m"
       echo ""
       exit 1
    fi
    # set up terminal colours
    BOLDRED="\033[1;31m"
    BOLD="\033[1m"
    RESET="\033[0m"
    ERRMSG="${BOLDRED}ERROR:${RESET}${BOLD}  ${1}${RESET}"
    echo ""
    echo -e "${ERRMSG}"
    echo ""
    exit 1
}

if [[ ! -d .git/ ]]; then
    MSG="${PWD} does not contain a .git/ directory?\n\
        - please ensure that this script is run from the root of a git repository."
    noisyFail "${MSG}"
fi

if [[ ! -d scripts/ ]]; then
    MSG="${PWD} does not contain a scripts/ directory?\n\
        - please ensure that this script is run from the root of a git repository."
    noisyFail "${MSG}"
fi

if [[ ! -d source/ ]]; then
    MSG="${PWD} does not contain a source/ directory?"
    noisyFail "${MSG}"
fi

command -v iconv 2>&1 > /dev/null
if [[ ! $? -eq 0 ]]; then
    MSG="'iconv' character set conversion tool not found?"
    noisyFail "${MSG}"
fi

command -v xargs 2>&1 > /dev/null
if [[ ! $? -eq 0 ]]; then
    MSG="'xargs' utility (part of GNU findutils) not found?"
    noisyFail "${MSG}"
fi

D_FILES=""

# Autoformat the code.
command -v dfmt 2>&1 > /dev/null
if [[ $? -eq 0 ]]; then
    D_FILES="$(find source/ -name '*.d')"
    if [[ ${D_FILES} != "" ]]; then
        echo "${D_FILES}" | xargs -n1 iconv --verbose -t utf8 > /dev/null || noisyFail "Failed to convert source/*.d to utf-8"
        dfmt -i "${D_FILES}"
    else
        MSG="No '*.d' Dlang source files found in ${PWD}/source/ directory?"
        noisyFail "${MSG}"
    fi
else
    MSG="'dfmt' code formatting tool not found in your \$PATH?\n\
        - please install 'dfmt' and rerun 'scripts/update_format.sh'\n\
        (git clone https://github.com/dlang-community/dfmt)."
    noisyFail "${MSG}"
fi

# Check we have no typos.
command -v codespell 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
    codespell "${D_FILES}"
else
    MSG="'codespell' spell checking tool not found in your \$PATH?\n\
        - please install 'codespell'."
    noisyFail "${MSG}"
fi

# Nuke .orig files from modification
# find . -name '*.d.orig' | xargs -I{} rm -v {}
