# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, user, lib, ... }:
{
  nix = {
    # Flakes!
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";

    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Use zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kestrel"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.lightdm.enable = true;
    desktopManager.xterm.enable = false;

    # Use nvidia drivers
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option "metamodes" "HDMI-0: 2560x1440_144 +2560+0, DP-4: 2560x1440_144 +0+0"
    '';

    # Use the xmonad wm
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  hardware.opengl.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Add non-free packages
  nixpkgs.config.allowUnfree = true;


  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  services = {
    # USB automount
    gvfs.enable = true;

    # File sync
    syncthing = {
      enable = true;
      user = "tstarr";
      dataDir = "/home/tstarr/sync";
      configDir = "/home/tstarr/.config/syncthing";
    };
  };

  programs.steam = {
    enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    haskellPackages.xmobar
    killall
    pciutils
    syncthing
    nnn
    xidlehook
    pamixer
    vifm
    play-with-mpv
    mpv
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "22.05"; # Did you read the comment?


  programs.bash.shellAliases = {
    # Nix rebuild and switch
    nr = "cd ~/.setup && sudo nixos-rebuild switch --flake .# && cd -";
  };

  imports = [ ../../modules ];

  modules = {
    stow.enable = true;
    services = {
      samba.enable = true;
      vfio.enable = true;
    };
    editors = {
      emacs.enable = true;
    };
  };
}
