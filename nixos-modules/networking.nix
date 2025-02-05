{ pkgs, ... }:
{
  facter.detected.dhcp.enable = false;

  networking = {
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };
    networkmanager.wifi.backend = "iwd";
  };
  environment.systemPackages = [ pkgs.impala ];
}
