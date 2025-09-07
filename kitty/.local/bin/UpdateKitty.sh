#!/bin/bash

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    dest=~/.local/opt launch=n
ln -sf ~/.local/opt/kitty.app/bin/kitty ~/.local/opt/kitty.app/bin/kitten ~/.local/bin/
#cp ~/.local/opt/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
