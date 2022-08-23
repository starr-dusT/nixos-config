{ config, pkgs, user, ... }:

{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.stateVersion = "22.05";

  programs.home-manager.enable = true;


  home.packages = with pkgs; [
    emacs
    brave
    rofi
    stow
    alacritty
    gamemode
    lutris
    nitrogen
    keepassxc
    pcmanfm
    discord
    inkscape
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
    libreoffice-fresh
  ];

  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark";
    };
  };

  xdg.configFile = {
    "crafted-emacs" = {
      recursive = true;
      source = ./local/crafted-emacs;
    };
  };

}
