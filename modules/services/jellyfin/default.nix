{my-variables, ...}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "${my-variables.username}";
    hardwareAcceleration = {
      enable = true;
      device = "/dev/dri/renderD128";
    };
  };
}
