{pkgs, ...}: {
  services.xmrig = {
    enable = true;
    package = pkgs.xmrig-cuda;
    /*
    settings = {
    autosave = true;
      cpu = true;
      opencl = false;
      cuda = true;
      donate-level = 0;
      pools = [
        {
       url = "xmrpool.eu:9999";
          user = "44kBjERLZSR5syNjVyqxthMuZqZ79tPah8GcxsQxoaNP3T1g5qwGLUUGVcmT3o2y6FcBUEhsMesPxCzqR9ueYibBRfpMLeu";
          keepalive = true;
          tls = true;
        }
      ];
    };
    */
  };
}
