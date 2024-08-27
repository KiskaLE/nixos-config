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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      input = {
            kb_layout = "cz";
            follow_mouse = 1;
            sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
            accel_profile = "flat";
      };

      "$mod" = "SUPER";

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod,s,exec,[floating] rofi -show drun"
        "$mod,Return,exec,kitty"
        "$mod SHIFT,W,exec,web-search"
        "$mod ALT,W,exec,wallsetter"
        "$mod SHIFT,N,exec,swaync-client -rs"
        "$mod,W,exec,google-chrome-stable"
        "$mod,E,exec,emopicker9000"
        "$mod SHIFT,S,exec,screenshootin"
        "$mod,C,exec,hyprpicker -a"
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
        # Workspaces
        "$mod,1,workspace,1"
        "$mod,2,workspace,2"
        "$mod,3,workspace,3"
        "$mod,3,workspace,3"
        "$mod,4,workspace,4"
        "$mod,5,workspace,5"
        "$mod,6,workspace,6"
        "$mod,7,workspace,7"
        "$mod,8,workspace,8"
        "$mod,9,workspace,9"
        "$mod,0,workspace,10"
        "$mod SHIFT,SPACE,movetoworkspace,special"
        "$mod,SPACE,togglespecialworkspace"
        "$mod SHIFT,1,movetoworkspace,1"
        "$mod SHIFT,2,movetoworkspace,2"
        "$mod SHIFT,3,movetoworkspace,3"
        "$mod SHIFT,4,movetoworkspace,4"
        "$mod SHIFT,5,movetoworkspace,5"
        "$mod SHIFT,6,movetoworkspace,6"
        "$mod SHIFT,7,movetoworkspace,7"
        "$mod SHIFT,8,movetoworkspace,8"
        "$mod SHIFT,9,movetoworkspace,9"
        "$mod SHIFT,0,movetoworkspace,10"
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
