#!/bin/sh -l

git config --global --add safe.directory /github/workspace

mainbranch=$1

branch=$(git branch | grep '*' | sed s/*'\s'//g) 

git checkout $branch 

if [ ! -z "$3" ]; then
    echo "//registry.npmjs.org/:_authToken=$3" > ./.npmrc
fi

npm i -D

files=$(git diff --name-only $branch $(git merge-base $branch $mainbranch) | grep -E '.+\.('$2')$')

npx eslint $files