#!/bin/bash

PREFIX="$(readlink -f ~)/.local/opt"
KITTY_PATH="$PREFIX/kitty.app"

rm -rf "$KITTY_PATH.bak" 2> /dev/null | true
mv "$KITTY_PATH" "$KITTY_PATH.bak" 2> /dev/null | true

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin dest=$PREFIX launch=n
ln -sf $KITTY_PATH/bin/kitty $KITTY_PATH/bin/kitten ~/.local/bin/
cp $KITTY_PATH/share/applications/kitty.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty desktop file(s)
sed -i "s|Icon=kitty|Icon=$KITTY_PATH/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
