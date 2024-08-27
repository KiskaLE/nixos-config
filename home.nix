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
    };
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

      exec-once = [
        "thunderbird"
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
        "$mod,b,exec,dolphin"
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
        "$mod,m,exec,hyprctl dispatch exit"
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
        "$mod,mouse_down,workspace, e+1"
        "$mod,mouse_up,workspace, e-1"
        "ALT,Tab,cyclenext"
        "ALT,Tab,cyclenext"
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
