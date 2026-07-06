{pkgs, ...}: {
  programs.nh = {
    flake = "/home/hactuss/dotfiles";
    clean = {
      enable = true;
      dates = "monthly";
    };
  };
}
