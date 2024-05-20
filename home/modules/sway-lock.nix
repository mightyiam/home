{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    ;

  inherit (config) keyboard;
  lockCommand = pkgs.swaylock + /bin/swaylock;
  swayMsgPath = config.wayland.windowManager.sway.package + /bin/swaymsg;
in
  mkIf config.gui.enable {
    wayland.windowManager.sway.config.keybindings."${keyboard.wm.lock}" = "exec ${lockCommand}";
    programs.swaylock.enable = true;
    programs.swaylock.settings.daemonize = true;
    programs.swaylock.catppuccin.enable = true;
    programs.swaylock.settings.show-keyboard-layout = true;
    programs.swaylock.settings.indicator-caps-lock = true;
    programs.swaylock.settings.indicator-radius = 200;
    services.swayidle.enable = true;
    services.swayidle.timeouts = [
      {
        timeout = 60 * 10;
        command = lockCommand;
      }
      {
        timeout = 60 * 11;
        command = "${swayMsgPath} \"output * dpms off\"";
        resumeCommand = "${swayMsgPath} \"output * dpms on\"";
      }
    ];
  }
