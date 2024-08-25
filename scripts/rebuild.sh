#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash libnotify git
pushd /home/nixos/nixos

# Early return if no changes were detected (thanks @singiamtel!)
if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

echo "NixOS Rebuilding..."

# Shows your changes
git diff -U0 '*.nix'

sudo nixos-rebuild switch --flake /home/nixos/nixos#default
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available