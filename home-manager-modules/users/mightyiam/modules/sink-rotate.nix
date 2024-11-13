{
  self,
  pkgs,
  config,
  lib,
  ...
}:
let
  sink-rotate = self.inputs.sink-rotate.packages.${pkgs.system}.default;
in
lib.mkIf config.gui.enable {
  wayland.windowManager.sway.config.keybindings."--no-repeat Mod4+s" = "exec ${sink-rotate}/bin/sink-rotate";
  home.packages = [ sink-rotate ];
}
