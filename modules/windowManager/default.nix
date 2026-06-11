{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    desktopManager.enable = lib.mkEnableOption "enables desktopManager";
  };
  config = lib.mkIf config.desktopManager.enable {
    programs = {
      niri.enable = true;
      #sway.enable = true;
      #hyprland.enable = true;
      #waybar.enable = true;
    };
    services.desktopManager.plasma6.enable = true;
  };
}
