#!/usr/bin/env bash
#
# Copyright © 2021-2022 Serpent OS Developers
#
set -e

CopyFiles=("LICENSE")
DeprecatedFiles=("scripts/update_format.sh")
LinkFiles=(".editorconfig" "dscanner.ini")
NukedAny=0

function failMsg()
{
	echo -e $*
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
	git commit -S -s -m "serpent-style: Remove deprecated assets"
fi

# Forcibly link the files in
for link in ${LinkFiles[@]}; do
	ln -svf "serpent-style/${link}" "."
done

# Forcibly copy the files in
for file in ${CopyFiles[@]}; do
    cp -vf "serpent-style/${file}" "."
done

# Link pre-commit hook in (using -r avoids dangling symlink)
ln -rsvf serpent-style/git-pre-commit-hook.sh .git/hooks/pre-commit

echo "Make sure to 'git add' any new links/files added by serpent-style/ and commit them"
