{
  stdenv,
  lib,
  version,
  name,
}:
stdenv.mkDerivation {
  inherit version name;
  src = lib.cleanSource ../.;
}
