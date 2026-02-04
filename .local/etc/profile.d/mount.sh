if ! mount | grep -q " /home/${USER}/hidrive "; then
    echo "### Mounting HiDrive"
    mount ~/hidrive/
fi
