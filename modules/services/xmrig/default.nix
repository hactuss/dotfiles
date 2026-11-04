{pkgs, ...}: {
  services.xmrig = {
    enable = true;
    package = pkgs.xmrig;
    settings = {
      autosave = true;
      cpu = true;
      opencl = false;
      cuda = false;
      pools = [
        {
          url = "pool.supportxmr.com:443";
          user = "44kBjERLZSR5syNjVyqxthMuZqZ79tPah8GcxsQxoaNP3T1g5qwGLUUGVcmT3o2y6FcBUEhsMesPxCzqR9ueYibBRfpMLeu";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };
}
