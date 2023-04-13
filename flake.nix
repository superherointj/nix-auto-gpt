{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in {
        # defaultPackage.x86_64-linux = pkgs.callPackage ./default.nix { };
        devShell = pkgs.callPackage ./shell.nix { };
      }
    );

}