# ~/.profile: executed by the command interpreter for login shells.

# Environment Variables
EDITOR=vim
VISUAL=$EDITOR
SUDO_EDITOR=$EDITOR
export EDITOR VISUAL SUDO_EDITOR
#export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# Enable mouse if less version is 551 or greater.
less_version="$(less --version | grep -oP '(^less \d{3} )' | cut -d' ' -f2)"

if [ "$less_version" -ge 551 ];
then
  export LESS='--mouse --SILENT --status-column --LONG-PROMPT --HILITE-UNREAD --tabs=4 --window=-4'
else
  export LESS='--SILENT --status-column --LONG-PROMPT --HILITE-UNREAD --tabs=4 --window=-4'
fi

if [ -e /usr/bin/ranger ]; then
  export RANGER_LOAD_DEFAULT_RC=FALSE
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes /opt/bin if it exists
if [ -d "/opt/bin" ]; then
    PATH="/opt/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
