#!/bin/bash

git remote prune origin
git fetch --all

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo "current branch: $CURRENT_BRANCH"
branches=($(git branch -r | grep 'origin/Release' | sed 's|origin/||'))

for branch in "${branches[@]}"; do 

    echo "currently on loop branch: $branch"

    MINOR_RELEASE_BRANCH="$(printf '%s\n' "$CURRENT_BRANCH" "$branch" | sort -V | head -n1)"
    echo "minor release: $MINOR_RELEASE_BRANCH"
    # if [[ $branch == $CURRENT_BRANCH ]]; then
    #     echo "Branch of this loop is the same as my current branch. Skipping..."
    #     continue
    # fi
<<<<<<< HEAD
    if [[ $MINOR_RELEASE_BRANCH == $CURRENT_BRANCH ]]; then
=======
    if [[ $MINOR_RELEASE_BRANCH == $CURRENT_BRANCH && $CURRENT_BRANCH != $branch ]]; then
>>>>>>> origin/Release/1.0.0

        echo "Current branch: $CURRENT_BRANCH is lower than branch: $branch. $CURRENT_BRANCH will be synched with $branch"

        # Update Development
        git fetch origin "$branch"
        git checkout "$branch"
        git pull origin "$branch"

        # Fetch the source branch (Hotfix branch)
        git fetch origin "$MINOR_RELEASE_BRANCH"

        # Check if latest commit comes from source branch
        if git merge-base --is-ancestor "origin/$MINOR_RELEASE_BRANCH" "$branch"; then
            echo "Changes from $MINOR_RELEASE_BRANCH are already in $branch"
        else
            echo "Changes from $MINOR_RELEASE_BRANCH are NOT yet in $branch"
<<<<<<< HEAD
        fi
    fi
=======
            if git merge "origin/$MINOR_RELEASE_BRANCH" --no-ff -m "merging $MINOR_RELEASE_BRANCH to $branch"; then
                echo "Merge successful, pushing changes..."
                git push origin $branch
                echo "=== Synchronization completed successfully ==="
            else
                echo "Error: Merge failed. Possible conflicts detected."
                echo "Repository status:"
                git status
                exit 1
            fi
        fi
    fi
    git checkout "$CURRENT_BRANCH"
>>>>>>> origin/Release/1.0.0

done


