{
  imports = [
    ../../nixos-modules/types/desktop.nix
    ./mobo.nix
    ./state-version.nix
    ./gdm.nix
    ./auto-upgrade.nix
    ../../nixos-modules/users/1bowapinya.nix
  ];

  networking.hostId = "abf835ae";
}
