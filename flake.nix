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

    packages.${system}. default = ags.lib.bundle {
      inherit pkgs;
      gtk4 = false;
      name = "star-shell";
      src = ./.;

      extraPackages = [
        ags.packages.${system}.agsFull
        astal.packages.${system}.hyprland
        astal.packages.${system}.mpris
        astal.packages.${system}.battery
        astal.packages.${system}.wireplumber
      ];

      };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = fonts ++ [
        ags.packages.${system}.agsFull
      ];
    };
  };
}
