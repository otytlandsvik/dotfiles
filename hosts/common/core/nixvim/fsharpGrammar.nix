{
  stdenv,
  pkgs,
  nodejs,
  tree-sitter,
  lib,
}:
# Custom fsharp tree-sitter grammar derivation to accomodate the non-standard file-tree of tree-sitter-fsharp
stdenv.mkDerivation {
  pname = "fsharp-grammar";
  name = "fsharp-grammar";
  src = pkgs.fetchFromGitHub {
    owner = "ionide";
    repo = "tree-sitter-fsharp";
    rev = "v0.1.0";
    hash = "sha256-9YSywEoXxmLbyj3K888DbrHUBG4DrGTbYesW/SeDVvs=";
  };
  meta.homepage = "https://github.com/ionide/tree-sitter-fsharp";

  nativeBuildInputs = lib.optionals false [
    nodejs
    tree-sitter
  ];

  CFLAGS = [
    "-Isrc"
    "-O2"
  ];
  CXXFLAGS = [
    "-Isrc"
    "-O2"
  ];

  stripDebugList = [ "parser" ];

  configurePhase = ''
    cd fsharp
  '';

  # When both scanner.{c,cc} exist, we should not link both since they may be the same but in
  # different languages. Just randomly prefer C++ if that happens.
  buildPhase = ''
    runHook preBuild
    if [[ -e src/scanner.cc ]]; then
      $CXX -fPIC -c src/scanner.cc -o scanner.o $CXXFLAGS
    elif [[ -e src/scanner.c ]]; then
      $CC -fPIC -c src/scanner.c -o scanner.o $CFLAGS
    fi
    $CC -fPIC -c src/parser.c -o parser.o $CFLAGS
    rm -rf parser
    $CXX -shared -o parser *.o
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir $out
    mv parser $out/
    if [[ -d ../queries ]]; then
      cp -r ../queries $out
    fi
    runHook postInstall
  '';
}
