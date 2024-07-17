{ pkgs ? import <nixpkgs> {} }:
let
in
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    elixir
    elixir-ls
    erlang
  ];
}
