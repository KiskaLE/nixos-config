{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports =
    [ # Include the results of the hardware scan.
      # Hyprland
      ./config/hyprlock.nix
      ./config/wlogout.nix
      ./config/rofi.nix
      ./config/waybar.nix
      ./config/hyprland.nix
      # All
    ];

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

  gtk.iconTheme = ''Bibata-Modern-Ice'';

  

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
