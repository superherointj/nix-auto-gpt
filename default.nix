{ pkgs
, python3
, stdenv
, lib
, ... }:

python3.pkgs.buildPythonApplication rec {
# stdenv.mkDerivation rec {
  pname = "auto-gpt";
  version = "0.0.1";

  # format = "setuptools";

  src = ./.;

  nativeBuildInputs = with python3.pkgs; [
    python3 # setuptools
  ];

  propagatedBuildInputs = with python3.pkgs; [
    beautifulsoup4
    colorama #==0.4.6
    openai #==0.27.2
    playsound #==1.2.2
    python-dotenv #==1.0.0
    pyyaml #==6.0
    readability-lxml #==0.8.1
    requests
    tiktoken #==0.3.3
    gtts # gTTS==2.3.1
    docker # docker
    duckduckgo-search
    google-api-python-client
    pinecone-client #==2.2.1
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