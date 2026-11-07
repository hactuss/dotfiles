{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    quickshell
    noctalia

    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
  ];
}
