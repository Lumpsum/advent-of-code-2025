{
  pkgs ? import <nixpkgs> { },
}:
let
  lib = pkgs.lib;

  createList =
    file: split:
    let
      fileContents = builtins.readFile file;
      splitString = lib.strings.splitString split fileContents;
    in
    lib.strings.filter (s: s != "") splitString;

  sum = (acc: x: acc + x);

in
{
  math = {
    inherit sum;
  };

  list = {
    inherit createList;
  };
}
