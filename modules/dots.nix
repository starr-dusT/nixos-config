{ config, pkgs, user, ... }:
{
  system.userActivationScripts = {
   stowDots = ''
     if [ -f "/home/${user}/.stow-on-rebuild" ]; then
       if [ $(cat "/home/${user}/.stow-on-rebuild") -eq 1 ]; then
         cd "/home/${user}/.setup/local/stow"
         ${pkgs.stow}/bin/stow . -t "/home/${user}" --no-folding
       fi
     fi
   '';
  };
}
