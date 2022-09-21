- edit the user in the flake
- make .stow-on-rebuild file with 1 to stow or 0 to not

TODO:
- break-out configuration.nix items that are standard to file outside hosts
- turn other configurations into relevant modules
  -> services
    -> syncthing 
    -> ... 
  -> desktop
    -> x11.nix
    -> xmonad.nix
    -> gaming.nix
  -> hardware
    -> nvidia
    -> bluetooth
    -> fs (checkout https://github.com/hlissner/dotfiles/blob/7d9f2dfb2f8db850c2be9abd30bdc034e8e8d263/modules/hardware/fs.nix)
