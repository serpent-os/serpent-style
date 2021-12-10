# Serpent OS default code style

If the current repository contains the present FORMATTING.md file, it means that it is governed by
the Serpent OS reference template for code style.

The contents of said reference template is designed in such a way that it can be copied verbatim
into the root of any Serpent OS project under SCM control (will almost always be `git`).

## `.editorconfig` based

The current repository contains an `.editorconfig` file intended to be parsed by both editors and
the `dfmt` Dlang source code formatting tool. This is an attempt at enforcing a consistent source
code style across projects and a preemptive attempt to avoid code-style bikeshedding discussions.

## `dfmt` required

It should be noted that the present project expects a working copy of `dfmt` to be present in the
user's `$PATH` environment variable -- if `dfmt` is not present, the `scripts/update_format.sh`
script will exit noisily with an appropriate pointer.

## `codespell` required

Similarly, the presence of the `codespell` spell-checker program is expected and the script will
exit noisily if it is not found.
