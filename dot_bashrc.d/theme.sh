set_theme_day() {
    local mode=${1:-default}
    local foot_theme star_palette vim_colorscheme z_theme airline_theme vim_perf

    case "$mode" in
        "gruvbox")
            foot_theme="gruvbox-light"
            star_palette="gruvbox_light"
            vim_colorscheme="gruvbox-material"
            airline_theme="gruvbox_material"
            z_theme="gruvbox-light"
            vim_perf="let g:gruvbox_material_better_performance = 1"
            ;;
        *)
            foot_theme="tokyonight-light"
            star_palette="tokyonight_light"
            vim_colorscheme="catppuccin_latte"
            airline_theme="catppuccin_latte"
            z_theme="catppuccin-latte"
            vim_perf=""
            ;;
    esac

    echo "☀️ Setting Day Mode: ${mode^^}"

    # 1. Foot Terminal
    sed -i "s|^include=.*|include=/usr/share/foot/themes/$foot_theme|" ~/.config/foot/foot.ini
    pkill -USR1 ^foot$

    # 2. Starship
    sed -i "s|^palette =.*|palette = \"$star_palette\"|" ~/.config/starship.toml

    # 3. Zellij
    sed -i "s/^theme .*/theme \"$z_theme\"/" ~/.config/zellij/config.kdl

    # 4. Vim Theme File
    cat <<EOF > "$HOME/.config/vim/theme.vim"
set background=light
$vim_perf
colorscheme $vim_colorscheme
let g:airline_theme='$airline_theme'
EOF
}

set_theme_night() {
    local mode=${1:-default}
    local foot_theme star_palette vim_colorscheme z_theme airline_theme vim_extra

    case "$mode" in
        "gruvbox")
            foot_theme="gruvbox-dark"
            star_palette="gruvbox_dark"
            vim_colorscheme="gruvbox-material"
            airline_theme="base16_gruvbox_dark_hard"
            z_theme="gruvbox-dark"
            vim_extra="let g:gruvbox_material_background = 'hard'\nlet g:gruvbox_material_better_performance = 1"
            ;;
        *)
            foot_theme="nord"
            star_palette="nord"
            vim_colorscheme="nord"
            airline_theme="nord"
            z_theme="nord"
            vim_extra=""
            ;;
    esac

    echo "🌙 Setting Night Mode: ${mode^^}"

    # 1. Foot Terminal
    sed -i "s|^include=.*|include=/usr/share/foot/themes/$foot_theme|" ~/.config/foot/foot.ini
    pkill -USR1 ^foot$

    # 2. Starship
    sed -i "s|^palette =.*|palette = \"$star_palette\"|" ~/.config/starship.toml

    # 3. Zellij
    sed -i "s/^theme .*/theme \"$z_theme\"/" ~/.config/zellij/config.kdl

    # 4. Vim Theme File
    cat <<EOF > "$HOME/.config/vim/theme.vim"
set background=dark
$(echo -e "$vim_extra")
colorscheme $vim_colorscheme
let g:airline_theme='$airline_theme'
EOF
}

alias day='set_theme_day'
alias night='set_theme_night'
