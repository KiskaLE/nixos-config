#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash
pushd /home/nixos/nixos
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch --flake /home/nixos/nixos#default
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
git push
popd