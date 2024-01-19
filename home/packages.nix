with builtins;
  pkgs: let
    fontPackages = (import ./fonts.nix).packages pkgs;
  in
    with pkgs; {
      tui = [
        atool
        bandwhich
        du-dust
        fd
        neofetch
        procs
        psmisc
        ripgrep
        ripgrep-all
        tokei
        usbutils
        watchexec

        # javascript
        vscode-langservers-extracted

        # nix
        alejandra
        nixd
        nurl
        comma

        # lua
        lua-language-server

        # rust
        cargo-watch
        cargo-outdated
        cargo-feature

        # yaml
        yaml-language-server

        mob
      ];
      gui = concatLists [
        fontPackages
        [
          anki
          gh-markdown-preview
          gimp
          imv
          inkscape
          pavucontrol
          qpwgraph
          tor-browser-bundle-bin
          transmission-gtk
          vlc
          wl-clipboard
          wl-color-picker
          xdg-utils
        ]
      ];
    }
