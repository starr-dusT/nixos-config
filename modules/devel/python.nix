# python with all the venom

{ config, lib, pkgs, user, ... }:

let cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs.enable = lib.mkEnableOption "emacs";
  config = lib.mkIf cfg.enable {

    # Install packages
    environment.systemPackages = with pkgs; [ emacs ];



  };
}