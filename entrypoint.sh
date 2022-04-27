#!/bin/sh -l

git config --global --add safe.directory /github/workspace

mainbranch=$1

git checkout $mainbranch

branch=$(git branch | grep '*' | sed s/*'\s'//g)

files=$(git diff --name-only $branch $(git merge-base $branch $mainbranch) | grep '\.'$2'$')

npx eslint $files