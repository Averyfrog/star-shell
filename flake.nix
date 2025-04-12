{
  description = "Desktop shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    ags = {
      url = "github:aylur/ags";
    };

  };

  outputs = { self, nixpkgs, ags }:

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

  in {
    
    packages.${system}.default = ags.lib.bundle { 
      inherit pkgs;
      src = ./.;
      name = "star-shell"; # name of executable
      entry = "app.ts";
      gtk4 = false;
      extraPackages = agsPackages ++ [
        pkgs.material-icons
      ];
    };

    devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          ags.packages.${system}.agsFull
        ];
    };
  };
}
