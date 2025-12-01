if ! command -v posh >/dev/null 2>&1 && command -v oh-my-posh >/dev/null 2>&1; then
    alias posh=oh-my-posh
fi

update_posh_themes() {
    cache_dir=$(posh cache path)
    theme_dir="${cache_dir}/themes"

    mkdir -p "$theme_dir"
    curl -s -L https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -o "${cache_dir}/themes.zip"
    unzip -o -q "${cache_dir}/themes.zip" -d "$theme_dir"
    chmod u+rw "${theme_dir}/"*".omp."*
    rm "${cache_dir}/themes.zip"
}

[[ $(tty) != "/dev/tty"* ]] && eval "$(posh init bash --config "$(posh cache path)/themes/gruvbox-basic-dark.omp.json")"
