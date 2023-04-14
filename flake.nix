{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
  in
  {
    devShells = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        default = pkgs.callPackage ./shell.nix { };
      }
    );
  };

}

