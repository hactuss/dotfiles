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
    kdePackages.ark
    kdePackages.dolphin-plugins
    ffmpegthumbnailer
    kdePackages.kdegraphics-thumbnailers
    qt6Packages.qt6ct

    #kimageformats # : Gimp *.xcf files, *.heic files (with libheif)
    libappimage # (with kio-extras also installed): embedded *.AppImage icons
  ];
}
