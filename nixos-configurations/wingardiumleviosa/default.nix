{
  imports = [
    ../../nixos-modules/types/desktop.nix
    ./mobo.nix
    ./filesystems.nix
    ./state-version.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "wingardiumleviosa";
  networking.hostId = "abf835ae";
}
