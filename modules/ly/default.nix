{ ... }: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      #animation = "gameoflife";
      show_tty = true;
      bigclock = "en";
      clear_password = true;
    };
  };

}
