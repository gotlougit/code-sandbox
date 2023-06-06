{ pkgs ? import <nixpkgs> {} }:
{ lib, stdenv }:

let
  slirp4netns = pkgs.slirp4netns;
  bubblewrap = pkgs.bubblewrap;
in
pkgs.stdenv.mkDerivation {
  pname = "code-sandbox";
  version = "0.1";
  src = ./.;
  buildInputs = [ slirp4netns bubblewrap ];
  buildPhase = ''
    g++ parent-ns-enter.c -o parent-ns-enter
  '';
  installPhase = ''
    mkdir -p $out/bin
    mv parent-ns-enter $out/bin
    chmod +x dev.sh
    mv dev.sh $out/bin/code-sandbox
  '';
  meta = with lib; {
    description = "Create isolated environment for development";
    license = licenses.mit;
    platforms = platforms.linux;
  };

}