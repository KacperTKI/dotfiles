#!/bin/bash

git fetch
git pull --rebase

cp -r .config/nvim ~/.config/
