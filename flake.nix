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
          ./modules/neovim.nix
          ./modules/steam
          ./modules/desktopManager.nix
          ./modules/obs-studio.nix
          # inputs.stylix.nixosModules.stylix
          ./modules/tailscale
	  ./modules/fonts.nix
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
