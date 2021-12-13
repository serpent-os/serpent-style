# Serpent OS default code style

The present repository is designed to be added to each Dlang project as a git submodule via the
command:

`git submodule add git@gitlab.com:serpent-os/core/code-style.git`

The presence of this submodule implies that the superproject is governed by the Serpent OS
reference template for Dlang code style.

## `setup.sh`

Running `code-style/setup.sh` from the superproject root will do the following:

- symlink the `code-style/.editorconfig` into the root directory for proper
  [EditorConfig](https://editorconfig.org/) support
- symlink the `code-style/update-format.sh` script to `scripts/update-format.sh`
- create `scripts/` and `source/` folders if they don't exist
- remove the older `scripts/update_format.sh` script
- run the new `scripts/update-format.sh` script once and thus convert the superproject
  to the new code-style standards

## `.editorconfig` based

The current repository contains an `.editorconfig` file intended to be parsed by both editors and
the `dfmt` Dlang source code formatting tool. This is an attempt at enforcing a consistent source
code style across projects and a preemptive attempt to avoid code-style bikeshedding discussions.

## `dfmt` required

It should be noted that the present project expects a working copy of `dfmt` to be present in the
user's `$PATH` environment variable -- if `dfmt` is not present, the `scripts/update-format.sh`
script will exit noisily with an appropriate pointer.

`dfmt` depends on and enforces the included `.editorconfig` configuration.

## `codespell` required

Similarly, the presence of the `codespell` spell-checker program is expected and the script will
exit noisily if it is not found.
