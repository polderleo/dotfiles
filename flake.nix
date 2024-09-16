{
  description = "Niklas dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";
    darwin = {
      # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
      url = "github:niklasravnsborg/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
    dotfiles-secrets = {
      url = "git+ssh://git@github.com/niklasravnsborg/dotfiles-secrets?shallow=1";
      flake = false;
    };
  };

  outputs = { nixpkgs, darwin, home-manager, sops-nix, ... }@inputs: {

    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

    darwinConfigurations."Niklas-Machbuch" = darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
      specialArgs = { inherit inputs; };
      modules = [
        ./nix/darwin.nix
        home-manager.darwinModules.home-manager
        sops-nix.darwinModules.sops
        {
          home-manager = {
            useGlobalPkgs = true;
            users.nik = import ./nix/home.nix;

            # pass arguments to home.nix
            extraSpecialArgs = {
              configDir = "/Users/nik/dotfiles";
            };
          };
        }
      ];
    };

    nixosConfigurations."Niklas-Workstation" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.nik = import ./nix/home.nix;

            # pass arguments to home.nix
            extraSpecialArgs = {
              configDir = "/home/nik/dotfiles";
            };
          };
        }
      ];
    };

  };
}
