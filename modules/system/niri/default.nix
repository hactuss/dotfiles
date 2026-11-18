{pkgs, ...}: {
  programs = {
    niri.enable = true;
  };
  programs.xwayland = {
    enable = true;
    package = pkgs.xwayland-satellite;
  };
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "deadacute";
    };
  };
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
  ];
}
