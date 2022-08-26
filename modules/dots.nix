{ config, pkgs, user, ... }:
{
  system.userActivationScripts = {
   stowDots = ''
     if [ $stow -eq 1 ]
     then
       cd "/home/${user}/.setup/local/stow"
       ${pkgs.stow}/bin/stow . -t "/home/${user}" --no-folding
     fi  
   '';
  };
}
