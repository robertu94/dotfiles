#!/bin/bash
if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
	[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
	hsetroot -fill $HOME/Pictures/Backgrounds/$(ls $HOME/Pictures/Backgrounds/ | sort -R | head -n 1)
	urxvt &
	panel &
	exec bspwm
fi
