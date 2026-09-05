{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    czkawka-full
    rdfind
    dupeguru
    git-annex-metadata-gui
    exiftool
    exif
    diff-so-fancy
    diffutils
  ];
}
