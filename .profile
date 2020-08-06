# ~/.profile: executed by the command interpreter for login shells.

# Environment Variables
EDITOR=vim
VISUAL=$EDITOR
export EDITOR VISUAL
export LESS='--mouse --SILENT --status-column --LONG-PROMPT --HILITE-UNREAD --tabs=4 --window=-4'
export RANGER_LOAD_DEFAULT_RC=FALSE

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
