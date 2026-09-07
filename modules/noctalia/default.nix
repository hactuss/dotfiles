{pkgs, ...}: {
  /*
  programs.noctalia = {
  enable = true;
  recommendedServices.enable = true;
  };
  */
  environment.systemPackages = with pkgs; [
    noctalia-qs
    noctalia-shell
    quickshell

    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
  ];
}
