{
  pkgs ? import <nixpkgs> { },
}:
let
  lib = pkgs.lib;
  utils = import ../utils.nix { inherit pkgs; };
  day2 = import ./day2.nix;

  partOne =
    p:
    let
      input = utils.list.createList p ",";

      rangeLists = map (
        item:
        lib.range (lib.strings.toIntBase10 (builtins.elemAt item 0)) (
          lib.strings.toIntBase10 (builtins.elemAt item 1)
        )
      ) (map (item: lib.strings.splitString "-" item) input);

      valid = map (item: map (innerItem: (day2.isSame innerItem)) item) rangeLists;
      result = builtins.foldl' utils.math.sum 0 (map (item: builtins.foldl' utils.math.sum 0 item) valid);
    in
    result;
in
{
  examplePartOne = partOne ./example.txt;
  partOne = partOne ../inputs/day2/input.txt;
}
