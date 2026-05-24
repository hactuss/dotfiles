{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    tmux-mod.enable = lib.mkEnableOption "enables tmux-mod";
  };
  config = lib.mkIf config.tmux-mod.enable {
    programs.tmux = {
      enable = true;
    };
  };
}
