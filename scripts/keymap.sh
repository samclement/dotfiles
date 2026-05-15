#!/bin/bash
if [ -n "${DISPLAY+x}" ]; then
    xmodmap -e "keycode 12 = 3 sterling numbersign"
    xmodmap -e "keycode 94 = grave asciitilde"
    xmodmap -e "keycode 51 = backslash bar"
    xmodmap -e "keycode 11 = 2 at"
    xmodmap -e "keycode 48 = apostrophe quotedbl"
    xmodmap -e "keycode 49 = grave asciitilde"
fi

