{...}: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      #animation = "colormix";
      #animation = "gameoflife";
      # animation = "lua";
      show_tty = true;
      bigclock = "en";
      clear_password = true;
      blank_box = true;
      border_fg = "0x0000FF00";
      box_title = "Welcome!";
      #colormix_col1 = ;
      margin_box_h = 0;
      margin_box_v = 0;
      box_position_h = 0.5;
      box_position_v = 0.2;
      ly_log = "/var/log/ly.log";
      # lua_animation_file = "${my-variables.configPath}/configfiles/ly/ElemCellAuto.lua";
    };
  };
}
