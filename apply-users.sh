#!/usr/bin/env sh
pushd ~/.dotfiles
home-manager switch -f ./users/mili/home.nix
popd
