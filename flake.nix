{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = { 
      emerald = nixpkgs.lib.nixosSystem {
       specialArgs = {inherit inputs;};
       modules = [
        ./hosts/emerald/configuration.nix
        ./modules/nixos/neovim.nix
        # inputs.home-manager.nixosModules.default
       ];
      };
      opal = nixpkgs.lib.nixosSystem {
       specialArgs = {inherit inputs;};
       modules = [
        ./hosts/opal/configuration.nix
        # inputs.home-manager.nixosModules.default
       ];
      };
    };
  };
}
