# ~/.bash_profile
# Source ~/.profile
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

# Start X server
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
