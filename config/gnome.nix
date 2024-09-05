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

        "org/gnome/settings-daemon/plugins/power" = {
            sleep-inactive-ac-timeout = 900;
        };

        "org/gnome/shell" = {
            allow-extension-installation = true;
            enabled-extensions = ["dash-to-dock@micxgx.gmail.com"];
        };

        # Extensions
        "org/gnome/shell/extensions/dash-to-dock" = {
            background-color = "rgb(255,255,255)";
            transparency-mode = "FIXED";
            background-opacity = 0.15;
            click-action = "focus-minimize-or-appspread";
            custom-background-color = true;
            custom-theme-shrink = true;
            dash-max-icon-size = 36;
            disable-overview-on-startup = true;
            dock-fixed = true;
            preferred-monitor-by-connector = "DP-1";
            running-indicator-style = "DOTS";
            scroll-action = "cycle-windows";
            show-mounts = false;
        };

        "org/gnome/shell/extensions/user-theme" = {
            #name = "";
        };
    };
}