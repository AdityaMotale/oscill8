{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {  nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells = {
          default = pkgs.mkShell {
            name = "dev";
            buildInputs = with pkgs; [
              gcc
              gdb
              perf
              nasm
              gcc.libc
              glibc.static
              linuxPackages.perf
            ];

            shellHook = ''
              echo " : $(nasm --version)"
            '';
          };
        };
       }
    );
}
