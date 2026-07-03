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
  };
  ###########################################################################
  outputs = {
    self,
    nixpkgs,
    wrappers,
    ...
  } @ inputs:
  #################################################################
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
    #########################################################################
    {
      formatter.system = "alejandra";
      nixosConfigurations = {
        # Desktop config
        emerald = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.users.hactuss = {...}: {
                imports = [
                  ./hosts/emerald/home.nix
                ];
              };
            }
            ./hosts/emerald/configuration.nix
            ./modules/neovim
            ./modules/steam
            #./modules/windowManager
            ./modules/obs
            # inputs.stylix.nixosModules.stylix
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
          ];
        };

        # Thinkpad config
        opal = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/opal/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.users.hactuss = {...}: {
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
