set_theme_day() {
    local mode=${1:-default}
    local star_palette vim_colorscheme z_theme airline_theme vim_perf

    case "$mode" in
        "gruvbox")
            star_palette="gruvbox_light"
            vim_colorscheme="gruvbox-material"
            airline_theme="gruvbox_material"
            z_theme="gruvbox-light"
            vim_perf="let g:gruvbox_material_better_performance = 1"
            neomutt_theme="Gruvbox\ Light.rc"
            bat_theme="gruvbox-light"
            nnn_theme="4f8c450200af4cbd09c66a946c" # gruvbox-light
            ;;
        *)
            star_palette="tokyonight_light"
            vim_colorscheme="catppuccin_latte"
            airline_theme="catppuccin_latte"
            z_theme="catppuccin-latte"
            vim_perf=""
            neomutt_theme="TokyoNight\ Day.rc"
            bat_theme="Catppuccin Latte"
            nnn_theme="1F8C1202005F2309c66A5B6C" # tokyonight-light
            ;;
    esac

    echo "☀️ Setting Day Mode: ${mode^^}"

    # Foot
    sed -i "s|^initial-color-theme=.*|initial-color-theme=light|" ~/.config/foot/foot.ini
    pkill -SIGUSR2 foot

    # Starship
    sed -i "s|^palette =.*|palette = \"$star_palette\"|" ~/.config/starship.toml

    # Zellij
    sed -i "s/^theme .*/theme \"$z_theme\"/" ~/.config/zellij/config.kdl

    # Vim Theme File
    cat <<EOF > "$HOME/.config/vim/theme.vim"
set background=light
$vim_perf
colorscheme $vim_colorscheme
let g:airline_theme='$airline_theme'
EOF

    # Neomutt
    sed -i "s|^source ~/.config/neomutt/themes/palette/.*|source ~/.config/neomutt/themes/palette/$(printf %q "$neomutt_theme")|" ~/.config/neomutt/neomuttrc

    # bat
    sed -i "s/^--theme=.*/--theme=\"$bat_theme\"/" ~/.config/bat/config

    # nnn
    sed -i "s/^export NNN_FCOLORS=.*/export NNN_FCOLORS=\"$nnn_theme\"/" ~/.bashrc.d/nnn.sh
    export NNN_FCOLORS="$nnn_theme"
}

set_theme_night() {
    local mode=${1:-default}
    local star_palette vim_colorscheme z_theme airline_theme vim_extra

    case "$mode" in
        "gruvbox")
            star_palette="gruvbox_dark"
            vim_colorscheme="gruvbox-material"
            airline_theme="base16_gruvbox_dark_hard"
            z_theme="gruvbox-dark"
            vim_extra="let g:gruvbox_material_background = 'hard'\nlet g:gruvbox_material_better_performance = 1"
            neomutt_theme="Gruvbox\ Dark.rc"
            bat_theme="gruvbox-dark"
            nnn_theme="3cba272e00d668cc24c6d6b166" # gruvbox-dark
            ;;
        *)
            star_palette="nord"
            vim_colorscheme="nord"
            airline_theme="nord"
            z_theme="nord"
            vim_extra=""
            neomutt_theme="Nord.rc"
            bat_theme="Nord"
            nnn_theme="0B0B04060006060009060B06" # nord
            ;;
    esac

    echo "🌙 Setting Night Mode: ${mode^^}"

    # Foot
    sed -i "s|^initial-color-theme=.*|initial-color-theme=dark|" ~/.config/foot/foot.ini
    pkill -SIGUSR1 foot

    # Starship
    sed -i "s|^palette =.*|palette = \"$star_palette\"|" ~/.config/starship.toml

    # Zellij
    sed -i "s/^theme .*/theme \"$z_theme\"/" ~/.config/zellij/config.kdl

    # Vim Theme File
    cat <<EOF > "$HOME/.config/vim/theme.vim"
set background=dark
$(echo -e "$vim_extra")
colorscheme $vim_colorscheme
let g:airline_theme='$airline_theme'
EOF

    # Neomutt
    sed -i "s|^source ~/.config/neomutt/themes/palette/.*|source ~/.config/neomutt/themes/palette/$(printf %q "$neomutt_theme")|" ~/.config/neomutt/neomuttrc

    # bat
    sed -i "s/^--theme=.*/--theme=\"$bat_theme\"/" ~/.config/bat/config

    # nnn
    sed -i "s/^export NNN_FCOLORS=.*/export NNN_FCOLORS=\"$nnn_theme\"/" ~/.bashrc.d/nnn.sh
    export NNN_FCOLORS="$nnn_theme"
}

alias day='set_theme_day'
alias night='set_theme_night'
