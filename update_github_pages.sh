#!/bin/bash
set -Ceux

git config user.email "travis-build-bot@example.com"
git config user.name "Autobuild bot on Travis-CI"
git config --local core.quotepath false
git pull origin master
if [ $(git status -s | wc -l) -eq 0 ]; then
    echo "nothing to commit"
    exit 0
elif [ $(git --no-pager diff -G"最終更新日時: " | wc -l) -eq 0 ]; then
    git add .
else
    files_to_add=$(git --no-pager diff --numstat | awk '! ($1 == 1 && $2 == 1 && $3 ~ /.html$/) { print $3 }')
    if [ -z "${files_to_add}" ]; then
        echo "nothing to commit except for lines of '最終更新日時: '"
        exit 0
    else
        git add ${files_to_add}
    fi
fi
git commit -m "update html"
