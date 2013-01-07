#!/bin/bash

# This script runs gofmt on all staged files to ensure proper formatting.
# Any detected errors will be printed to stdout and the commit aborted.

# NOTE: This script probably won't work for partial changes added with
# git add -p or git commit -p.

command -v gofmt >/dev/null 2>&1 || { echo >&2 "gofmt not on PATH."; exit 1; }

git stash -q --keep-index >/dev/null

IFS='\n'
exitcode=0
for file in $(git diff --staged --name-only --diff-filter=ACMR | grep '\.go$')
do
    output=`gofmt -w=true "$file"`
    if [ -n $output ]
    then
            # any output is a syntax error
        echo >&2 "$output"
        exitcode=1
    fi
    git add "$file"
done

git stash pop -q >/dev/null 2>&1

exit $exitcode
