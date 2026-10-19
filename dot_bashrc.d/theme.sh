_apply_theme() {
    local mode_type="$1"
    local star_palette="$2"
    local vim_colorscheme="$3"
    local airline_theme="$4"
    local z_theme="$5"
    local vim_extra="$6"
    local neomutt_theme="$7"
    local bat_theme="$8"
    local nnn_theme="$9"
    local alac_theme="${10}"
    local niri_ring_color="${11}"

    local icon="☀️"
    local foot_sig="SIGUSR2"
    local foot_mode="light"

    if [ "$mode_type" = "night" ]; then
        icon="🌙"
        foot_sig="SIGUSR1"
        foot_mode="dark"
    fi

    echo "$icon Setting ${mode_type^} Mode"

    # Foot Terminal
    if [ -f ~/.config/foot/foot.ini ]; then
        sed -i "s|^initial-color-theme=.*|initial-color-theme=$foot_mode|" ~/.config/foot/foot.ini
        pkill -"$foot_sig" foot 2>/dev/null
    fi

    # Alacritty Terminal (CachyOS/Niri)
    if [ -d ~/.config/alacritty/themes ] && [ -n "$alac_theme" ]; then
        cp "$HOME/.config/alacritty/themes/$alac_theme.toml" "$HOME/.config/alacritty/theme.toml" 2>/dev/null
    fi

    # Niri Compositor Focus Ring (Live IPC + Config Persistence)
    if [ -n "$niri_ring_color" ]; then
        if command -v niri &>/dev/null; then
            niri msg action set-focus-ring-color "$niri_ring_color" 2>/dev/null
        fi

        if [ -f ~/.config/niri/config.kdl ]; then
            # Replaces 'color "#hex"' within the focus-ring block or inline definition
            sed -i "/focus-ring/,/}/ s|color \".*\"|color \"$niri_ring_color\"|" ~/.config/niri/config.kdl
        fi
    fi

    [ -f ~/.config/starship.toml ] && sed -i "s|^palette =.*|palette = \"$star_palette\"|" ~/.config/starship.toml
    [ -f ~/.config/zellij/config.kdl ] && sed -i "s|^theme .*|theme \"$z_theme\"|" ~/.config/zellij/config.kdl

    cat <<EOF > "$HOME/.config/vim/theme.vim"
set background=$foot_mode
$vim_extra
colorscheme $vim_colorscheme
let g:airline_theme='$airline_theme'
EOF

    [ -f ~/.config/neomutt/neomuttrc ] && sed -i "s|^source [\"']\?.*neomutt/themes/palette/.*|source \"$HOME/.config/neomutt/themes/palette/$neomutt_theme\"|" ~/.config/neomutt/neomuttrc
    [ -f ~/.config/bat/config ] && sed -i "s|^--theme=.*|--theme=\"$bat_theme\"|" ~/.config/bat/config

    if [ -f ~/.bashrc.d/nnn.sh ]; then
        sed -i "s|^export NNN_FCOLORS=.*|export NNN_FCOLORS=\"$nnn_theme\"|" ~/.bashrc.d/nnn.sh
    fi
    export NNN_FCOLORS="$nnn_theme"
}

set_theme_day() {
    local mode=${1:-default}

    case "$mode" in
        "gruvbox")
            _apply_theme "day" \
                "gruvbox_light" \
                "gruvbox-material" \
                "gruvbox_material" \
                "gruvbox-light" \
                "let g:gruvbox_material_better_performance = 1" \
                "Gruvbox Light.rc" \
                "gruvbox-light" \
                "4f8c450200af4cbd09c66a946c" \
                "gruvbox_light" \
                "#af3a03"
            ;;
        *)
            _apply_theme "day" \
                "tokyonight_light" \
                "catppuccin_latte" \
                "catppuccin_latte" \
                "catppuccin-latte" \
                "" \
                "TokyoNight Day.rc" \
                "Catppuccin Latte" \
                "1F8C1202005F2309c66A5B6C" \
                "tokyonight_light" \
                "#3760bf"
            ;;
    esac
}

set_theme_night() {
    local mode=${1:-default}

    case "$mode" in
        "gruvbox")
            local vim_extra=$'let g:gruvbox_material_background = \'hard\'\nlet g:gruvbox_material_better_performance = 1'
            _apply_theme "night" \
                "gruvbox_dark" \
                "gruvbox-material" \
                "base16_gruvbox_dark_hard" \
                "gruvbox-dark" \
                "$vim_extra" \
                "Gruvbox Dark.rc" \
                "gruvbox-dark" \
                "3cba272e00d668cc24c6d6b166" \
                "gruvbox_dark" \
                "#fe8019"
            ;;
        *)
            _apply_theme "night" \
                "nord" \
                "nord" \
                "nord" \
                "nord" \
                "" \
                "Nord.rc" \
                "Nord" \
                "0B0B04060006060009060B06" \
                "nord" \
                "#88c0d0"
            ;;
    esac
}

alias day='set_theme_day'
alias night='set_theme_night'
