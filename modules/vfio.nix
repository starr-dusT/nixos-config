{ config, pkgs, ... }:
{
  # Boot configuration
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" ];
  boot.kernelModules = [ "kvm-amd" "vfio-pci" ];

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [ virt-manager ];

  # Enable libvirtd
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu.ovmf.enable = true;
    qemu.runAsRoot = true;
  };

  # Enable xrdp
  services.xrdp.enable = true; # use remote_logout and remote_unlock
  services.xrdp.defaultWindowManager = "xmonad";
  systemd.services.pcscd.enable = false;
  systemd.sockets.pcscd.enable = false;

  #systemd.services.libvirtd = {
  #  path = let
  #           env = pkgs.buildEnv {
  #             name = "qemu-hook-env";
  #             paths = with pkgs; [
  #               bash
  #               libvirt
  #               kmod
  #               systemd
  #               ripgrep
  #               sd
  #             ];
  #           };
  #         in
  #         [ env ];
  #};
}
