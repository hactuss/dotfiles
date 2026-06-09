# only works with home-manager
{
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "toml"];
    userSettings = {
      theme = {
        mode = "dark";
        dark = "One Dark";
        light = "One Light";
      };
      hour_format = "hour24";
      vim_mode = true;
    };
  };
}
