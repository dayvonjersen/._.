#!/bin/bash
git pull

dotfiles=$(mktemp -d)

git clone --recursive . $dotfiles
rm -rf $dotfiles/.git
rm -rf $dotfiles/install.sh

cp -rT $dotfiles $HOME 
