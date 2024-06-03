#!/bin/bash

rm -r .config/nvim/
cp -r ~/.config/nvim .config/

git add --all
git commit -m "Updated dotfiles"
git push origin master
