{ config, pkgs, inputs, ... }:

{
    home.packages = with pkgs; [
        dconf2nix
        gnome.dconf-editor
        gnome.gnome-tweaks

        # Extensions
        gnomeExtensions.dash-to-dock
        gnomeExtensions.clipboard-indicator

        # Shell themes
        flat-remix-gnome

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
            cursor-size = 22;
            cursor-theme = "Bibata-Modern-Ice";
            enable-animations = true;
            enable-hot-corners = false;
        };

        "org/gnome/settings-daemon/plugins/power" = {
            sleep-inactive-ac-timeout = 900;
        };

        "org/gnome/shell" = {
            allow-extension-installation = true;
            enabled-extensions = [
                "dash-to-dock@micxgx.gmail.com"
                "user-theme@gnome-shell-extensions.gcampax.github.com"
                "clipboard-indicator@tudmotu.com"
            ];
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
            name = "Flat-Remix-Teal-Darkest-fullPanel";
        };

        # Virt manager
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
        };
    };
}