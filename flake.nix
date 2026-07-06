{
  description = "latest Nixos config flake by hactuss";
  ###########################################################################
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrappers.url = "github:Lassulus/wrappers";
    import-tree.url = "github:denful/import-tree";
    hjem.url = "github:feel-co/hjem";
    hjem.inputs.nixpkgs.follows = "nixpkgs";
  };
  ###########################################################################
  outputs =
    {
      self,
      nixpkgs,
      #wrappers,
      ...
    }@inputs:
    #################################################################
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      username = "hactuss";
      desktopName = "emerald";
      thinkpadName = "opal";
      modulesPath = ./modules;
      hostsPath = ./hosts;
      desktopPath = hostsPath + ("/" + desktopName);
      thinkpadPath = hostsPath + ("/" + thinkpadName);
      lib = nixpkgs.lib;
      # toPath: DEPRECATED. Use /. + "/path" to convert a string into an absolute path. For relative paths, use ./. + "/path".
      desktopModules = map (module: modulesPath + "/${module}") [
        "test"
        "test2"
      ];
    in
    #########################################################################
    {
      # formatter.system = pkgs.alejandra;
      nixosConfigurations = {
        # Desktop config
        emerald = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
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
            # (lib.map (x: modulesPath + x) [ "/test" ])

            ./modules/ly
            ./modules/neovim
            ./modules/steam
            ./modules/obs
            ./modules/tailscale
            ./modules/fonts
            #./modules/ba.nix
            ./modules/samba
            ./modules/jellyfin
            ./modules/navidrome
            ./modules/Nix
            ./modules/Nix/nh
            #./modules/Terminal/ghostty does not work
            ./modules/termusic
            ./modules/obsidian
            ./modules/synthv1
            ./modules/swaylock
            ./modules/wireshark
          ]
          ++ desktopModules;
        };

        # Thinkpad config
        opal = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/opal/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.users.hactuss = { ... }: {
                imports = [
                  ./hosts/opal/home.nix
                ];
              };
            }
            ./modules/windowManager
            ./modules/samba
            #./modules/Terminal/ghostty does not work
            #./modules/Browser/librewolf
            ./modules/random-packages
            ./modules/neovim
            ./modules/Nix/nh
          ];
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
