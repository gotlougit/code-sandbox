{
  description = "code-sandbox flake";

  inputs.nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }:
    {
      packages.x86_64-linux.code-sandbox =
        nixpkgs.legacyPackages.x86_64-linux.callPackage ./package.nix {};
    };
}
