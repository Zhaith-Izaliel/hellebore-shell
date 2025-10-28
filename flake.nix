{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    qml-niri = {
      url = "github:imiric/qml-niri";

      flake = false;
    };
  };

  outputs = inputs @ {
    flake-parts,
    quickshell,
    qml-niri,
    ...
  }: let
    version = "1.0.0";
    name = "hellebore-shell";
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {pkgs, ...}: {
        devShells = {
          default = let
            qml-niri = withSystem pkgs.stdenv.hostPlatform.system ({config, ...}: config.packages.qml-niri);
            qtEnv = with pkgs.qt6;
              env "qt-custom-${qtbase.version}" [
                qtdeclarative
                qtsvg
                qtimageformats
                qml-niri
              ];
            quickshell-package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
            quickshellWithModule = quickshell-package.withModules [qtEnv];
          in
            pkgs.mkShell {
              nativeBuildInputs = [
                qtEnv
                quickshellWithModule
                qml-niri
              ];
            };
        };

        packages = {
          default = pkgs.callPackage ./nix {inherit version name;};

          qml-niri = pkgs.callPackage ./nix/qml-niri.nix {src = qml-niri;};
        };
      };
    });
}
