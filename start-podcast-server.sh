#!/bin/bash

echo "node location"
which node
echo "Starting podcast server"
scriptdirectory="$(dirname "$0")"
echo Moving to script directory $scriptdirectory
cd $(dirname "$0")
echo Current directory is $(pwd)

echo "Updating the git repository"

git remote update
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull. Pulling ..."
    git pull --rebase
    echo "Done."
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi

echo "Starting server ..."

node podcastserve.js 
#/usr/bin/node serveronly
#DISPLAY=:0 nohup npm start

echo "Done."
