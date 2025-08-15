{
  description = "Leopolds dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";
    nix-darwin = {
      url = "github:niklasravnsborg/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.brew-src.url = "github:Homebrew/brew/4.4.25";
    };
    # nix-darwin-custom-icons = {
    #   url = "github:ryanccn/nix-darwin-custom-icons";
    # };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      systems = {
        darwin = "aarch64-darwin";
        # nixos = "x86_64-linux";
      };
      myNixpkgs =
        system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          # overlays = [
          #   # (import ./nix/overlays/claude.nix)
          #   # # bitwarden-cli-2025.3.0 had some build issues
          #   # (final: prev: { bitwarden-cli = inputs.nixpkgs-stable.legacyPackages.${system}.bitwarden-cli; })
          # ];
        };
      sharedModules = [
        ./tmux/tmux-module.nix
      ];
      # secretsPath = builtins.toString inputs.dotfiles-secrets;
      homeManagerConfig = {
        useGlobalPkgs = true;
        users.ldsr = import ./nix/home.nix;
        inherit sharedModules;
        # extraSpecialArgs = {
        #   inherit secretsPath;
        # };
      };
      darwinSystem = inputs.nix-darwin.lib.darwinSystem {
        system = systems.darwin;
        specialArgs = {
          # inherit secretsPath;
          pkgs = myNixpkgs systems.darwin;
        };
        modules = [
          ./nix/darwin.nix
          # inputs.nix-darwin-custom-icons.darwinModules.default
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
          {
            home-manager = homeManagerConfig;
            nix-homebrew = {
              enable = true;
              user = "ldsr";
            };
          }
        ];
      };
      # nixosSystem = inputs.nixpkgs.lib.nixosSystem {
      #   system = systems.nixos;
      #   specialArgs = {
      #     inherit secretsPath;
      #     pkgs = myNixpkgs systems.nixos;
      #   };
      #   modules = [
      #     ./nixos/configuration.nix
      #     inputs.home-manager.nixosModules.home-manager
      #     {
      #       home-manager = homeManagerConfig // {
      #         useUserPackages = true;
      #       };
      #     }
      #   ];
      # };
    in
    {

      formatter.aarch64-darwin = inputs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;

      darwinConfigurations."Leopolds-MacBook-Pro" = darwinSystem;
      # nixosConfigurations."Quastenflosser" = nixosSystem;

    };
}
