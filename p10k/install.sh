#!/usr/bin/env zsh

if ! [ -d $HOME/powerlevel10k ]
then
    echo "installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
fi