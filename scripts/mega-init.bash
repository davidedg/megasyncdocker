#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

if ! test -r /usr/bin/mega-backup; then
    if ! test -r /tmp/megacmd.deb; then
        if ! command -v wget >/dev/null; then
            apt-get update && apt-get install -y wget
        fi
        wget -O /tmp/megacmd.deb https://mega.nz/linux/repo/Debian_13/amd64/megacmd-Debian_13_amd64.deb
    fi
    apt-get update && apt-get install -y wget /tmp/megacmd.deb
fi