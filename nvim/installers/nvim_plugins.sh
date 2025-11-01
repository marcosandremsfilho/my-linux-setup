#!/bin/bash

if command -v nvim >/dev/null 2>&1; then
    echo "Installing npm ..."
    sudo apt install npm

    echo "installing ripgrep ..."
    sudo apt install ripgrep # This dependencie is used to enable the live grep from telescope

    echo "installing xclip ..."
    sudo apt install xclip # This dependencie is used to enable the copy and paste from outside the editor

    echo "Fetching the nvim plugins ..."

    cp -r ../config/nvim/ ~/.config/
else
    echo "❌ You must install Neovim first"
fi

