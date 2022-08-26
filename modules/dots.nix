{ config, pkgs, user, ... }:
{
  system.userActivationScripts = {
   stowDots = ''
     if [ -f "/home/${user}/.stow" ]; then
       cd "/home/${user}/.setup/local/stow"
       ${pkgs.stow}/bin/stow . -t "/home/${user}" --no-folding
     fi  
   '';
  };
}
