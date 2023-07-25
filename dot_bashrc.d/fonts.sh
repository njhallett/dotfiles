update_fonts() {
    font_dir="${XDG_DATA_HOME}/fonts"
    font="CascadiaCode.tar.xz"

    mkdir -p "$font_dir"
    curl -s -L "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}" -o "/tmp/${font}"
    tar xf "/tmp/${font}" -C "${font_dir}"
    rm "/tmp/${font}"
    fc-cache
}
