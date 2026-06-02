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
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };
    environment.systemPackages = [
      pkgs.protonup-ng
      pkgs.mangohud
    ];
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
