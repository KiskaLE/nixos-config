#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash git
pushd /home/nixos/nixos

# Early return if no changes were detected (thanks @singiamtel!)
if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

echo "NixOS Rebuilding..."

sudo nixos-rebuild switch --flake /home/nixos/nixos#default
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd