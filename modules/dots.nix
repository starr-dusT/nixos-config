{ config, pkgs, user, ... }:
{
  system.userActivationScripts = {
   stowDots = ''
     ${pkgs.stow}/bin/stow -d "/home/${user}/.setup/local/stow" -t "/home/${user}"
   '';
  };
}
