#!/usr/bin/env zsh

if ! [ -d "/opt/homebrew/opt/nvm" ]
then
    brew install nvm
fi

if ! (( $+commands[node] ))
then
    nvm install lts
fi