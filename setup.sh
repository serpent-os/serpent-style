#!/usr/bin/env bash
#
# Copyright © 2021 Serpent OS Developers
#

# attempt to ensure that we're run from the superproject root
if [[ -f code-style/update-format.sh && -d .git/ ]];then
    mkdir -pv scripts/ source/
    ln -sfv code-style/.editorconfig .editorconfig
    pushd scripts
    ln -sfv ../code-style/update-format.sh update-format.sh
    popd
    # Remove legacy update_format.sh as a precaution
    git rm --ignore-unmatch scripts/update_format.sh
    source code-style/update-format.sh
else
    echo "Please run 'code-style/setup.sh' from the root of a Serpent OS git project."
    exit 1
fi


