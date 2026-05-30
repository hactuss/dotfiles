{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    steam-mod.enable = lib.mkEnableOption "enables steam-mod";
  };
  config = lib.mkIf config.steam-mod.enable {
    programs.lutris.enable = true;
  };
}
