{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nil
    nixd
    deadnix
    nix-melt
    nix-output-monitor
    nix-du
    nixfmt
    nixfmt-tree
    vulnix
    nixdoc
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      openssl
      zlib
      clang
    ];
  };
  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    RUSTICL_ENABLE = "radeonsi";
    RUST_BACKTRACE = 1;
  };
  nix.settings.auto-optimise-store = true;
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = _pkgs: {
        unstable = import <nixos-unstable> {config = config.nixpkgs.config;};
      };
    };
  };
}
