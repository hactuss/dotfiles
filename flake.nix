{
  description = "latest Nixos config flake by hactuss";
  ###########################################################################
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrappers.url = "github:Lassulus/wrappers";
    import-tree.url = "github:denful/import-tree";
    hjem.url = "github:feel-co/hjem";
    hjem.inputs.nixpkgs.follows = "nixpkgs";
    helium.url = "github:tomsch/helium-nix";
    nixgl.url = "github:nix-community/nixGL";
    flake-parts.url = "github:hercules-ci/flake-parts";
    niri.url = "github:niri-wm/niri";
  };
  ###########################################################################
  outputs =
    {
      nixpkgs,
      #wrappers,
      helium,
      nixgl,
      flake-parts,
      ...
    }@inputs:
    #################################################################
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [ nixgl.overlay ];
      variables = import ./variables.nix;
      username = variables.username;
      desktopName = "emerald";
      thinkpadName = "opal";
      modulesPath = ./modules;
      hostsPath = ./hosts;
      configfilesPath = ./configfilesPath;
      desktopPath = hostsPath + "/${desktopName}";
      thinkpadPath = hostsPath + "/${thinkpadName}";
      # toPath: DEPRECATED. Use /. + "/path" to convert a string into an absolute path. For relative paths, use ./. + "/path".
      desktopModules = map (module: modulesPath + "/${module}") [
        "test"
        "test2"
        "Nix/nh"
        "Nix/updating"
        "ly"
        "neovim"
        "steam"
        "obs"
        "tailscale"
        "fonts"
        "samba"
        "jellyfin"
        "navidrome"
        "Nix"
        "termusic"
        "obsidian"
        "synthv1"
        "swaylock"
        "wireshark"
        "dolphin"
        "btop"
        "systemd"
        "wireshark"
        "udisk"
        "davinci-resolve"
      ];
      thinkpadModules = map (module: modulesPath + "/${module}") [
        "niri"
        "samba"
        "random-packages"
        "neovim"
        "Nix/nh"
        "dolphin"
        "kdeconnect"
      ];
    in
    #########################################################################
    {
      # formatter.system = pkgs.alejandra;
      nixosConfigurations = {
        # Desktop config
        "${desktopName}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit variables;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.users.hactuss = { ... }: {
                imports = [
                  (desktopPath + "/home.nix")
                ];
              };
            }
            #inputs.hjem.nixosModules.default
            (desktopPath + "/configuration.nix")
            {
              environment.systemPackages = [
                helium.packages.${system}.default
              ];
            }
          ]
          ++ desktopModules;
        };

        # Thinkpad config
        opal = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            (thinkpadPath + "/configuration.nix")
            inputs.home-manager.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.users.hactuss = { ... }: {
                imports = [
                  (thinkpadPath + "/home.nix")
                ];
              };
            }
          ]
          ++ thinkpadModules;
        };
      };
      ###################################################################
      devShells."x86_64-linux" = {
        svelte = pkgs.mkShell {
          packages = with pkgs; [
            pnpm
          ];
        };
        rust = pkgs.mkShell {
          packages = with pkgs; [
            rustc
            cargo
            rust-analyzer
            clippy
          ];
        };
      };
      ##################################################################
    };
}
