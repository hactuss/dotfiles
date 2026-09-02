{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nil
    nixd
    deadnix
    nix-melt
    nix-output-monitor
    nix-du
    nixfmt
    nixfmt-tree
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [clang];
  };
  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];
}
