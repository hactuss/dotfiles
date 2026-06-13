{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "hactuss";
    hardwareAcceleration.enable = true;
  };
}
