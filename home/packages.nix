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
        ripgrep
        ripgrep-all
        tokei
        watchexec

        # nix
        alejandra
        nixd
        nurl

        # rust
        rustup
        cargo-watch
        cargo-outdated
        cargo-feature

        mob
      ];
      gui = concatLists [
        fontPackages
        [
          anki
          imv
          pavucontrol
          tor-browser-bundle-bin
          transmission-gtk
          vlc
          wl-clipboard
          xdg-utils
        ]
      ];
    }
