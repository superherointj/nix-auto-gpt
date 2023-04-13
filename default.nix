{ pkgs
, python3
, stdenv
, lib
, ... }:

python3.pkgs.buildPythonApplication rec {
# stdenv.mkDerivation rec {
  pname = "auto-gpt";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = with python3.pkgs; [
    python3
  ];

  propagatedBuildInputs = with python3.pkgs; [
    beautifulsoup4
    colorama
    openai
    playsound
    python-dotenv
    pyyaml
    readability-lxml
    requests
    tiktoken
    gtts
    docker
    duckduckgo-search
    google-api-python-client
    pinecone-client
    redis
    orjson
    pillow
  ];

  doCheck = false;

  # scripts/main.py
  # "python", "main.py"

  # installPhase = ''

  # '';
  # postInstall = ''
  #   wrapProgram $out/bin/lldb --prefix PYTHONPATH : $lib/${python3.sitePackages}/
  # '';

  meta = {
    description = "";
    homepage = "https://github.com/Torantulino/Auto-GPT";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
