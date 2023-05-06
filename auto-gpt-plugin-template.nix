{ fetchPypi
, python3
, callPackage
}:
let
  abstract_singleton = callPackage ./abstract-singleton.nix { };
in
python3.pkgs.buildPythonPackage rec {
  pname = "auto_gpt_plugin_template";
  version = "0.0.3";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-P1ERD3jbSQqJpRQvzfRBdu8IgSWkGPUHsQDoE+pa/QY=";
  };

  nativeBuildInputs = with python3.pkgs; [
    hatchling
    abstract_singleton
  ];

  doCheck = false;
}
