#!/bin/sh

set -ue

usage()
{
    echo
    echo "`basename "$0"` \"some title\""
    echo
    echo "    --tags=tag1,tag2"
    echo "    --category=cat"
    echo
    echo "Existing categories:" "`grep '^categories:' -r content/post/ | normalize`"
    echo "Existing tags:" "`grep '^tags: ' -r content/post/ | normalize`"
}

error()
{
    fmt="$1"
    shift
    printf "ERROR: $fmt\n" "$@" >&2
}

escape()
{
    sed 's,[^a-zA-Z0-9 ],,g;s, ,-,g;s,-\+,-,g' | tr "[:upper:]" "[:lower:]"
}

normalize()
{
    awk -F',' "
    {
        sub(/^.*[:=] */, \"\");
        sub(/^\[/, \"\");
        sub(/\]$/, \"\");
        sub(/^\"/, \"\");
        sub(/\"$/, \"\");
        gsub(/\", *\"/, \"\");
    }

    NF > 0 {
        for (i=1; i<=NF; i++) {
            print \$i;
        }
    }" | tr '[:upper:]' '[:lower:]' | sort -u | tr "\n" "," | sed 's/,$//;s/,/, /g'
}

expand_list()
{
    read comma_separated
    if [ "$comma_separated" = "" ]; then
        echo "[]"
        return
    fi

    echo "[\"$comma_separated\"]" | sed 's/,/", "/g'
}

set_once()
{
    varname=$1
    value=$2

    read -r -d '' check <<EOF || true
        if [ ! -z "\$$varname" ]; then
            error "$varname specified twice: \"%s\", then \"%s\"" "\$$varname" "\$value"
            exit 1
        fi
        $varname="\$value"
EOF

    eval "$check"
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

title=""
tags=""
category=""
while [ $# -gt 0 ]; do
    param=`echo $1 | awk -F= '{print $1}'`
    value=`echo $1 | awk -F= '{print $2}'`
    case $param in
        -h | --help)
            usage
            exit 1
            ;;
        --tags)
            set_once tags "$value"
            ;;
        --category)
            set_once category "$value"
            ;;
        --*)
            error "unknown parameter %s" "$param"
            usage
            exit 1
            ;;
        *)
            set_once title "$param"
            ;;
    esac
    shift
done

title="`echo "$title" | sed 's,",\\\\",g'`"
escaped_title="`echo "$title" | escape`"

if [ -z "$category" ]; then
    category="software development"
fi

date=`date -u +%Y-%m-%d`
datetime=`date -u +%Y-%m-%dT%H:%M:%SZ`

filename="content/post/$date-$escaped_title".md
cat <<EOF > "$filename"
---
title: "$title"
description: ""
date: "$datetime"
categories: ["$category"]
tags: `echo $tags | expand_list`
draft: true
---
EOF

echo "Created: $filename"
