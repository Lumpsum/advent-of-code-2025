{
  pkgs ? import <nixpkgs> { },
}:
let
  lib = pkgs.lib;

  createList =
    file:
    let
      fileContents = builtins.readFile file;
      splitString = lib.strings.splitString "\n" fileContents;
    in
    lib.strings.filter (s: s != "") splitString;
in
{
   inherit  createList; 
}
