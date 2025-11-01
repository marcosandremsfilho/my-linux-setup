#!/bin/bash

echo "Installing NeoVim"
# Default path to install NVIM
NVIM_PATH="/opt/nvim-linux-x86_64/bin"
# bashrc path
BASHRC="$HOME/.bashrc"

# Download the nvim
echo "Fetching the nvim files ..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

# If exist, remove the old nvim installation
echo "Removing old installations"
sudo rm -rf /opt/nvim-linux-x86_64

# Add to the opt directory
echo "Adding the archives to the opt directory"
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# Verify if the path already exist on basrc
if ! grep -Fxq "export PATH=\"\$PATH:$NVIM_PATH\"" "$BASHRC"; then
    echo "Adding Neovim PATH in $BASHRC"
    echo "" >> "$BASHRC" # Add a blank line in the file
    echo "# Neovim path" >> "$BASHRC"
    echo "export PATH=\"\$PATH:$NVIM_PATH\"" >> "$BASHRC"
else
    echo "Already on $BASHRC"
fi

export PATH="$PATH:$NVIM_PATH"

echo "Removing fetched files ..."
rm nvim-linux-x86_64.tar.gz
