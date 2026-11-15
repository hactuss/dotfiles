{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fastfetch
    screenfetch
    cmatrix
    hollywood
    cbonsai
    cowsay
  ];
}
