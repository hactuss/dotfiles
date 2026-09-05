{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio # needed since 25.11
    kdePackages.kio-fuse # to mount remote filesystems via FUSE
    kdePackages.kio-extras # extra protocols support (sftp, fish and more)
    icoutils
    libappimage
    resvg
    taglib
  ];
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  environment.sessionVariables = {
    XDG_MENU_PREFIX = "arch- kbuildsycoca6 --noincremental";
  };
}
