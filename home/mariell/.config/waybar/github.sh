#!/bin/sh
set -eu

notifs="0"
page="1"
while true; do
	n="$(gh api \
	  -H "Accept: application/vnd.github+json" \
	  -H "X-GitHub-Api-Version: 2022-11-28" \
	  "/notifications?page=$page" | jq length)"
	if [ "$n" = "0" ]; then
		break
	fi
	notifs=$(($n+$notifs))
	page=$(($page+1))
done

if [ "$notifs" != "0" ]; then
	echo " $notifs"
fi
