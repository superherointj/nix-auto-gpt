{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-friendly-overlay.url = "github:nixpkgs-friendly/nixpkgs-friendly-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-friendly-overlay }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      allSystemsPkgs = nixpkgs: value: forAllSystems (system:
        let pkgs =
          import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              nixpkgs-friendly-overlay.overlays.default
            ];
          };
        in value pkgs
      );
      usePkgs = value: allSystemsPkgs nixpkgs value;
    in
    {
      packages = usePkgs (pkgs: rec {
        pkgsDebug = pkgs; # Useful for building anything from pkgs, including nixpkgs-friendly-overlay
      });

      devShells = usePkgs (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });
    };

}
