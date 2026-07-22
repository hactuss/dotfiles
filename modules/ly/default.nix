{ ... }: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      animations = "colormix";
      # animations = "gameoflife";
      show_tty = true;
      bigclock = "en";
      clear_password = true;
    };
  };

}
