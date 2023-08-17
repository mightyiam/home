instance: {config, ...}: let
  id = "bottom";
  font = (import ../../fonts.nix).bars;
in {
  programs.i3status-rust = {
    enable = true;
    bars = {
      "${id}" = {
        theme = (import ../../gruvbox.nix).i3status-rust;
        icons = "awesome5";
        blocks = [
          {
            block = "custom";
            format = "󰪛 ";
            json = true;
            command = ''
            if grep -q 1 /sys/class/leds/input*::capslock/brightness; then
              echo '{ "state": "Warning" }'
            else
              echo '{}'
            fi
            '';
            watch_files = ["/dev/input"];
            interval = "once";
          }
          {block = "cpu";}
          {block = "memory";}
          {block = "disk_space";}
          #{ block = "nvidia_gpu"; }

          #{ block = "docker"; }

          {block = "net";}

          {
            block = "time";
            format = "$icon $timestamp.datetime(f:'%F %a %R')";
          }
          {
            block = "keyboard_layout";
            driver = "sway";
            mappings = {
              "English (US)" = "EN";
              "Hebrew (N/A)" = "HE";
            };
          }
          {block = "sound";}
          {
            block = "sound";
            device_kind = "source";
            format = "$icon";
          }
          {
            block = "battery";
            missing_format = "";
          }
        ];
      };
    };
  };
  wayland.windowManager.sway.config.bars = [
    {
      statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-${id}.toml";
      trayOutput = instance.trayOutput;
      fonts = {
        names = [font.family];
        style = font.style;
        size = font.size;
      };
    }
  ];
}
