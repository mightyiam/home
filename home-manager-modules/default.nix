{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gui.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    location = {
      latitude = lib.mkOption {
        type = lib.types.numbers.between (-90) 90;
        default = 18.746;
      };
      longitude = lib.mkOption {
        type = lib.types.numbers.between (-180) 180;
        default = 99.075;
      };
    };

    style = {
      windowOpacity = lib.mkOption {
        type = lib.types.numbers.between 0 1.0;
        default = 1.0;
      };

      bellDuration = lib.mkOption {
        type = lib.types.numbers.between 0 1000;
        default = 200.0;
      };
    };
  };

  config = {
    home = {
      username = "mightyiam";
      homeDirectory = "/home/${config.home.username}";
      sessionVariables.TZ = "\$(<~/.config/timezone)";
    };
    programs.home-manager.enable = true;
  };

  imports =
    let
      dir = ./.;
    in
    dir
    |> builtins.readDir
    |> lib.attrNames
    |> lib.filter (path: path != "default.nix")
    |> map (path: "${dir}/${path}");
}
