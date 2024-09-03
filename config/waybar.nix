{ config, pkgs, inputs, ... }:

{
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
}