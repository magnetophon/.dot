#!/usr/bin/env bash
set -euo pipefail

# Make sure local view of the remote is current
git fetch --prune origin


mapfile -t branches < <(
    git for-each-ref --format='%(refname)' refs/remotes/origin \
        | grep -v '^refs/remotes/origin/HEAD$' \
        | sed 's|^refs/remotes/origin/||'
)

now=$(date +%s)

for branch in "${branches[@]}"; do
    # Skip anything pathological (empty, or named just "origin")
    [[ -z "$branch" || "$branch" == "origin" ]] && {
        echo "skipping suspicious ref: '$branch'" >&2
        continue
    }

    ref="refs/remotes/origin/$branch"

    if git merge-base --is-ancestor "$ref" refs/remotes/origin/HEAD 2>/dev/null; then
        continue
    fi

    last_iso=$(git show -s --format=%cI "$ref")
    last_epoch=$(date -d "$last_iso" +%s)
    days=$(( (now - last_epoch) / 86400 ))

    echo "last commit on $branch was $days days ago"

    if (( days > 365 )); then
        git push origin --delete "$branch"
        git update-ref -d "$ref" || true
        echo "deleted old branch $branch"
    fi
done
