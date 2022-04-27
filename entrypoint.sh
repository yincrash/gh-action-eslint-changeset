#!/bin/sh -l

mainbranch=$1

branch=$(git branch | grep '*' | sed s/*'\s'//g)

files=$(git diff --name-only $branch $(git merge-base $branch $mainbranch) | grep '\.'$2)

npx eslint $files

time=$(date)
echo "::set-output name=something::$time"