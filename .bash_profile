# Source ~/.profile
if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi

# Start X server
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi

# vim: ft=sh ts=2 sts=2 sw=2 sr et
