#!/usr/bin/env bash
#
# SPDX-License-Identifier: Zlib
#
# Copyright: © 2020-2022 Serpent OS Developers

#
# Git pre-commit hook for serpent-style'd projects.
#
# Inspired by examples from:
#
#   https://codeinthehole.com/tips/tips-for-using-a-git-pre-commit-hook/
#

#set -x

# This assumes that directories ending in .d are never added...
D_FILES='\.d$'

function noisyFail ()
{
    if [[ -z "$1" ]]; then
       echo ""
       echo "\033[1;31mERROR:\033[0m\033[1m  No message parameter specified for noisyFail?\033[0m"
       echo ""
       exit 1
    fi
    # set up terminal colours
    BOLDRED="\033[1;31m"
    BOLD="\033[1m"
    RESET="\033[0m"
    ERRMSG="${BOLDRED}ERROR:${RESET}${BOLD}  ${1}${RESET}"
    echo ""
    echo -e "${ERRMSG}"
    echo ""
    exit 1
}

# we don't want writeln / writefln in the code
# (except under specific circumstances)

function forbiddenPatterns ()
{
    # let's start with simple printing patterns
    local FORBIDDEN='write(f|)ln'
    git diff --cached --name-only | \
        grep -E "${D_FILES}" | \
        GREP_COLOR='4;5;37;41' xargs grep --color --with-filename -n -E "${FORBIDDEN}" \
        && noisyFail "
  COMMIT REJECTED
  -- Found \$FORBIDDEN ('$FORBIDDEN') references.
  >> Please remove them before committing!"
}

# list of enabled functions
forbiddenPatterns
