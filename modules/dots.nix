{ config, pkgs, ... }:
{
  system.userActivationScripts = {
   stowDots = ''
     ${pkgs.stow}/bin/stow -d "./local/stow" -t "/home/${user}"
   '';
  };
}
