{ config, pkgs, inputs, ... }:

{
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
}