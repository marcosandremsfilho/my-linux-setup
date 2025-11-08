#!/bin/bash

sudo cp /etc/default/grub /etc/default/grub_bkp

current_path=$(pwd)
cp $current_path/grub/config/config/ /etc/default/
