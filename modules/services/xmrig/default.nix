{pkgs, ...}: {
  services.xmrig = {
    enable = true;
    package = pkgs.xmrig;
  };
}
