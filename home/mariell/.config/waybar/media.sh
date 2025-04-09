#!/bin/sh
set -eu

if [ "$(playerctl status)" = "Playing" ]; then
	artist="$(playerctl metadata xesam:artist)"
	title="$(playerctl metadata xesam:title)"
	printf '  '
	if [ -n "$artist" ]; then
		printf '%s' "$artist"
	fi
	if [ -n "$artist" ] && [ -n "$title" ]; then
		printf ' - '
	fi
	if [ -n "$title" ]; then
		printf '%s' "$title"
	fi
	printf '\n'
fi
