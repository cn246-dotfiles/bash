# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Use a vi-style command line editing interface
set -o vi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# "**" used in a pathname expansion context will match all
# files and zero or more directories and subdirectories.
shopt -s globstar

# append to the history file, don't overwrite it
shopt -s histappend

# Set secure umask
umask 027

# Configure gpg
GPG_TTY=$(tty)
export GPG_TTY

# Disable <C-s> functionality for vim.surround
stty stop ""

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if [ -r "$HOME/.dircolors" ]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi

  if [ -f /usr/local/bin/aws_completer ]; then
    complete -C '/usr/local/bin/aws_completer' aws
  fi

  #if [ -f "$HOME/.hosts" ]; then
  #  complete -A hostname -o default curl dig host nc netcat ping telnet wget
  #fi
fi

# load extra files - aliases, functions, etc.
if [ -d "$HOME/.bashrc.d" ]; then
  for file in "$HOME"/.bashrc.d/*; do
    if [ -r "${file}" ]; then
      . "${file}"
    fi
  done
  unset file
fi

# Add ssh keys to agent
if [ -x "$HOME/.local/bin/loadkeys" ]; then
  if grep -qR "PRIVATE KEY" "$HOME/.ssh/"; then
    "$HOME/.local/bin/loadkeys"
  fi
fi

# vim: ft=sh ts=2 sts=2 sw=2 sr et
