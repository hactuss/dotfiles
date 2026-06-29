{
  config,
  pkgs,
  lib,
  ...
}: {
/*
options = {
    neovim-mod.enable = lib.mkEnableOption "enables neovim-mod";
  };
  config = lib.mkIf config.neovim-mod.enable {
    */programs.neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
    };
  }
#}
