#!/usr/bin/env bash

# Autoformat the code.
command -v dfmt 2>&1 > /dev/null
if [[ $? -eq 0 ]]; then
    dfmt -i $(find source/ -name '*.d')
else
    echo "ERROR: dfmt code formatting tool not found in your PATH?"
    echo "       Please install dfmt and rerun scripts/update_format.sh"
    echo "       (git clone https://github.com/dlang-community/dfmt)"
    exit 1
fi

# Check we have no typos.
command -v codespell 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
    echo "Potentially misspelled words (per codespell):"
    codespell $(find source/ -name '*.d')
else
    echo "ERROR: codespell not found?"
    echo "       Please install codespell!"
    exit 1
fi

# Nuke .orig files from modification
find . -name '*.d.orig' | xargs -I{} rm -v {}
