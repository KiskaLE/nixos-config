#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash git
pushd /home/nixos/nixos

echo "NixOS Rebuilding..."

sudo nixos-rebuild switch --flake ~/nixos#default

popd