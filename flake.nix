{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations."nixos-core" = nixpkgs.lib.nixosSystem {
      modules = [ ./nixos/configuration.nix ];
    };
    nixosConfigurations."nixos-desktop" = nixpkgs.lib.nixosSystem {
      modules = [ ./nixos/configuration.nix ./nixos/desktop.nix ];
    };
    homeConfigurations."home-manager" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home-manager/home.nix ];
    };
  };
}