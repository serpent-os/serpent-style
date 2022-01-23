#!/usr/bin/env bash
#
# Copyright © 2021-2022 Serpent OS Developers
#
set -e

DeprecatedFiles=("scripts/update_format.sh")
LinkFiles=(".editorconfig" "dscanner.ini")
NukedAny=0

function failMsg()
{
	echo $*
	exit 1
}

[[ -z $(git status --untracked-files=no --porcelain .) ]] || failMsg "Ensure git tree is clean before running this script"
test -e .git || failMsg "Please run from the root of a git project"


# Deprecate old scripts
for depr in ${DeprecatedFiles[@]}; do
	if [[ -e "${depr}" ]]; then
		echo "Removing deprecated asset: ${depr}"
		git rm "${depr}"
		NukedAny=1
	fi
done

if [[ "${NukedAny}" == "1" ]]; then
	echo "Commiting changes..."
	git commit -m "code-style: Removing deprecated scripts"
fi

# Forcibly link the files in
for link in ${LinkFiles[@]}; do
	ln -svf "code-style/${link}" "."
done

echo "Make sure you add any new links and commit them"
