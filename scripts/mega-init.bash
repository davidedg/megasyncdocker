#!/bin/sh
if ! test -r /usr/bin/mega-backup; then
    if ! test -r /tmp/megacmd.deb; then
    if ! command -v wget >/dev/null; then
        apt update && apt install -y wget
    fi
    wget -O /tmp/megacmd.deb https://mega.nz/linux/repo/Debian_13/amd64/megacmd-Debian_13_amd64.deb
    fi
    apt update && apt install -y wget /tmp/megacmd.deb
fi