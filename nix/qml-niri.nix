{
  stdenv,
  src,
  qt6,
  cmake,
}:
stdenv.mkDerivation {
  inherit src;
  pname = "qml-niri";
  version = src.shortRev;

  buildInputs = [
    qt6.qtbase
    qt6.qtdeclarative
  ];

  # outputs = ["out" "dev"];

  installPhase = ''
    mkdir -p $out/lib/qt-6/qml/
    cp -r Niri $out/lib/qt-6/qml/
  '';

  nativeBuildInputs = [
    cmake
    qt6.wrapQtAppsHook
  ];
}
