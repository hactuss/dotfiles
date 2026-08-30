{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nil
    nixd
    nh
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [clang];
  };
}
