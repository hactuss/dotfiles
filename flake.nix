{
  description = "latest Nixos config flake by hactuss";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrappers.url = "github:Lassulus/wrappers";
  };

  outputs =
    {
      self,
      nixpkgs,
      wrappers,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        # Desktop config
        emerald = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
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
            ./modules/Terminal/ghostty
          ];
        };

        # Thinkpad config
        opal = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/opal/configuration.nix
            inputs.home-manager.nixosModules.default
            ./modules/windowManager
            ./modules/samba
          ];
        };
      };
    };
}
