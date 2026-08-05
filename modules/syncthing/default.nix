{ pkgs, ... }: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/hactuss";
    user = "hactuss";
    settings = {
      folders."deltarune" = {
        enable = true;
        path = "/home/hactuss/.steam/steam/steamapps/compatdata/1671210/pfx/drive_c/users/steamuser/AppData/Local/DELTARUNE";
        type = "sendrecive";
      };
    };
  };
}
