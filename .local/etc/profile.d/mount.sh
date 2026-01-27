if ! mount | grep -q " /home/dillen/hidrive "; then
    echo "### Mounting HiDrive"
    mount ~/hidrive/
fi
