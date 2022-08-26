{ config, pkgs, user, ... }:
{
  system.userActivationScripts = {
   stowDots = ''
     cd "/home/${user}/.setup/local/stow"
     ${pkgs.stow}/bin/stow . -t "/home/${user}"
   '';
  };
}
