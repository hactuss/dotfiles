{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fastfetch
    screenfetch
    cmatrix
    hollywood
    pywal16
    cwal
    hellwal
    wallust
    # libdisplay-info
    cbonsai
    cowsay
  ];
}
