# Serpent OS default code style

The present repository is designed to be added to each Dlang project as a git submodule via the
command:

`git submodule add git@gitlab.com:serpent-os/core/code-style.git`

The presence of this submodule implies that the superproject is governed by the Serpent OS
reference template for Dlang code style.

## `setup.sh`

Running `code-style/setup.sh` from the superproject root will symlink the `.editorconfig` into the
root directory and symlink the update-format.sh script to scripts/update-format.sh.

## `.editorconfig` based

The current repository contains an `.editorconfig` file intended to be parsed by both editors and
the `dfmt` Dlang source code formatting tool. This is an attempt at enforcing a consistent source
code style across projects and a preemptive attempt to avoid code-style bikeshedding discussions.

## `dfmt` required

It should be noted that the present project expects a working copy of `dfmt` to be present in the
user's `$PATH` environment variable -- if `dfmt` is not present, the `scripts/update-format.sh`
script will exit noisily with an appropriate pointer.

## `codespell` required

Similarly, the presence of the `codespell` spell-checker program is expected and the script will
exit noisily if it is not found.
