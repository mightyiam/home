{ readModulesDir, ... }:
{
  flake.nixosModules = readModulesDir ./.;
}
