{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix/release-25.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in  
{
    nixosConfigurations = {

      # Desktop config
      emerald = nixpkgs.lib.nixosSystem {
       extraSpecialArgs = {inherit inputs;};
       modules = [
        ./hosts/emerald/configuration.nix
        ./modules/nixos/neovim.nix
        ./modules/nixos/steam.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix 
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
