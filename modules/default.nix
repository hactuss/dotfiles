{my-variables, ...}: {
  allMachineModules = map (module: my-variables.modulesPath + "/${module}") [
    "programs/dolphin"
    #"programs/ghostty"
    "utils/git"
    #"programs/librewolf"
    "system/noctalia"
    "system/fonts"
    "system/nix"
    #"programs/obsidian"
    "services/openssh"
    "system/swaylock"
    "services/docker"
    "system/ly"
    # "utils/lazygit"
    "system/niri"
    "programs/neovim"
    "programs/kdeconnect"
    "services/tailscale"
  ];
  desktopUtils = map (module: my-variables.modulesPath + "/utils" + "/${module}") [
    "disk/udisk"
    "disk/gparted"
    "home_inbox"
  ];
  desktopPrograms = map (module: my-variables.modulesPath + "/programs" + "/${module}") [
    "steam"
    "obs"
    "winboat"
    #"davinci-resolve"
    #"anki" # "lmms"
  ];
  desktopSystem = map (module: my-variables.modulesPath + "/system" + "/${module}") [
    "hjem"
  ];
  desktopServices = map (module: my-variables.modulesPath + "/services" + "/${module}") [
    "samba"
    "jellyfin"
    "navidrome"
    # "syncthing"
    # "xmrig"
  ];

  thinkpadSystem = map (module: my-variables.modulesPath + "/system" + "/${module}") [
    "auto-cpufreq"
    "upower"
  ];
  thinkpadPrograms = map (module: my-variables.modulesPath + "/programs" + "/${module}") [];
  thinkpadServices = map (module: my-variables.modulesPath + "/services" + "/${module}") [
    # "syncthing
  ];
  thinkpadUtils = map (module: my-variables.modulesPath + "/utils" + "/${module}") [];
}
