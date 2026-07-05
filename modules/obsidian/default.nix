{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.obsidian
    pkgs.rofi-obsidian
  ];
}
