{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wireshark
    wireshark-cli
  ];
  programs.wireshark.package = pkgs.wireshark;
}
