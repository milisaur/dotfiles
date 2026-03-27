#!/usr/bin/env sh
pushd ~/.dotfiles
home-manager switch -f ./home/mili/home.nix
popd
