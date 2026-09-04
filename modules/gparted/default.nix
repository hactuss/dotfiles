{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gparted
    gparted-full
    gpart
    dosfstools
    mtools
    btrfs-progs
    e2fsprogs
    jfsutils
    util-linux
    linux
  ];
}
