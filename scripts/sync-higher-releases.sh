#!/bin/bash

git remote prune origin
git fetch --all

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo "current branch: $CURRENT_BRANCH"
branches=($(git branch -r | grep 'origin/Release' | sed 's|origin/||'))

for branch in "${branches[@]}"; do 

    echo "currently on branch: $branch"

    MINOR_RELEASE_BRANCH="$(printf '%s\n' "$CURRENT_BRANCH" "$branch" | sort -V | head -n1)"
    echo "minor release: $MINOR_RELEASE_BRANCH"
    if [[ $MINOR_RELEASE_BRANCH == $CURRENT_BRANCH ]]; then

        echo "Current branch: $CURRENT_BRANCH is lower than branch: $branch. $CURRENT_BRANCH will be synched with $branch"
    fi

done


