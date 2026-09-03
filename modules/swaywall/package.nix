let
  pkgs = import <nixpkgs> {};
in
  pkgs.python3Packages.buildPythonPackage {
    name = "swaywall";
    pname = "swaywall";
    src = pkgs.fetchFromGitHub {
      owner = "cycneuramus";
      repo = "swaywall";
      rev = "v0.3.1";
      hash = "sha256-VWmq9Z+q4epPWe7emLwTpwvdWpekqxSNMeGLBkLethk=";
    };
    #dontbuild = true;
    /*
    buildInputs = [
      pkgs.poetry
    ];
    */
    pyproject = true;
    buildSystem = with pkgs.python3Packages; [setuptools];
    nativeBuildInputs = with pkgs.python3Packages; [
      poetry-core
    ];
    #unpackPhase = "unzip -c $src > ";
  }
