{ lib, stdenv, bubblewrap, slirp4netns, makeBinaryWrapper }:

stdenv.mkDerivation rec {
  pname = "app-sandboxes";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeBinaryWrapper ];
  buildInputs = [ bubblewrap slirp4netns ];

  buildPhase = ''
    cc parent-ns-enter.c -o parent-ns-enter
  '';

  wrapperPath = lib.makeBinPath ([
    bubblewrap
    slirp4netns
  ]);

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mv parent-ns-enter $out/bin
    chmod +x code-sandbox
    mv code-sandbox $out/bin/code-sandbox
    chmod +x build-sandbox
    mv build-sandbox $out/bin/build-sandbox
    chmod +x mullvad-browser-sandbox
    mv mullvad-browser-sandbox $out/bin/mullvad-browser-sandbox
    mv mullvadbrowser-sandbox.desktop $out/share/applications/
    chmod +x tor-browser-sandbox
    mv tor-browser-sandbox $out/bin/tor-browser-sandbox
    mv torbrowser-sandbox.desktop $out/share/applications/
  '';

  postFixup = ''
    wrapProgram $out/bin/code-sandbox --prefix PATH : "${wrapperPath}"
    wrapProgram $out/bin/build-sandbox --prefix PATH : "${wrapperPath}"
    wrapProgram $out/bin/tor-browser-sandbox --prefix PATH : "${wrapperPath}"
    wrapProgram $out/bin/mullvad-browser-sandbox --prefix PATH : "${wrapperPath}"
  '';

  meta = with lib; {
    description = "Create isolated environments for various programs";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ gotlougit ];
  };
}
