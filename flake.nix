{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, lanzaboote, nixos-wsl, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations."cli" = nixpkgs.lib.nixosSystem {
      modules = [ lanzaboote.nixosModules.lanzaboote ./nixos/configuration.nix ];
    };
    nixosConfigurations."desktop" = nixpkgs.lib.nixosSystem {
      modules = [ lanzaboote.nixosModules.lanzaboote ./nixos/configuration.nix ./nixos/desktop.nix ];
    };
    nixosConfigurations."wsl2" = nixpkgs.lib.nixosSystem {
      modules = [ nixos-wsl.nixosModules.default ./nixos/wsl2.nix ];
    };
    homeConfigurations."cli" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home-manager/cli.nix ];
    };
    homeConfigurations."desktop" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home-manager/cli.nix ./home-manager/desktop.nix ];
    };
  };
}