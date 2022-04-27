#!/bin/sh -l

git config --global --add safe.directory /github/workspace

mainbranch=$1


branch=$(git branch | grep '*' | sed s/*'\s'//g) 

git checkout $branch 

npm i --only=dev

files=$(git diff --name-only $branch $(git merge-base $branch $mainbranch) | grep '\.'$2'$')

npx eslint $files