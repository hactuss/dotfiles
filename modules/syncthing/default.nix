{ ... }: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/hactuss";
    user = "hactuss";
    openDefaultPorts = true;
    settings = {
      gui.user = "hactuss";
      /*
        folders = {
          "deltarune" = {
            enable = true;
            path = "/home/hactuss/.steam/steam/steamapps/compatdata/1671210/pfx/drive_c/users/steamuser/AppData/Local/DELTARUNE";
          };
          "undertale" = {
            enable = true;
            path = "~/.config/UNDERTALE";
          };
          "Obsidian Vault" = {
            enable = true;
            path = "~/Obsidian Vault";
          };
          };
      */
    };
  };
}
