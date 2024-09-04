{ config, pkgs, inputs, ... }:

{
    home.packages = with pkgs; [
        dconf2nix
        gnome.dconf-editor

        gnomeExtensions.dash-to-dock

    ];


    dconf.settings = {
        "org/gnome/nautilus/icon-view" = {
            default-zoom-level = "small";
        };

        "org/gnome/desktop/peripherals/keyboard" = {
            delay = 500;
            numlock-state = true;
            remember-numlock-state = true;
            repeat = true;
            repeat-interval = 30;
        };

        "org/gnome/desktop/peripherals/keyboard" = {
            accell-profile = "flat";
            speed = -0.11284046692607008;
        };

        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            cursor-size = 24;
            cursor-theme = "bibata-cursors";
            enable-animations = true;
            enable-hot-corners = false;
        };
    };
}