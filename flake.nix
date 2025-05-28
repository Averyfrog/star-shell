{
  description = "Desktop shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    ags = {
      url = "github:aylur/ags";
    };

    astal = {
      url = "github:aylur/astal";
    };

  };

  outputs = { self, nixpkgs, astal, ags }:

  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    
    fonts = [
      pkgs.material-symbols
    ];

  in {

    packages.${system}. default = pkgs.stdenvNoCC.mkDerivation rec {
      name = "star-shell";
      src = ./.;

      nativeBuildInputs = [
        ags.packages.${system}.agsFull
        pkgs.wrapGAppsHook
        pkgs.gobject-introspection
      ];

      buildInputs = with astal.packages.${system}; [
        astal3
        io
        # any other package
      ];

      installPhase = ''
        mkdir -p $out/bin
        ags bundle app.ts $out/bin/${name}
        chmod +x $out/bin/${name}
      '';
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = fonts ++ [
        ags.packages.${system}.agsFull
      ];
    };
  };
}
