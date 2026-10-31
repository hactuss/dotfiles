{my-variables, ...}: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/${my-variables.username}";
    configDir = "/home/${my-variables.username}/.config/syncthing";
    user = "${my-variables.username}";
    openDefaultPorts = true;
    settings = {
      gui = {
        user = "${my-variables.username}";
        password = "password";
      };
      devices = {
        "Macbook" = {
          id = "VSQM2BJ-N4D75ZK-66PTJI6-YZEY3KN-4LFCT4Q-TPI6FNO-CROT3ZC-5UWE5QL";
          autoAcceptFolders = true;
        };
        "iPad" = {
          id = "PK4L3SO-5Z2LKGP-RDF7Z7F-B7W4H2W-QWPOMYT-XHG5CYN-DGJDFLM-LM6BEQD";
          autoAcceptFolders = true;
        };
      };
      folders = {
        "/home/hactuss/deltarune" = {
          path = "/home/hactuss/.steam/steam/steamapps/compatdata/1671210/pfx/drive_c/users/steamuser/AppData/Local/DELTARUNE";
          devices = ["Macbook"];
          versioning = {
            type = "simple";
            params.keep = "10";
          };
        };
        "/home/hactuss/undertale" = {
          path = "~/.config/UNDERTALE";
          devices = ["Macbook"];
          versioning = {
            type = "simple";
            params.keep = "10";
          };
        };
        "/home/hactuss/Obsidian Vault" = {
          path = "~/Obsidian Vault";
          devices = ["Macbook"];
          versioning = {
            type = "simple";
            params.keep = "10";
          };
        };
      };
    };
  };
}
