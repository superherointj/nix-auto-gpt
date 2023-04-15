{ fetchFromGitHub
, lib
, python3
}:

python3.pkgs.buildPythonPackage rec {
  pname = "sourcery";
  version = "1.2.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "sourcery-ai";
    repo = "sourcery";
    rev = "v${version}";
    hash = "sha256-KQLTOCMLczUwO6E3uZCdTUfvnr1D3sl4Bw6lWjPXkh8=";
  };

  # propagatedBuildInputs = with python3.pkgs; [ ];

  nativeBuildInputs = with python3.pkgs; [
    setuptools
  ];

  # nativeCheckInputs = with python3.pkgs; [
  #   pytestCheckHook
  # ];
  doCheck = false;

  # pythonImportsCheck = [ "" ];

  meta = {
    description = "A Python library that automatically reviews and improves Python code";
    homepage = "https://github.com/sourcery-ai/sourcery";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
