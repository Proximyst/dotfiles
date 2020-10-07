#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d/ ]; then
	for f in /etc/X11/xinit/xinitrc.d/*
	do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

export XCURSOR_PATH=$HOME/.icons/themes

cd ~
exec dbus-launch --sh-syntax --exit-with-session bspwm
