{my-variables, ...}: {
  hjem = {
    clobberByDefault = true;
    users.${my-variables.username} = {
      enable = true;
      directory = "/home/hactuss";
      user = "${my-variables.username}";
      files = {
        "./.bashrc".source = ./../../configfiles/.bashrc;
        "./.config/niri/config.kdl".source = ./../../configfiles/niri/config.kdl;
        "./.gitconfig".source = ./../../configfiles/.gitconfig;
        "./.config/fuzzel/fuzzel.ini".source = ./../../configfiles/fuzzel/fuzzel.ini;
        "./.config/dolphinrc".source = ./../../configfiles/dolphinrc;
        "./.config/zed/settings.json".source = ./../../configfiles/zed/settings.json;
        "./.config/waybar/config.jsonc".source = ./../../configfiles/waybar/config.jsonc;
        "./.config/waybar/style.css".source = ./../../configfiles/waybar/style.css;
        "./.config/syncthing/config.xml".source = ./../../configfiles/syncthing/config.xml;
        "./.config/swaylock/config".source = ./../../configfiles/swaylock/frappe;
      };
    };
  };
}
