{ self, ... }:
{
  imports = with self.modules.nixos; [
    ./sshd.nix
    ./mobo.nix
    ./gpu.nix
    ./cpu.nix
    ./docker.nix
    ./state-version.nix
    desktop
    self.inputs.nixos-facter-modules.nixosModules.facter
  ];

  networking.hostId = "6b5dea2a";

  facter.reportPath = ./facter.json;
}
