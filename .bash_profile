#
# ~/.bash_profile
#

# Load .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi

