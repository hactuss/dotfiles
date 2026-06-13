{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global.security = "user";

      "emerald-mine" = {
        "path" = "/";
        "valid users" = "hactuss";
        "public" = "yes";
        "writable" = "yes";
        "browsable" = "yes";
        "read only" = "no";
        "force user" = "hactuss";
      };
    };
  };
}
