{
  inputs.nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
  description = "app-sandboxes flake";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = {
        default = pkgs.callPackage ./default.nix {};
      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [pkgs.slirp4netns pkgs.bubblewrap];
      };
    };
}
