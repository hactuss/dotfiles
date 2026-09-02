{...}: {
  /*
  options = {
      neovim-mod.enable = lib.mkEnableOption "enables neovim-mod";
    };
    config = lib.mkIf config.neovim-mod.enable {
  */
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };
}
#}

