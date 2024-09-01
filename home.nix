{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  xsession.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.git = {
    enable = true;
    userName = "KiskaLE";
    userEmail = "vojtakylar@seznam.cz";
  };

  programs.direnv = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';
    shellAliases = {
      ll = "ls -l"; ".." = "cd .."; 
      fr = "sh /home/nixos/nixos/scripts/rebuild.sh";
      cl = "clear";
      };
  };

  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${pkgs.oh-my-posh}/share/oh-my-posh/themes/rudolfs-dark.omp.json"));
  };

  programs.kitty = {
    enable = true;
    # theme = "Hardcore";
    theme = "Cyberpunk Neon";
    extraConfig = 
      ''
        window_padding_width 10
        term xterm-256color
      '';
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,filebrowser,run";
      show-icons = true;
      location = 0;
      drun-display-format = "{icon} {name}";
      window-format = "{w} · {c} · {t}";
      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " File";
      display-window = "WINDOW";
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        /*****----- Global Properties -----*****/
        "*" = {
            bg = mkLiteral "#09151d";
            bg-alt = mkLiteral "#252525";
            foreground = mkLiteral "#FFFFFF";
            selected = mkLiteral "#24739e";
            active = mkLiteral "#24739e";
            text-selected = mkLiteral "#d1d5db";
            text = mkLiteral "#000000";
            text-color = mkLiteral "#FFFFFF";
            border-color = mkLiteral "#09151d";
            urgent = mkLiteral "#707070";
          };
          "window" = {
            width = mkLiteral "50%";
            transparency = "real";
            orientation = mkLiteral "vertical";
            cursor = mkLiteral "default";
            spacing = mkLiteral "0px";
            border = mkLiteral "2px";
            border-color = "@border-color";
            border-radius = mkLiteral "20px";
            background-color = mkLiteral "@bg";
          };
          "mainbox" = {
            padding = mkLiteral "15px";
            enabled = true;
            orientation = mkLiteral "vertical";
            children = map mkLiteral [
              "inputbar"
              "listbox"
            ];
            background-color = mkLiteral "transparent";
          };
          "inputbar" = {
            enabled = true;
            padding = mkLiteral "10px 10px 100px 10px";
            margin = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            border-radius = "5px";
            orientation = mkLiteral "horizontal";
            children = map mkLiteral [
              "entry"
              "dummy"
              "mode-switcher"
            ];
          };
          "entry" = {
            enabled = true;
            expand = false;
            width = mkLiteral "20%";
            padding = mkLiteral "10px";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@text-selected";
            cursor = mkLiteral "text";
            placeholder = "Search ";
            placeholder-color = mkLiteral "inherit";
          };
          "listbox" = {
            spacing = mkLiteral "10px";
            padding = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            orientation = mkLiteral "vertical";
            children = map mkLiteral [
              "message"
              "listview"
            ];
          };
          "listview" = {
            enabled = true;
            columns = 2;
            lines = 6;
            cycle = true;
            dynamic = true;
            scrollbar = false;
            layout = mkLiteral "vertical";
            reverse = false;
            fixed-height = false;
            fixed-columns = true;
            spacing = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            border = mkLiteral "0px";
          };
          "dummy" = {
            expand = true;
            background-color = mkLiteral "transparent";
          };
          "mode-switcher" = {
            enabled = true;
            spacing = mkLiteral "10px";
            background-color = mkLiteral "transparent";
          };
          "button" = {
            width = mkLiteral "5%";
            padding = mkLiteral "12px";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "@text-selected";
            text-color = mkLiteral "@text";
            cursor = mkLiteral "pointer";
          };
          "button selected" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@text-selected";
          };
          "scrollbar" = {
            width = mkLiteral "4px";
            border = 0;
            handle-color = mkLiteral "@border-color";
            handle-width = mkLiteral "8px";
            padding = 0;
          };
          "element" = {
            enabled = true;
            spacing = mkLiteral "10px";
            padding = mkLiteral "10px";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "transparent";
            cursor = mkLiteral "pointer";
          };
          "element normal.normal" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          "element normal.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@foreground";
          };
          "element normal.active" = {
            background-color = mkLiteral "@active";
            text-color = mkLiteral "@foreground";
          };
          "element selected.normal" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@text-selected";
          };
          "element selected.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-selected";
          };
          "element selected.active" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-selected";
          };
          "element alternate.normal" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
          };
          "element alternate.urgent" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
          };
          "element alternate.active" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
          };
          "element-icon" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            size = mkLiteral "36px";
            cursor = mkLiteral "inherit";
          };
          "element-text" = {
            background-color = mkLiteral "transparent";
            font = "JetBrainsMono Nerd Font Mono 12";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "message" = {
            background-color = mkLiteral "transparent";
            border = mkLiteral "0px";
          };
          "textbox" = {
            padding = mkLiteral "12px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "@bg-alt";
            text-color = mkLiteral "@bg";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "error-message" = {
            padding = mkLiteral "12px";
            border-radius = mkLiteral "20px";
            background-color = mkLiteral "@bg-alt";
            text-color = mkLiteral "@bg";
          };
      };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
      };
      background = {
        blur_passes = 2;
        blur_size = 7;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
      input-field =
          {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(CFE6F4)";
          inner_color = "rgb(657DC2)";
          outer_color = "rgb(0D0E15)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        };
    };
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        "label" = "reboot";
        "action" = "sleep 1; systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "logout";
        "action" = "sleep 1; hyprctl dispatch exit";
        "text" = "Exit";
        "keybind" = "e";
      }
      {
        "label" = "suspend";
        "action" = "sleep 1; systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "lock";
        "action" = "sleep 1; hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "sleep 1; systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
    ];
  };

  gtk.iconTheme = ''Bibata-Modern-Ice'';

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "7";
        reload_style_on_change = true;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = [ "tray" "cpu" "memory" "pulseaudio" "custom/quit" ];

        "clock" = {
          format = "{:%H:%M}";
          on-click = "gnome-calendar";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          separate-outputs = true;
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "custom/sound" = {
          restart-interval = 1;
          format = " 󰓃 {}% ";
          exec = "pamixer --get-volume";
          exec-on-event = true;
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          on-click = "pavucontrol";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = " ";
          format-icons = {
              headphone = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = [" " "  "];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
        };

        "network" = {
          format-disconnected = "󰲜";
          format-ethernet = "󰲝";
          on-click = "nm-connection-editor";
        };

        "custom/quit" = {
          format = "";
          on-click = "wlogout";
        };

        "memory" = {
          format = "   {percentage}%";
          interval = 30;
          tooltip = true;
          tooltip-format = "{used:0.1f}G/{total:0.1f}G";
        };

        "cpu" = {
          format = "  {usage}%";
          interval = 10;
        };

        "tray" = {
          icon-size = 21;
          spacing = 5;
        };

      };
    };
    style = 
      ''
        @define-color bg-color rgba(9,21,29, 0.40);

        * {
          font-size: 13px;
          font-family: "Terminus (TTF)";
        }

        window#waybar {
          background: @bg-color;
          border-radius: 2px;
        }

        #workspaces {
          padding: 0px 5px;
          border-radius: 2px;
        }

        #workspaces button {
          padding: 0px 5px;
        }

        #tray menu {
          padding: 2px;
          border: unset;
        }

        #workspaces button {
          padding: 2px;
        }

        #workspaces button.active {
          color: #F00;
        }

        #memory {
          padding: 5px 12px 5px 5px;
          border-top-right-radius: 2px;
          border-bottom-right-radius: 2px;
        }

        #cpu {
          padding: 5px 5px 5px 12px;
          border-top-left-radius: 2px;
          border-bottom-left-radius: 2px;
        }

        #custom-quit {
          padding: 5px 12px 5px 8px;
          color: #FFF;
        }

        #clock {
          padding: 5px 12px;
          color: #c5c8c6; /* Ensured text color consistency */
          border-radius: 2px;
        }

        #custom-media {
          padding: 5px;
          border-radius: 2px;
          color: #c5c8c6;
        }

        #pulseaudio {
          padding: 5px;
          border-top-right-radius: 0px;
          border-bottom-right-radius: 0px;
          color: #c5c8c6;
        }

        #network {
          color: #c5c8c6;
          padding: 5px 5px 4px 12px;
          border-top-left-radius: 2px;
          border-bottom-left-radius: 2px;
        }
      '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      
      input = {
            kb_layout = "cz";
            follow_mouse = 1;
            sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
            accel_profile = "flat";
      };

      monitor = [
        "DP-1, 2560x1080@200, 1080x0, 1"
        "DP-3, 1920x1080@144, 0x-480, 1, transform, 3"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        "XCURSOR_SIZE, 22"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "killall -q swww;sleep .5 && swww init"
        "killall -q waybar;sleep .5 && waybar"
        "swww restore"
        "nm-applet --indicator"
        "hyprctl setcursor Bibata-Modern-Ice 22"
        "thunderbird"
        "whatsapp-for-linux"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "systemctl --user start plasma-polkit-agent"
      ];

      windowrule = [
        "float, nm-connection-editor|blueman-manager"
        "float, swayimg|Viewnior|pavucontrol"
        "workspace 5, ^(.*thunderbird.*)$"
        "workspace 5, ^(.*whatsapp.*)$"
      ];

      windowrulev2 = [
        "opacity 0.8 0.8, class:^(kitty)$"
        "opacity 0.9 0.9, class:^(code-url-handler)$"
        "opacity 0.95 0.95, class:^(google-chrome)$"
        "opacity 0.9 0.9, class:^(whatsapp-for-linux)$"
        "opacity 0.9 0.9, class:^(thunderbird)$"
        "opacity 0.9 0.7, class:^(org.gnome.Calendar)$"
        "float, class:^(org.gnome.Calendar)$"
      ];

      "$mod" = "SUPER";

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod,l,exec,hyprlock"
        "$mod,s,exec,[floating] rofi -show drun"
        "$mod,c,exec,code"
        "$mod,b,exec,nemo"
        "$mod,Return,exec,kitty"
        "$mod SHIFT,W,exec,web-search"
        "$mod ALT,W,exec,wallsetter"
        "$mod SHIFT,N,exec,swaync-client -rs"
        "$mod,W,exec,google-chrome-stable"
        "$mod,E,exec,emopicker9000"
        "$mod SHIFT,S,exec,screenshootin"
        "$mod,Q,killactive,"
        "$mod SHIFT,i,togglesplit,"
        "$mod,F,fullscreen,"
        "$mod SHIFT,F,togglefloating,"
        "$mod SHIFT,C,exit,"
        "$mod SHIFT,left,movewindow,l"
        "$mod SHIFT,right,movewindow,r"
        "$mod SHIFT,up,movewindow,u"
        "$mod SHIFT,down,movewindow,d"
        "$mod SHIFT,h,movewindow,l"
        "$mod SHIFT,l,movewindow,r"
        "$mod SHIFT,k,movewindow,u"
        "$mod SHIFT,j,movewindow,d"
        "$mod,m,exec,wlogout"
        "bind = SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        # Workspaces
        "$mod,code:10,workspace,1"
        "$mod,code:11,workspace,2"
        "$mod,code:12,workspace,3"
        "$mod,code:13,workspace,4"
        "$mod,code:14,workspace,5"
        "$mod,code:15,workspace,6"
        "$mod,code:16,workspace,7"
        "$mod,code:17,workspace,8"
        "$mod,code:18,workspace,9"
        "$mod,code:19,workspace,10"
        "$mod SHIFT,SPACE,movetoworkspace,special"
        "$mod,SPACE,togglespecialworkspace"
        "$mod SHIFT,code:10,movetoworkspace,1"
        "$mod SHIFT,code:11,movetoworkspace,2"
        "$mod SHIFT,code:12,movetoworkspace,3"
        "$mod SHIFT,code:13,movetoworkspace,4"
        "$mod SHIFT,code:14,movetoworkspace,5"
        "$mod SHIFT,code:15,movetoworkspace,6"
        "$mod SHIFT,code:16,movetoworkspace,7"
        "$mod SHIFT,code:17,movetoworkspace,8"
        "$mod SHIFT,code:18,movetoworkspace,9"
        "$mod SHIFT,code:19,movetoworkspace,10"
        "$mod CONTROL,right,workspace,e+1"
        "$mod CONTROL,left,workspace,e-1"
        "$mod,mouse_down,workspace,+1"
        "$mod,mouse_up,workspace,-1"
        "ALT,Tab,cyclenext"
        # audio
        ",code:122,exec,pamixer -d 4"
        ",code:123,exec,pamixer -i 4"
        ",code:172,exec,pamixer -t"
      ];

      binde = [
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

    };
    extraConfig = 
      ''
        general {
          gaps_in = 6
          gaps_out = 7
          border_size = 2
          layout = dwindle
          resize_on_border = true
          col.active_border = rgb(#4ed1f5)
        }

        dwindle {

        }

        misc {
          initial_workspace_tracking = 0
          mouse_move_enables_dpms = true
          key_press_enables_dpms = false
        }

        animations {
          enabled = yes
          bezier = wind, 0.05, 0.9, 0.1, 1
          bezier = winIn, 0.1, 1, 0.1, 1
          bezier = winOut, 0.3, -0.3, 0, 1
          bezier = liner, 1, 1, 1, 1
          animation = windows, 1, 6, wind, slide
          animation = windowsIn, 1, 6, winIn, slide
          animation = windowsOut, 1, 5, winOut, slide
          animation = windowsMove, 1, 5, wind, slide
          animation = border, 1, 1, liner
          animation = fade, 1, 10, default
          animation = workspaces, 1, 5, wind
        }

        decoration {
          rounding = 2
          blur {
              enabled = true
              size = 4
              passes = 3
              new_optimizations = on
              ignore_opacity = off
          }
        }

      '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
