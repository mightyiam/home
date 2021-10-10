{ pkgs, lib, config, ... }:
  let
    outputs = import ./outputs.nix;
    secrets = (import ./secrets.nix);
  in {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraSessionCommands = ''
        export WLR_DRM_NO_MODIFIERS=1
        export I3RS_GITHUB_TOKEN=${secrets.I3RS_GITHUB_TOKEN}
        export MOZ_ENABLE_WAYLAND=1
      '';
      config = let
        mod-key = "Mod4";
      in {
        output = {
          "${outputs.right}" = {
            res = "1920x1080@144Hz";
          } ;
          "${outputs.left}" = {
            res = "1920x1080@75Hz";
          };
        };
        modifier = mod-key;
        input = {
          "type:keyboard" = {
            xkb_layout = "us,il";
            xkb_options = "grp:lalt_lshift_toggle";
          };
        };
        terminal = "alacritty";
        keybindings =
          let
            step = 5;
            incVol = d: "exec pactl set-sink-volume @DEFAULT_SINK@ ${d}${builtins.toString step}%";
          in lib.mkOptionDefault {
            "${mod-key}+Shift+e" = "exec swaymsg exit";
            "${mod-key}+minus" = incVol "-";
            "${mod-key}+equal" = incVol "+";
          };
        startup = [
          { command = "mako"; }
        ];
      };
      extraConfig = let
        firefoxSharingIndicator = "[app_id=\"firefox\" title=\"Sharing Indicator$\"]";
      in ''
        no_focus ${firefoxSharingIndicator}
        for_window ${firefoxSharingIndicator} \
          floating enable, \
          sticky enable, \
          border none, \
          move position 1800 px 0 px
      '';
    };
    home.packages = [pkgs.pulseaudio];
    programs.mako = {
      enable = true;
      anchor = "top-right";
      defaultTimeout = 3000;
      ignoreTimeout = true;
      output = outputs.left;
    };
  }