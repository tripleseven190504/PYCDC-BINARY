#!/bin/bash

if [ -f "./github/commit-count" ]; then
    OLD_COMMIT_COUNT=$(cat ./github/commit-count)
else
    OLD_COMMIT_COUNT=0
    echo "$OLD_COMMIT_COUNT" >./github/commit-count
fi

NEW_COMMIT_COUNT=$(curl -I -k "https://api.github.com/repos/zrax/pycdc/commits?per_page=1" | sed -n '/^[Ll]ink:/ s/.*"next".*page=\([0-9]*\).*"last".*/\1/p')
if [ "$NEW_COMMIT_COUNT" -gt "$OLD_COMMIT_COUNT" ]; then
    echo "$NEW_COMMIT_COUNT" >./github/commit-count
    echo "True"
    exit 0
else
    echo "False"
    exit 1
fi
