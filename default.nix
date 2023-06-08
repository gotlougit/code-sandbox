{ lib, stdenv }:

stdenv.mkDerivation {
  pname = "app-sandboxes";
  version = "0.1";
  src = ./.;
  buildPhase = ''
    g++ parent-ns-enter.c -o parent-ns-enter
  '';
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mv parent-ns-enter $out/bin
    chmod +x code-sandbox
    mv code-sandbox $out/bin/code-sandbox
    chmod +x mullvad-browser-sandbox
    mv mullvad-browser-sandbox $out/bin/mullvad-browser-sandbo
    mv mullvadbrowser-sandbox.desktop $out/share/applications/
  '';
  meta = with lib; {
    description = "Create isolated environments for various programs";
    license = licenses.mit;
    platforms = platforms.linux;
  };

}