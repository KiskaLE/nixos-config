#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash
sudo nixos-rebuild switch -I nixos-config=/home/nixos/nixos/configuration.nix --flake /home/nixos/nixos#default
