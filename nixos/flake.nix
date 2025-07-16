{
  description = "Homelab NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, agenix, ... }: {
    nixosConfigurations = {
      homelab-0 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          meta = {
            hostname = "homelab-0";
          };
        };
        modules = [
          disko.nixosModules.disko
          agenix.nixosModules.default
          ./disko-config.nix
          ./configuration.nix
        ];
      };
      
      # Add more nodes as needed
  }
}
