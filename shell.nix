{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = with pkgs; [
    nixd
    nixpkgs-fmt
  ];
}
