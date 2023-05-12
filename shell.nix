{ callPackage
, mkShellNoCC
, python3
}:

let pythonPackages = p: with p;
  [
    abstract-singleton
    openapi-python-client
    auto-gpt-plugin-template
    httpcore
    httpx
    distro
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
    selenium
    webdriver-manager
    jsonschema
    tweepy
    click
    spacy
    spacy_models.en_core_web_sm

    ## Dev
    coverage
    flake8
    numpy
    #pre-commit # Needs to confirm package at Nixpkgs.
    black
    isort
    GitPython

    # Testing dependencies
    pytest
    asynctest
    pytest-asyncio
    pytest-benchmark
    pytest-cov
    #pytest-integration # Needs to confirm package at Nixpkgs.
    pytest-mock
  ];
in

mkShellNoCC {
  pname = "auto-gpt";
  version = "0.0.1"; # bogus development version

  buildInputs = [
    (python3.withPackages pythonPackages)
  ];

  shellHook = ''
    tput setaf 2; echo "=== Auto-GPT Flake Environment ==="; tput sgr0; echo
    if ! test -e ".env"; then
      tput setaf 3; echo "ATTENTION:"; tput sgr0; tput setaf 5
      echo '- File ".env" is missing:'
      echo '  - Rename ".env.template" to ".env".'
      echo "  - Obtain your API keys from:"
      echo "    * https://www.pinecone.io/"
      echo "    * https://platform.openai.com/account/api-keys"
      echo '  - Configure at ".env":'
      echo "    1. OPENAI_API_KEY"
      echo "    2. PINECONE_API_KEY"
      echo "    3. PINECONE_ENV"
      tput sgr0
    else
      checkKey () {
        KEY_NAME="$1"
        KEY_VALUE="$2"
        MSG="$3"
        if [[ `cat .env | grep "$KEY_NAME" | cut -d'=' -f2` == "$KEY_VALUE" ]]; then
          tput setaf 3; printf "Attention: "; tput sgr0
          echo "$KEY_NAME is unchanged."
          tput setaf 4; echo "$MSG"; tput sgr0; echo
        fi
      }
      checkKey "PINECONE_API_KEY" "your-pinecone-api-key" "Update \".env\" file with Pinecone API Keys obtained from: https://www.pinecone.io/"
      checkKey "PINECONE_ENV"     "your-pinecone-region"  "Update \".env\" file with API Keys environment value obtained from: https://www.pinecone.io/"
      checkKey "OPENAI_API_KEY"   "your-openai-api-key"   "Update \".env\" file with OpenAI API key obtained from: https://platform.openai.com/account/api-keys"
    fi
    tput setaf 13; echo "  - To run Auto-GPT, execute:"; echo
    echo "    python -m autogpt"; tput sgr0; echo
  '';
}
