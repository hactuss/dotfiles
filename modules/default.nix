{ my-variables, ... }: {
  desktopUtils = map (module: my-variables.modulesPath + "/utils" + "/${module}") [
    "nh"
    "git"
    "udisk"
    "fun"
    "gparted"
    "home_inbox"
  ];
  desktopPrograms = map (module: my-variables.modulesPath + "/programs" + "/${module}") [
    "neovim"
    "steam"
    "obs"
    "obsidian"
    "dolphin"
    "kdeconnect"
    "winboat"
    "davinci-resolve"
    "anki" # "lmms"
  ];
  desktopSystem = map (module: my-variables.modulesPath + "/system" + "/${module}") [
    "updating"
    "nix"
    "ly"
    "fonts"
    "swaylock"
    "hjem"
    "noctalia"
  ];
  desktopServices = map (module: my-variables.modulesPath + "/services" + "/${module}") [
    "tailscale"
    "samba"
    "jellyfin"
    "navidrome"
    "syncthing"
    "openssh"
  ];

  thinkpadSystem = map (module: my-variables.modulesPath + "/system" + "/${module}") [
    "niri"
  ];
  thinkpadPrograms = map (module: my-variables.modulesPath + "/programs" + "/${module}") [
    "neovim"
    "dolphin"
    "kdeconnect"
  ];
  thinkpadServices = map (module: my-variables.modulesPath + "/services" + "/${module}") [
    "samba"
  ];
  thinkpadUtils = map (module: my-variables.modulesPath + "/utils" + "/${module}") [
    "fun"
  ];
  thinkpadModules = map (module: my-variables.modulesPath + "/${module}") [
  ];
  allMachineModules = map (module: my-variables.modulesPath + "/${module}") [
    "programs/dolphin"
    "programs/ghostty"
    "utils/git"
    "system/hjem"
    "programs/kdeconnect"
    "programs/librewolf"
    "system/ly"
    "programs/neovim"
    "system/niri"
    "system/noctalia"
    "system/fonts"
    "system/nix"
    "programs/obsidian"
    "services/openssh"
    "system/swaylock"
    "system/updating"
  ];
  # toPath: DEPRECATED. Use /. + "/path" to convert a string into an absolute path. For relative paths, use ./. + "/path".

  /*
    from VJ's config
    isNixModule = file: builtins.hasExt "nix" && file.name != "flake.nix" && !lib.hasPrefix "_" file.name;
    importTree = path: lib.toList (lib.fileFilter isNixModule path);
  */
}
