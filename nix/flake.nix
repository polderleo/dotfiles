{
  description = "Niklas dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    darwin = {
      # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin }: {

    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

    darwinConfigurations."Niklas-Machbuch" = darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
      modules = [ ./default.nix ];
    };

  };
}
