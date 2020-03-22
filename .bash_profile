#
# ~/.bash_profile
#

echo "bash_profile was used: " $(date +%T) >> startup_sequence

# Start X
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
