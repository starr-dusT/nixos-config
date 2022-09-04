# Samba for file sharing

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.samba;
in {
  options.modules.services.samba = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.samba = {
      enable = true;
      # This adds to the [global] section:
      extraConfig = ''
        browseable = yes
        smb encrypt = required
      '';

      shares = {
        homes = {
          browseable = "no";
          "read only" = "no";
          "guest ok" = "no";
        };
      };
    };

    # Curiously, `services.samba` does not automatically open
    # the needed ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 445 139 ];
    networking.firewall.allowedUDPPorts = [ 137 138 ];

    # To make SMB mounting easier on the command line
    environment.systemPackages = with pkgs; [ cifs-utils ];
  };
}
