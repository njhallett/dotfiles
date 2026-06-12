export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview;z:autojump'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_FCOLORS="1F8C1202005F2309c66A5B6C"

if [ -x ~/.local/bin/nnn-nerd-static ] && [ ! -x ~/.local/bin/nnn ]; then
    ln -s ~/.local/bin/nnn-nerd-static ~/.local/bin/nnn
fi

if grep -qEi "(Microsoft|Microsoft-Standard-WSL2)" /proc/version 2>/dev/null \
   || [ -n "$SSH_CLIENT" ] \
   || [ -n "$SSH_TTY" ] \
   || [ -z "$DISPLAY" ]; then

    if command -v pistol >/dev/null 2>&1; then
        export NNN_OPENER="pistol"
    else
        export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
    fi

    export NNN_OPTS=c
fi

alias n=nnn
