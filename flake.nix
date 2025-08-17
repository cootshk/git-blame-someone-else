{
  description = "Blame someone else for your bad code.";
  nixConfig = {
    extra-substituters = "https://cootshk.cachix.org";
    extra-trusted-public-keys = "cootshk.cachix.org-1:yt4kcEbYvyd1Xs/H2Uw7VNOl1EjAiTdef/ZjyQY09CU=";
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    inputs@{
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default =
          with pkgs;
          stdenv.mkDerivation {
            pname = "git-blame-someone-else";
            version = "1.0.0";
            src = ./.;
            buildInputs = [ git ];
            installPhase = ''
              mkdir -p $out/bin
              cp git-blame-someone-else $out/bin/git-blame-someone-else
              chmod +x $out/bin/git-blame-someone-else
            '';
          };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            git
          ];
        };
      }
    );
}
