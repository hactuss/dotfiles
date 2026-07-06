{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    onefetch
    screenfetch
    hyprpaper
    awww
    waypaper
    fuzzel
  ];
}
