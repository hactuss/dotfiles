{my-variables, ...}: {
  # toPath: DEPRECATED. Use /. + "/path" to convert a string into an absolute path. For relative paths, use ./. + "/path".
  desktopModules = map (module: my-variables.modulesPath + "/${module}") [
    # Mandatory
    "nh"
    "updating"
    "nix"
    "git"
    "ly"
    "neovim"
    "steam"
    "obs"
    "tailscale"
    "fonts"
    "samba"
    "jellyfin"
    "navidrome"
    "obsidian"
    "swaylock"
    "dolphin"
    "udisk"
    "kdeconnect"
    "syncthing"
    "winboat"
    "fun"
    "openssh"
    "hjem"
    "gparted"
    "noctalia"
    # "lmms"
    "davinci-resolve"
    "home_inbox"
    "anki"
    #"qt" "gtk" DO NOT touch that again
  ];
  thinkpadModules = map (module: my-variables.modulesPath + "/${module}") [
    "niri"
    "samba"
    "neovim"
    "dolphin"
    "kdeconnect"
    "fun"
  ];
  allMachineModules = map (module: my-variables.modulesPath + "/${module}") [
    "dolphin"
    "ghostty"
    "git"
    "hjem"
    "kdeconnect"
    "librewolf"
    "ly"
    "neovim"
    "niri"
    "nix"
    "obsidian"
    "openssh"
    "swaylock"
    "updating"
  ];
  /*
  from VJ's config
  isNixModule = file: builtins.hasExt "nix" && file.name != "flake.nix" && !lib.hasPrefix "_" file.name;
  importTree = path: lib.toList (lib.fileFilter isNixModule path);
  */
}
