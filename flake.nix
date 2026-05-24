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

      # Desktop config
      emerald = nixpkgs.lib.nixosSystem {
       specialArgs = {inherit inputs;};
       modules = [
        ./hosts/emerald/configuration.nix
        ./modules/nixos/neovim.nix
        ./modules/nixos/steam.nix
        # inputs.home-manager.nixosModules.default
       ];
      };

      # Thinkpad config
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
