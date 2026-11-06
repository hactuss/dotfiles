{pkgs, ...}: {
  services.xmrig = {
    enable = true;
    package = pkgs.xmrig;
    settings = {
      autosave = true;
      cpu = true;
      opencl = false;
      cuda = false;
      donate-level = 0;
      pools = [
        {
          # url = "xmr-eu1.nanopool.org:14433";
          url = "pool.supportxmr.com:443";
          user = "44kBjERLZSR5syNjVyqxthMuZqZ79tPah8GcxsQxoaNP3T1g5qwGLUUGVcmT3o2y6FcBUEhsMesPxCzqR9ueYibBRfpMLeu.stevesupport/xfderl@proton.me";
          pass = "steve2";
          keepalive = true;
          tls = true;
          algo = "rx/0";
        }
        /*
        {
                 url = "xmr-eu1.nanopool.org:14433";
                 user = "44kBjERLZSR5syNjVyqxthMuZqZ79tPah8GcxsQxoaNP3T1g5qwGLUUGVcmT3o2y6FcBUEhsMesPxCzqR9ueYibBRfpMLeu.stevenano/xfderl@proton.me";
          pass = "steve2";
                 keepalive = true;
                 tls = true;
          algo = "rx/0";
               }
        */
      ];
    };
  };
}
