# Configure PATH
addToPATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

if [ -d "/opt/bin" ]; then
  addToPATH "/opt/bin"
fi

if [ -d "$HOME/bin" ]; then
    addToPATH "$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ]; then
  addToPATH "$HOME/.local/bin"
fi

# Check if application exists
isInstalled() {
  command -v "${1}" >/dev/null
}

# Configure terminal
if isInstalled urxvt && [ -d "$XDG_RUNTIME_DIR/urxvt" ]; then
  urxvtsocket="$XDG_RUNTIME_DIR/urxvt/urxvtd.socket"
  export RXVT_SOCKET="${urxvtsocket}"
fi

# Confiure editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR

# Configure history
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %H:%M: "


# Set repeatable socket location for screen sessions
os="$(uname -s)"
case "${os}" in
  Linux*)
    socketpath="/run/user/$(id -u)/ssh/ssh-agent.socket"
    if [ -S "$socketpath" ]; then
      export SSH_AUTH_SOCK="$socketpath"
    elif [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
      ln -sf "$SSH_AUTH_SOCK" "$socketpath";
      export SSH_AUTH_SOCK="$socketpath"
    fi
  ;;
esac

# Do not attempt to use askpass program; only use terminal
if ! isInstalled ssh-askpass; then
  export SSH_ASKPASS_REQUIRE=never
fi

# Configure less
if isInstalled less; then
  # Enable mouse if less version is 551 or greater.
  less_version="$(less --version | grep -oP '(^less \d{3} )' | cut -d' ' -f2)"

  if [ "$less_version" -ge 551 ]; then
    export LESS='--mouse -F -i -R -Q -J -M -W -X -x4 -z-4'
  else
    export LESS='-F -i -R -Q -J -M -W -X -x4 -z-4'
  fi

  if isInstalled lessfile > /dev/null 2>&1; then
    eval "$(lessfile)"
  else
    export LESSOPEN="| ~/.lessfilter %s"
  fi
fi

# Configure ranger
if isInstalled ranger; then
  export RANGER_LOAD_DEFAULT_RC=FALSE
fi

# Load .bashrc
if [ -r "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# vim: ft=sh ts=2 sts=2 sw=2 sr et
