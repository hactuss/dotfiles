{
  services.navidrome = {
    enable = true;
    openFirewall = true;
    user = "hactuss";
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = "./music";
      Scanner.PurgeMissing = "always";
    };
  };
}
