#!/usr/bin/env bash
#
# Copyright © 2021 Serpent OS developers
#

if [[ ! -d .git/ ]]; then
    echo "ERROR: ${PWD} does not contain a .git/ directory?"
    echo "       The script needs to be run from the root of a git repository."
    exit 1
fi

if [[ ! -d scripts/ ]]; then
    echo "ERROR: No './scripts/' directory found?"
    echo "       Please ensure that this script is run from the root of a git repository."
    exit 1
fi

if [[ ! -d source/ ]]; then
    echo "ERROR: No './source/' directory found?"
    exit 1
fi

D_FILES=""

# Autoformat the code.
command -v dfmt 2>&1 > /dev/null
if [[ $? -eq 0 ]]; then
    D_FILES="$(find source/ -name '*.d')"
    if [[ ${D_FILES} != "" ]]; then
        dfmt -i "${D_FILES}"
    else
        echo "ERROR: No *.d files found in ./source/ ?"
        exit 1
    fi
else
    echo "ERROR: dfmt code formatting tool not found in your PATH?"
    echo "       Please install dfmt and rerun scripts/update_format.sh"
    echo "       (git clone https://github.com/dlang-community/dfmt)"
    exit 1
fi

# Check we have no typos.
command -v codespell 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
    codespell "${D_FILES}"
else
    echo "ERROR: codespell not found?"
    echo "       Please install codespell!"
    exit 1
fi

# Nuke .orig files from modification
# find . -name '*.d.orig' | xargs -I{} rm -v {}
