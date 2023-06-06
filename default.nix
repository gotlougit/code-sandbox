{ lib, stdenv }:

stdenv.mkDerivation {
  pname = "code-sandbox";
  version = "0.1";
  src = ./.;
  buildPhase = ''
    g++ parent-ns-enter.c -o parent-ns-enter
  '';
  installPhase = ''
    mkdir -p $out/bin
    mv parent-ns-enter $out/bin
    chmod +x code-sandbox
    mv code-sandbox $out/bin/code-sandbox
  '';
  meta = with lib; {
    description = "Create isolated environment for development";
    license = licenses.mit;
    platforms = platforms.linux;
  };

}