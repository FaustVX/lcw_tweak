#!/bin/bash
line=$(head -n "+2" "mod/changelog.txt" | tail -1)
version=$1
message=$2

if [[ "$line" != *"$version"* ]]; then
    echo "Invalid version in ``changelog.txt``"
    exit 1
fi
version="v$version"

if [ $# -eq 1 ]; then
    git commit -am "Bumped version \`$version\`"
elif [ $# -eq 2 ]; then
    git commit -am "Bumped version \`$version\`\n$message"
else
    echo "Exactly 1 or 2 argument must be provided"
    exit false
fi

git tag "$version"
git push
git push --tags
