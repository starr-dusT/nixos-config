{ config, pkgs, user, ... }:

{

  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.stateVersion = "22.05";

  programs.home-manager.enable = true;


  home.packages = with pkgs; [
    brave
    rofi
    alacritty
    gamemode
    lutris
    polymc
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


}
