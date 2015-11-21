#!/bin/sh

set -ue

if [ $# -lt 1 ]; then
	echo "Provide a title" 1>&2
	exit 1
fi

normalize()
{
	sed 's,[^a-zA-Z0-9 ],,g;s, ,-,g;s,-\+,-,g' | tr "[:upper:]" "[:lower:]"
}

binary()
{
	if [ "$OS" = "Windows_NT" ]; then
		echo "hugo/windows.exe"
		return
	fi

	echo "ERROR: Unknown OS" 1>&2
	exit 1
}

title="`echo "$1" | normalize`"
title="$1"
binary=`binary`

$binary new "post/`date +%Y-%m-%d`-$title".md
