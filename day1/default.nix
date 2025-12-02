{
  pkgs ? import <nixpkgs> { },
  initialValue ? 50,
}:
let
  utils = import ../utils.nix { inherit pkgs; };
  day1 = import ./day1.nix { inherit pkgs; };

  initialSet = {
    currentItem = initialValue;
    result = 0;
  };

  calculateValue =
    set: newItem:
    let
      setup = day1.setup newItem;
      modValue = set.currentItem + setup.modValue;

      value = day1.exactZero modValue;
      result = if value == 0 then set.result + 1 else set.result;
    in
    {
      inherit result;
      currentItem = value;
    };

  calculateValueDay2 =
    set: newItem:
    let
      setup = day1.setup newItem;

      modValue = set.currentItem + setup.modValue;
      value = day1.zeroOrTurned modValue set;
    in
    {
      currentItem = value.moduloValue;
      result = set.result + setup.posModValue + value.addResult;
    };

  examplePartOne =
    (builtins.foldl' calculateValue initialSet (utils.list.createList ./example.txt "\n")).result;
  examplePartTwo =
    (builtins.foldl' calculateValueDay2 initialSet (utils.list.createList ./example.txt "\n")).result;
  partOne =
    (builtins.foldl' calculateValue initialSet (utils.list.createList ../inputs/day1/input.txt "\n"))
    .result;
  partTwo =
    (builtins.foldl' calculateValueDay2 initialSet (
      utils.list.createList ../inputs/day1/input.txt "\n"
    )).result;
in
{
  inherit
    examplePartOne
    examplePartTwo
    partOne
    partTwo
    ;
}
