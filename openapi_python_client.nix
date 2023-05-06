{ fetchPypi
, python3
}:

python3.pkgs.buildPythonPackage rec {
  pname = "openapi_python_client";
  version = "0.14.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-R/mG9DSUogNSHqAeBfdxL2HUvkHNu9kMJuFcu6G7kLs=";
  };

  nativeBuildInputs = with python3.pkgs; [
    poetry-core
    pyyaml
    typer
    autoflake
    httpx
    python-dateutil
    jinja2
    black
    pydantic
    attrs
    isort
    shellingham
  ];

  doCheck = false;
}
