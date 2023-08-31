update_rbw() {
    exe_dir="${HOME}/.local/bin"
    cmp_dir="${XDG_DATA_HOME}/bash-completion/completions"
    cur_ver="not found"
    lat_ver="not found"

    command -v gh >/dev/null 2>&1 || {
        echo >&2 "I require gh but it's not installed.  Aborting."
        exit 1
    }

    [ -x rbw ] && cur_ver=$(rbw --version | grep -o ' [0-9]\+\.[0-9]\+\.[0-9]\+' | awk '{$1=$1;print}')
    lat_ver=$(gh release list --repo doy/rbw | grep Latest | grep -o '^[0-9]\+\.[0-9]\+\.[0-9]\+')

    echo "Current version: $cur_ver"
    echo "Latest version: $lat_ver"

    [ "$cur_ver" = "$lat_ver" ] && exit

    if gh release download --repo doy/rbw "$lat_ver" --dir /tmp; then
        cd /tmp || exit
        [ -d "$cmp_dir" ] || mkdir -p "$cmp_dir"

        if tar xf rbw_"$lat_ver"_linux_amd64.tar.gz; then
            mv rbw "$exe_dir/" || exit 1
            mv rbw-agent "$exe_dir/" || exit 1
            mv completion/bash "$cmp_dir/rbw" || exit 1
            rm -rf completion rbw*
        fi

    fi
}

