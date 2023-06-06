{
  description = "code-sandbox flake";

  outputs = { self, nixpkgs }:
    {
      packages.x86_64-linux.code-sandbox =
        nixpkgs.legacyPackages.x86_64-linux.callPackage ./default.nix {};
    };
}
