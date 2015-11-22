#!/bin/sh

set -ue

branch="hugo"

binary()
{
    path=`which hugo || echo ""`

    if [ ! -z "$path" ]; then
        echo "$path"
        return
    fi

    if [ "$OS" = "Windows_NT" ]; then
        echo "hugo/windows"
        return
    fi

    echo "hugo/linux"
}

cd "`dirname "$0"`"

if [ ! "`git rev-parse --abbrev-ref HEAD`" = "$branch" ]; then
    echo "Not in branch '$branch'. Aborting."
    exit 1
fi

if ! git status | grep -q "^nothing to commit, working directory clean$"; then
    echo "Repo is not clean. Aborting." 1>&2
    exit 1
fi

if [ ! "`git rev-parse $branch`" = "`git rev-parse origin/$branch`" ]; then
    response=""
    while [ ! "$response" = "y" ] && [ ! "$response" = "n" ]; do
        read -p "Push changes to branch $branch up to origin? [y/n] " response
    done

    if [ "$response" = "y" ]; then
        git push
    else
        echo "Head of branch $branch must be pushed to origin. Aborting." 1>&2
        exit 1
    fi
fi
commit="`git rev-parse $branch`"

if [ ! -d public/.git ]; then
    rm -rf public
    mkdir public
    cp -r .git public/
    (
        cd public
        git checkout master
    )
    [ $? -eq 0 ]
fi

(
    cd public
    git reset
    git clean -xfd .
    git checkout master
    if git show --quiet | grep -q $commit; then
        echo "Already deployed. Aborting." 1>&2
        exit 1
    fi
)
[ $? -eq 0 ]

"`binary`"

(
    cd public
    git add -A .
    git commit -m "Automatically deployed by `basename "$0"` from $commit."
    git push
)
[ $? -eq 0 ]

git fetch origin +master:master
