#!/bin/bash

cd ~/.local/bin
rm nvim.appimage.bak
mv nvim.appimage nvim.appimage.bak
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim.appimage
chmod u+x nvim.appimage
