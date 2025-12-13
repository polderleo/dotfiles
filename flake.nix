{
  description = "Leopolds dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-25.11";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      darwinSystem = "aarch64-darwin";

      myNixpkgs = system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (final: prev: {
              ollama = inputs.nixpkgs-stable.legacyPackages.${system}.ollama;
            })
          ];
        };

      homeManagerConfig = {
        useGlobalPkgs = true;
        users.ldsr = import ./nix/home.nix;
        sharedModules = [ ./tmux/tmux-module.nix ];
      };

      darwinSystemConfig = inputs.nix-darwin.lib.darwinSystem {
        system = darwinSystem;
        specialArgs = {
          pkgs = myNixpkgs darwinSystem;
        };
        modules = [
          ./nix/darwin.nix
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = homeManagerConfig;
          }
          ./nix/ollama.nix
        ];
      };

      pkgs = inputs.nixpkgs.legacyPackages.${darwinSystem};
    in
    {
      formatter.${darwinSystem} = pkgs.nixfmt-rfc-style;

      devShells.${darwinSystem}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nixfmt-rfc-style
        ];
      };

      darwinConfigurations."Leopolds-MacBook-Pro" = darwinSystemConfig;
    };
}
