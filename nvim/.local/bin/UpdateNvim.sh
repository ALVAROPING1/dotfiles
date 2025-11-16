#!/bin/bash

cd ~/.local/bin
rm nvim.appimage.bak 2> /dev/null | true
mv nvim.appimage nvim.appimage.bak 2> /dev/null | true
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim.appimage
chmod u+x nvim.appimage
