if ! mount | grep -q " /home/dillen/hidrive "; then
    echo "### Mounting HiDrive"
    mount ~/hidrive/
fi

if nslookup myfiles >/dev/null 2>&1; then
    if ! gio mount --list | grep -q smb://myfiles/dillen; then
        echo "### Mounting home share"
        gio mount smb://myfiles/dillen
    fi

    if ! gio mount --list | grep -q smb://myfiles/releaseeng; then
        echo "### Mounting team share"
        gio mount smb://myfiles/releaseeng
    fi
fi
