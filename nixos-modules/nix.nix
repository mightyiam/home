{
  pkgs,
  self,
  ...
}:
let
  package = pkgs.nixVersions.latest;
in
{
  # workaround https://github.com/NixOS/nix/issues/11358
  nix.package = pkgs.stdenv.mkDerivation {
    name = "nix-with-workaround";
    version = package.version;
    runtimeInputs = [ package ];
    unpackPhase = "true";
    nativeBuildInputs = [ pkgs.makeWrapper ];
    buildPhase = ''
      cp -r ${package} $out
      chmod -R +w $out
      wrapProgram $out/bin/nix \
        --set GIT_CONFIG_COUNT 1 \
        --set GIT_CONFIG_KEY_0 safe.bareRepository \
        --set GIT_CONFIG_VALUE_0 all
    '';
    meta.mainProgram = "nix";
  };
  nix.settings.auto-optimise-store = true;
  nix.nixPath = [
    "nixpkgs=${self.inputs.nixpkgs}"
  ];
}