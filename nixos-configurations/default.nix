{
  lib,
  inputs,
  self,
  util,
  ...
}:
{
  options.flake.nixosConfigurationsSerialized = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.str;
  };

  config =
    util.readModulesDir ./.
    |>

      lib.mapAttrsToList (
        hostName: path: {
          flake =
            let
              nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
                specialArgs = { inherit self; };
                modules = [
                  path
                  { networking = { inherit hostName; }; }
                ];
              };

              system = nixosConfiguration.config.nixpkgs.hostPlatform.system;
            in
            {
              nixosConfigurations.${hostName} = nixosConfiguration;

              checks.${system}."nixosConfigurations/${hostName}" =
                nixosConfiguration.config.system.build.toplevel;

              nixosConfigurationsSerialized.${hostName} =
                nixosConfiguration.config |> (config: lib.removeAttrs config [ "assertions" ]) |> util.toJSONLossy;
            };
        }
      )
    |> lib.mkMerge;
}
