{ lib, stdenv, bubblewrap, xdg-dbus-proxy, makeBinaryWrapper }:

stdenv.mkDerivation rec {
  pname = "app-sandboxes";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeBinaryWrapper ];
  buildInputs = [ bubblewrap xdg-dbus-proxy ];

  wrapperPath = lib.makeBinPath ([
    bubblewrap
    xdg-dbus-proxy
  ]);

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/applications

    mv code-sandbox $out/bin
    mv build-sandbox $out/bin
    mv mullvad-browser-sandbox $out/bin
    mv mullvad-browser-sandbox-unrestricted $out/bin
    mv mullvadbrowser-sandbox.desktop $out/share/applications/

    mv tor-browser-sandbox $out/bin
    mv tor-browser-sandbox-unrestricted $out/bin
    mv torbrowser-sandbox.desktop $out/share/applications/

    mv okular-sandbox $out/bin
    mv org.kde.okular.desktop $out/share/applications/

    mv vlc-sandbox $out/bin
    mv vlc.desktop $out/share/applications/

  '';

  postFixup = ''
    wrapProgram $out/bin/code-sandbox --prefix PATH : "${wrapperPath}"
    wrapProgram $out/bin/build-sandbox --prefix PATH : "${wrapperPath}"
    wrapProgram $out/bin/tor-browser-sandbox --prefix PATH : "${wrapperPath}"
    wrapProgram $out/bin/mullvad-browser-sandbox --prefix PATH : "${wrapperPath}"
    wrapProgram $out/bin/okular-sandbox --prefix PATH : "${wrapperPath}"
    wrapProgram $out/bin/vlc-sandbox --prefix PATH : "${wrapperPath}"
  '';

  meta = with lib; {
    description = "Create isolated environments for various programs";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ gotlougit ];
  };
}
