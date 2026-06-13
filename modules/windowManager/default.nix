{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    desktopManager.enable = lib.mkEnableOption "enables windowManager";
  };
  config = lib.mkIf config.windowManager.enable {
    programs = {
      niri.enable = true;
      #sway.enable = true;
      #hyprland.enable = true;
      #waybar.enable = true;
    };
    services.desktopManager.plasma6.enable = true;
    programs.xwayland = {
      enable = true;
      package = pkgs.xwayland-satellite;
    };
  };
}
