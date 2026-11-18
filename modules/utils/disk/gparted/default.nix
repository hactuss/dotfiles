{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gparted-full
    util-linux
    linux
  ];
}
