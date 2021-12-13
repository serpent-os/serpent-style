#!/usr/bin/env bash
#
# Copyright © 2021 Serpent OS Developers
#

# attempt to ensure that we're run from the superproject root
if [[ -f code-style/update-format.sh && -d .git/ ]];then
    mkdir -pv scripts/ source/
    git rm scripts/update_format.sh
    ln -sfv code-style/update-format.sh scripts/update-format.sh
    ln -sfv code-style/.editorconfig .editorconfig
    source code-style/update-format.sh
else
    echo "Please run 'code-style/setup.sh' from the root of a Serpent OS git project."
    exit 1
fi


