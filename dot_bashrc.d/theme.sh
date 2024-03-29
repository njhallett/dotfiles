if command -v theme.sh > /dev/null; then
    [ -e $XDG_CONFIG_HOME/.theme_history ] && theme.sh "$(theme.sh -l|tail -n1)"

    # Optional

    #Binds C-o to the previously active theme.
    bind -x '"\C-o":"theme.sh $(theme.sh -l|tail -n2|head -n1)"'

    alias th='theme.sh -i'

    # Interactively load a light theme
    alias thl='theme.sh --light -i'

    # Interactively load a dark theme
    alias thd='theme.sh --dark -i'
fi
