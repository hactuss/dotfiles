{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.anki
    pkgs.anki-sync-server
  ];
}
