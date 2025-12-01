{
  description = "Advent of Code flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        nixFormatter = pkgs.nixfmt-rfc-style;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nixd
            nixFormatter
          ];

        };

        formatter = nixFormatter;
      }
    );
}
