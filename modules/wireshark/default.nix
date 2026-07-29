{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wireshark
    wireshark-cli
    wireshark-qt
  ];
  programs.wayfire.enable = true;
  programs.wireshark.package = pkgs.wireshark;
}
