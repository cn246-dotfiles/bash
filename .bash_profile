#
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Start X
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
