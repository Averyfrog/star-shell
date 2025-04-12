{
  description = "Desktop shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    ags = {
      url = "github:aylur/ags";
    };

    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs = { self, nixpkgs, ags, flake-utils }:

  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    
    agsPackages = with ags.packages.${system}; [
      io
      astal4
      battery
      wireplumber
      network
      mpris
      powerprofiles
      tray
      bluetooth
      hyprland
      cava
    ];

    fonts = [
      pkgs.material-symbols
    ];

  in {
    
    packages.${system}.default = ags.lib.bundle { 
      inherit pkgs;
      src = ./.;
      name = "star-shell"; # name of executable
      entry = "app.ts";
      gtk4 = false;
      extraPackages = agsPackages ++ fonts;

    };

    devShells.${system}.default = pkgs.mkShell {
        buildInputs = fonts ++ [
          ags.packages.${system}.agsFull
        ];
    };
  };
}
