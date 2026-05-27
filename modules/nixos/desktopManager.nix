{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    desktopManager.enable = lib.mkEnableOption "enables desktopManager";
  };
  config = lib.mkIf config.desktopManager.enable {
    programs = {
      niri.enable = true;
      sway.enable=true;
      hyprland.enable=true;
    };
    services.xserver={
    desktopManager={cinnamon.enable = true;xfce.enable=true;};
windowManager.i3.enable=true;
    };
  };
}
