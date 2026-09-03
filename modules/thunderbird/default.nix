{pkgs, ...}: {
  programs.thunderbird = {
    enable = true;
  };
  services.protonmail-bridge = {
    enable = true;
  };
}
