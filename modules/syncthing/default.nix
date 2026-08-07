{ ... }: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/hactuss";
    configDir = "/home/hactuss/.config/syncthing";
    user = "hactuss";
    openDefaultPorts = true;
    settings = {
      gui.user = "hactuss";
      gui.password = "password";
      devices = {
        "Macbook" = {
          id = "VSQM2BJ-N4D75ZK-66PTJI6-YZEY3KN-4LFCT4Q-TPI6FNO-CROT3ZC-5UWE5QL";
          autoAcceptFolders = true;
        };
      };
      folders = {
        "deltarune" = {
          path = "/home/hactuss/.steam/steam/steamapps/compatdata/1671210/pfx/drive_c/users/steamuser/AppData/Local/DELTARUNE";
          devices = [ "Macbook" ];
        };
        "undertale" = {
          path = "~/.config/UNDERTALE";
          devices = [ "Macbook" ];

        };
        "Obsidian Vault" = {
          path = "~/Obsidian Vault";
          devices = [ "Macbook" ];
        };
      };
      # options = {};
    };
  };
}
