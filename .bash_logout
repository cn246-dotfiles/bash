# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
  [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# remove mpd socket
if [ -f "$HOME/.config/mopidy/socket" ]; then
  rm -f "$HOME/.config/mopidy/socket"
fi

# vim: set ft=sh ts=2 sts=2 sw=2 sr et
