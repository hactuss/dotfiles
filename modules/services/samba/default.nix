{my-variables, ...}: {
  services = {
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global.security = "user";

        "emerald-mine" = {
          "path" = "/";
          "valid users" = "${my-variables.username}";
          "public" = "yes";
          "writable" = "yes";
          "browsable" = "yes";
          "read only" = "no";
          "force user" = "${my-variables.username}";
        };
      };
    };
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
