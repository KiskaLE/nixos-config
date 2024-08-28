{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "24.05"; # Please read the comment before changing.

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
    bashrcExtra = ''eval "$(direnv hook bash)"'';
    shellAliases = {
      ll = "ls -l"; ".." = "cd .."; 
      fr = "sh /home/nixos/nixos/scripts/rebuild.sh";
      cl = "clear";
      };
  };

  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${pkgs.oh-my-posh}/share/oh-my-posh/themes/hul10.omp.json"));
  };

  programs.kitty = {
    enable = true;
    theme = "Hardcore";
  };

  programs.rofi = {
    enable = true;
    location = "center";
    extraConfig = {
      modi = "drun,filebrowser,run";
      show-icons = true;
      icon-theme = "Papirus";
      location = 0;
      drun-display-format = "{icon} {name}";
      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " File";
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

  gtk.iconTheme = ''Bibata-Modern-Ice'';

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = [ "network" "pulseaudio" "custom/quit" ];

        "clock" = {
          format = "{:%a %d.%m %H:%M}";
        };

        "hyprland/workspaces" = {
          format = "{name}";
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
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = " ";
          format-icons = {
              headphone = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = [" " " "];
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
          format = "󰿅";
          on-click = "wlogout";
        };

      };
    };
    style = 
      ''
        * {
          font-size: 13px;
          font-family: "Terminus (TTF)";
        }

        #workspaces {
          margin: 3px 3px;
          padding: 0px 5px;
          background: #121212;
          border-radius: 10px;
        }

        #workspaces button {
          padding: 2px;
        }

        #workspaces button.active {
          color: #F00;
        }
      

        window#waybar {
          background: rgba(0,0,0,0);
        }

        #custom-quit {
          margin: 3px 3px 3px 0px;
          padding: 5px 12px 5px 10px;
          border-top-right-radius: 10px;
          border-bottom-right-radius: 10px;
          border-right: 2px solid rgb(145.63, 32.03, 36.82); /* Changed border color */
          border-top: 2px solid rgb(145.63, 32.03, 36.82); /* Changed border color */
          border-bottom: 2px solid rgb(145.63, 32.03, 36.82); /* Changed border color */
          background: rgb(145.63, 32.03, 36.82); /* Kept red background */
          color: #FFF;
        }

        #clock {
          margin: 3px 0px 3px 3px;
          padding: 5px 12px;
          color: #c5c8c6; /* Ensured text color consistency */
          background: #121212; /* Changed background color */
          border-radius: 10px;
        }

        #custom-keyboard {
          background: #121212; /* Changed background color */
          color: #c5c8c6;
          padding: 5px 5px 5px 7px;
          margin: 3px 0px 3px 3px;
          border-top-left-radius: 10px;
          border-bottom-left-radius: 10px;
        }

        #custom-media {
          margin: 3px;
          padding: 5px 7px 5px 7px;
          border-radius: 10px;
          background: #121212; /* Changed background color */
          color: #c5c8c6;
        }

        #pulseaudio {
          margin: 3px 3px 3px 0px;
          padding: 5px 7px 5px 5px;
          background: #121212; /* Changed background color */
          border-top-right-radius: 0px;
          border-bottom-right-radius: 0px;
          color: #c5c8c6;
        }

        #network {
          background: #121212; /* Changed background color */
          color: #c5c8c6;
          margin: 3px 0px 3px 0px;
          padding: 5px 5px 4px 12px;
          border-top-left-radius: 10px;
          border-bottom-left-radius: 10px;
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
      ];

      windowrule = [
        "float, nm-connection-editor|blueman-manager"
        "float, swayimg|Viewnior|pavucontrol"
      ];

      windowrulev2 = [
        "opacity 0.8 0.8, class:^(kitty)$"
        "opacity 0.85 0.85, class:^(Code)$"
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
        "$mod SHIFT,I,togglesplit,"
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
          gaps_out = 8
          border_size = 2
          layout = dwindle
          resize_on_border = true
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
          rounding = 5
          blur {
              enabled = true
              size = 5
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
