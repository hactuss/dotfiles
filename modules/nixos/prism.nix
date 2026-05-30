{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    prism-mod.enable = lib.mkEnableOption "enables prism-mod";
  };
  config = lib.mkIf config.prism-mod.enable {
    programs.prismlauncher = {
      enable = true;
    };
  };
}
