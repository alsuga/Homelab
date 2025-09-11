{
  description = "Homelab NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, sops-nix, ... }: {
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
          sops-nix.nixosModules.sops
          ./disko-config.nix
          ./configuration.nix
        ];
      };
      
      # Add more nodes as needed
    };
  };
}
