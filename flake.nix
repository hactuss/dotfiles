{
  description = "Nixos config flake by hactuss";
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05"; # 26.05
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:denful/import-tree";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixgl.url = "github:nix-community/nixGL";
    # niri.url = "github:niri-wm/niri";
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    auto-cpufreq,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    username = "hactuss";
    desktopName = "emerald";
    thinkpadName = "opal";
    modulesPath = ./modules;
    hostsPath = ./hosts;
    configfilesPath = ./configfilesPath;
    desktopPath = hostsPath + "/${desktopName}";
    thinkpadPath = hostsPath + "/${thinkpadName}";
    my-variables = rec {
      inherit
        username
        desktopName
        thinkpadName
        modulesPath
        hostsPath
        configfilesPath
        desktopPath
        thinkpadPath
        ;
      homedir = /home/${username};
      configPath = /${homedir}/dotfiles;
      timezone = "Europe/Berlin";
    };
    modulesimport = import ./modules/default.nix {inherit my-variables;};
  in {
    nixosConfigurations = {
      # Desktop config
      ${desktopName} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit my-variables;
        };
        modules =
          [
            # inputs.home-manager.nixosModules.home-manager
            /*
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.users.${username} = { ... }: {
                imports = [
                  (desktopPath + "/home.nix")
                ];
              };
            }
            */
            inputs.hjem.nixosModules.default
            (desktopPath + "/configuration.nix")
          ]
          ++ modulesimport.desktopPrograms
          ++ modulesimport.desktopSystem
          ++ modulesimport.desktopServices
          ++ modulesimport.desktopUtils
          ++ modulesimport.allMachineModules;
      };

      # Thinkpad config
      ${thinkpadName} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit my-variables;
        };
        modules =
          [
            (thinkpadPath + "/configuration.nix")
            /*
            inputs.home-manager.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.users.${username} = {...}: {
                imports = [
                  (thinkpadPath + "/home.nix")
                ];
              };
            }
            */
            inputs.hjem.nixosModules.default
            auto-cpufreq.nixosModules.default

            # ./modules/temporary-packages.nix
          ]
          ++ modulesimport.thinkpadPrograms
          ++ modulesimport.thinkpadSystem
          ++ modulesimport.thinkpadServices
          ++ modulesimport.thinkpadUtils
          ++ modulesimport.allMachineModules;
      };
    };
  };
}
