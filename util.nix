{ nixpkgs, ... }:
let
  inherit (nixpkgs) lib;

  toJSONLossy =
    maybe:
    let
      result = builtins.tryEval maybe;
      val = if result.success then result.value else "«error»";
    in
    if lib.isDerivation val then
      "«derivation ${val.drvPath}»"
    else if lib.isFunction val then
      "«function»"
    else if lib.isAttrs val then
      if val ? drvPath then
        "«what is this undocumented derivationStrict?»"
      else
        lib.mapAttrs (name: value: toJSONLossy value) val
    else if lib.isList val then
      map toJSONLossy val
    else
      builtins.toJSON val;
in
{
  readModulesDir =
    path:
    builtins.readDir path
    |> lib.filterAttrs (name: _: (!(lib.hasPrefix "_" name)) && (name != "default.nix"))
    |> lib.mapAttrs' (name: type: lib.nameValuePair (lib.removeSuffix ".nix" name) (path + "/${name}"));

  inherit toJSONLossy;
}
