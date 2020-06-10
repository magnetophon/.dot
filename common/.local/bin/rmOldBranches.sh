#!/usr/bin/env bash
set -euo pipefail


tarBranch=$(git branch -r --no-merged | grep origin | sed 's/origin\///')
for branch in $tarBranch
do
    echo $branch
    lastDate=$(git show -s --format=%ci origin/$branch)
    convertDate=$(echo $lastDate | cut -d' ' -f 1)
    Todate=$(date -d "$convertDate" +'%s')
    current=$(date +'%s')
    day=$(( ( $current - $Todate )/60/60/24 ))
    echo "last commit on $branch branch was $day days ago"
    if [ "$day" -gt 365 ]; then
        git push origin :$branch
        # git branch -D $branch
        echo "delete the old branch $branch"
    fi
done
