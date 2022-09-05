# vfio setup for windows gaming with single gpu 

{ config, lib, pkgs, ... }:

let cfg = config.modules.services.vfio;
in {
  options.modules.services.vfio.enable = lib.mkEnableOption "samba";
  config = lib.mkIf cfg.enable {
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

    # Place helper files where libvirt can get to them
    environment.etc = {
      "libvirt/hooks/qemu" = {
        source = "/home/${user}/.setup/local/gpu-passthrough/qemu";
        mode = "0755";
      };
      "libvirt/hooks/qemu.d/win10/prepare/begin/start.sh" = {
        source = "/home/${user}/.setup/local/gpu-passthrough/start.sh";
        mode = "0755";
      };
      "libvirt/hooks/qemu.d/win10/release/end/revert.sh" = {
        source = "/home/${user}/.setup/local/gpu-passthrough/revert.sh";
        mode = "0755";
      };
      "libvirt/qemu.conf" = {
        source = "/home/${user}/.setup/local/gpu-passthrough/qemu.conf";
        mode = "0755";
      };
      "libvirt/libvirtd.conf" = {
        source = "/home/${user}/.setup/local/gpu-passthrough/libvirtd.conf";
        mode = "0755";
      };
      "libvirt/patch.rom" = {
        source = "/home/${user}/.setup/local/gpu-passthrough/patch.rom";
        mode = "0755";
      };
    };
    # Enable xrdp
    #services.xrdp.enable = true; # use remote_logout and remote_unlock
    #services.xrdp.defaultWindowManager = "xmonad";
    #systemd.services.pcscd.enable = false;
    #systemd.sockets.pcscd.enable = false;
  };
}
