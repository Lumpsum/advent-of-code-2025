{
  pkgs ? import <nixpkgs> { },
}:
let
  lib = pkgs.lib;
  utils = import ../utils.nix { inherit pkgs; };
  day2 = import ./day2.nix { inherit pkgs; };

  partOne =
    p:
    let
      input = utils.list.createList p ",";

      rangeLists = lib.flatten (
        map (
          item:
          lib.range (lib.strings.toIntBase10 (builtins.elemAt item 0)) (
            lib.strings.toIntBase10 (builtins.elemAt item 1)
          )
        ) (map (item: lib.strings.splitString "-" item) input)
      );

      valid = map (innerItem: (day2.isSame innerItem)) rangeLists;
    in
    builtins.foldl' utils.math.sum 0 valid;

  partTwo =
    p:
    let
      input = utils.list.createList p ",";

      rangeLists = lib.flatten (
        map (
          item:
          lib.range (lib.strings.toIntBase10 (builtins.elemAt item 0)) (
            lib.strings.toIntBase10 (builtins.elemAt item 1)
          )
        ) (map (item: lib.strings.splitString "-" item) input)
      );

      invalidIds = builtins.filter (x: day2.isInvalidId (builtins.toString x) == true) rangeLists;
    in
    builtins.foldl' utils.math.sum 0 invalidIds;
in
{
  examplePartOne = partOne ./example.txt;
  partOne = partOne ../inputs/day2/input.txt;

  examplePartTwo = partTwo ./example.txt;
  partTwo = partTwo ../inputs/day2/input.txt;
}
