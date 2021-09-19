# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# remove mpd socket
if [ -f "$HOME/.config/mopidy/socket" ]; then
  rm -f "$HOME/.config/mopidy/socket"
fi
