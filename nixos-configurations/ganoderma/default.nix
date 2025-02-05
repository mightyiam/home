{ self, ... }:
{
  imports = with self.modules.nixos; [
    desktop
    self.inputs.nixos-facter-modules.nixosModules.facter
    swap
    ./state-version.nix
  ];

  networking.hostId = "0e8e163d";

  facter.reportPath = ./facter.json;
}
