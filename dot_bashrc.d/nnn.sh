export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview;z:autojump'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PISTOL=1

BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

if [ -x ~/.local/bin/nnn-nerd-static ]; then
    alias n=nnn-nerd-static
else
    alias n=nnn
fi
