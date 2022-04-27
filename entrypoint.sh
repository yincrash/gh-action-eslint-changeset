#!/bin/sh -l

git config --global --add safe.directory /github/workspace

mainbranch=$1

branch=$(git branch | grep '*' | sed s/*'\s'//g) 

git checkout $branch 

npm i -D

files=$(git diff --name-only $branch $(git merge-base $branch $mainbranch) | grep -E '.+\.('$2')$' $files)

npx eslint $files