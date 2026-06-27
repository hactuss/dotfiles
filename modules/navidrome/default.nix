{pkgs, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = true;
    user = "hactuss";
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = "./music";
      Scanner.PurgeMissing = "always";
      Scanner.ScanOnStartup = true;
      DefaultTheme = "Dark";
      Plugins.Enable = true;
    };
    plugins = with pkgs.navidromePlugins; [
      listenbrainz-daily-playlist
    ];
  };
}
