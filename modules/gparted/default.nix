{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gparted
    dosfstools
    mtools
    btrfs-progs
    e2fsprogs
    jfsutils
    util-linux
    linux
  ];
}
