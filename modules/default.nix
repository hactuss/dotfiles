{my-variables, ...}: {
  allMachineModules = map (module: my-variables.modulesPath + "/${module}") [
    "programs/dolphin"
    "programs/ghostty"
    "utils/git"
    "programs/librewolf"
    "system/noctalia"
    "system/fonts"
    "system/nix"
    "programs/obsidian"
    "services/openssh"
    "system/swaylock"
    "services/docker"
    "system/ly"
    "utils/lazygit"
    "system/niri"
  ];
  desktopUtils = map (module: my-variables.modulesPath + "/utils" + "/${module}") [
    #"nh"
    "disk/udisk"
    "disk/gparted"
    "home_inbox"
  ];
  desktopPrograms = map (module: my-variables.modulesPath + "/programs" + "/${module}") [
    "neovim"
    "steam"
    "obs"
    "kdeconnect"
    "winboat"
    "davinci-resolve"
    "anki" # "lmms"
  ];
  desktopSystem = map (module: my-variables.modulesPath + "/system" + "/${module}") [
    "hjem"
  ];
  desktopServices = map (module: my-variables.modulesPath + "/services" + "/${module}") [
    "tailscale"
    "samba"
    "jellyfin"
    "navidrome"
    # "syncthing"
    # "xmrig"
  ];

  thinkpadSystem = map (module: my-variables.modulesPath + "/system" + "/${module}") [
    # "hjem/opal.nix"
    "auto-cpufreq"
    "upower"
  ];
  thinkpadPrograms = map (module: my-variables.modulesPath + "/programs" + "/${module}") [
    "neovim"
    "kdeconnect"
  ];
  thinkpadServices = map (module: my-variables.modulesPath + "/services" + "/${module}") [
    "samba"
    #"syncthing"
    "tailscale"
  ];
  thinkpadUtils =
    map (module: my-variables.modulesPath + "/utils" + "/${module}") [
    ];

  /*
  from VJ's config
  isNixModule = file: builtins.hasExt "nix" && file.name != "flake.nix" && !lib.hasPrefix "_" file.name;
  importTree = path: lib.toList (lib.fileFilter isNixModule path);
  */
}
