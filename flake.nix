{
  description = "latest Nixos config flake by hactuss";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      # Desktop config
      emerald = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/emerald/configuration.nix
          ./modules/nixos/neovim.nix
          ./modules/nixos/steam.nix
          ./modules/nixos/desktopManager.nix
          ./modules/nixos/obs-studio.nix
          # inputs.stylix.nixosModules.stylix
        ];
      };

      # Thinkpad config
      opal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/opal/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
