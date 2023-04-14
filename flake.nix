{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    allSystemsPkgs = nixpkgs: value: forAllSystems (system: let pkgs = nixpkgs.legacyPackages.${system}; in value pkgs);
    usePkgs = value: allSystemsPkgs nixpkgs value;
  in
  {
    devShells = usePkgs (pkgs: {
      default = pkgs.callPackage ./shell.nix { };
    });
  };

}

