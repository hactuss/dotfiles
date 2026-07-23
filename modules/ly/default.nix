{ ... }: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      #animation = "colormix";
      #animation = "gameoflife";
      animation = "cmatrix";
      show_tty = true;
      bigclock = "en";
      clear_password = true;
      /*blank_box = true;
      border_fg = "0x0000FF00";
      box_title = "Welcome, User";
      #colormix_col1 = ;
      margin_box_h = 1.5;*/ 
    };
  };

}
