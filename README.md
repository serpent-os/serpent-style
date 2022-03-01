# Serpent OS default code style

The present repository is designed to be added to each Dlang project as a git submodule via the
command:

`git submodule add https://gitlab.com/serpent-os/core/serpent-style.git`

The presence of this submodule implies that the superproject is governed by the Serpent OS
reference template for Dlang code style.

## `setup.sh`

Running `serpent-style/setup.sh` from the superproject root will do the following:

- symlink the `serpent-style/.editorconfig` into the root directory for proper
  [EditorConfig](https://editorconfig.org/) support
- symlink the `serpent-style/update-format.sh` script to `scripts/update-format.sh`
- create `scripts/` and `source/` folders if they don't exist
- remove the older `scripts/update_format.sh` script if it exists
- run the new `scripts/update-format.sh` script once and thus convert the superproject
  to the new serpent-style standards

## EditorConfig based

The current repository contains an `.editorconfig` file intended to be parsed by both editors and
the `dfmt` Dlang source code formatting tool.

This is an attempt at enforcing a consistent source code style across projects and a preemptive
attempt at avoiding code style bikeshedding discussions.

To learn more about EditorConfig, visit [https://editorconfig.org](https://editorconfig.org).

## `dfmt` required

The present project expects a working copy of `dfmt` to be present in the user's `$PATH` 
environment variable -- if `dfmt` is not present, the `scripts/update-format.sh` script will exit
noisily with an appropriate pointer.

As mentioned above, `dfmt` depends on and enforces the included `.editorconfig` configuration.

To learn more about `dfmt`, visit
[https://github.com/dlang-community/dfmt](https://github.com/dlang-community/dfmt).

## `codespell` required

Similarly, the presence of the `codespell` spell-checker program is expected and the script will
exit noisily if it is not found.

To learn more about `codespell`, visit
[https://pypi.org/project/codespell/](https://pypi.org/project/codespell/).

## A note on comments

As `dfmt` cannot parse comments, it is necessary to outline the expected format here. The primary
reason we want consistent comments is readability and thus maintainability.

The expected format is as follows:

```D
/**
 * This is a multi-line documentation comment.
 *
 * Multi-line documentation comments are expected to contain properly punctuated sentences.
 *
 * Single-line documentation comments such as /** foo bar baz */ are not allowed.
 */

 /* This is a single-line comment without punctuation */

 // double-slash comments are only used to flag FIXME: comments and are generally frowned upon.
```
