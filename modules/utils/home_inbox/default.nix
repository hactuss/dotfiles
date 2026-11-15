{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    czkawka-full
    dupeguru
    git-annex-metadata-gui
    exiftool
    exif
  ];
}
