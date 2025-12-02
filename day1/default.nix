{
  pkgs ? import <nixpkgs> { },
  initialValue ? 50,
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

  splitOnIndex =
    input: splitIndex:
    let
      length = builtins.stringLength input;
      value = builtins.substring splitIndex length input;
      leftOrRight = if builtins.substring 0 splitIndex input == "L" then "-" + value else value;
    in
    lib.strings.toIntBase10 leftOrRight;

  initialSet = {
    currentItem = initialValue;
    result = 0;
  };

  calculateValue =
    set: newItem:
    let
      convertedNewItem = splitOnIndex newItem 1;
      c = builtins.floor (convertedNewItem / 100);
      modValue = convertedNewItem - c * 100;

      newValue = set.currentItem + modValue;
      value =
        if newValue > 99 then
          0 + (newValue - 100)
        else if newValue < 0 then
          100 + newValue
        else
          newValue;
      result = if value == 0 then set.result + 1 else set.result;
    in
    {
      inherit result;
      currentItem = value;
    };

  example = (builtins.foldl' calculateValue initialSet (createList ./example.txt)).result;
  day1 = (builtins.foldl' calculateValue initialSet (createList ../inputs/day1/day1.txt)).result;
  day2 = (builtins.foldl' calculateValue initialSet (createList ./example.txt)).result;
in
{
  inherit example day1 day2;
}
