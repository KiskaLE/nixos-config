{ config, pkgs, inputs, ... }:

{
    packages = with pkgs; [
        gnomeExtensions.dash-to-dock
    ];
}