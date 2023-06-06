{
  inputs.nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
  description = "code-sandbox flake";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages = {
        default = pkgs.callPackage ./default.nix {};
      };
      devShell = pkgs.mkShell {
        buildInputs = [pkgs.slirp4netns pkgs.bubblewrap];
      };
    };
}
