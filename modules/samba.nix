{ config, pkgs, ... }:
{
  services.samba = {
    enable = true;
    
    syncPasswordsByPam = true;
    # You will still need to set up the user accounts to begin with:
    # $ sudo smbpasswd -a yourusername

    # This adds to the [global] section:
    extraConfig = ''
      browseable = yes
      smb encrypt = required
    '';

    shares = {
      homes = {
        browseable = "no";  # note: each home will be browseable; the "homes" share will not.
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
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
}
