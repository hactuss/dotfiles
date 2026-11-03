{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    noctalia-qs
    noctalia-shell
    quickshell

    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
  ];
}
