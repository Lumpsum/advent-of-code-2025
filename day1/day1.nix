{
  pkgs ? import <nixpkgs> { },
}:
let
  lib = pkgs.lib;

  splitOnIndex =
    input: splitIndex:
    let
      length = builtins.stringLength input;
      value = builtins.substring splitIndex length input;
      leftOrRight = if builtins.substring 0 splitIndex input == "L" then "-" + value else value;
    in
    lib.strings.toIntBase10 leftOrRight;

  exactZero =
    newValue:
    if newValue > 99 then
      0 + (newValue - 100)
    else if newValue < 0 then
      100 + newValue
    else
      newValue;

  zeroOrTurned =
    moduloValue: set:
    if moduloValue > 99 then
      {
        addResult = if set.currentItem != 0 then 1 else 0;
        moduloValue = 0 + (moduloValue - 100);
      }
    else if moduloValue < 0 then
      {
        addResult = if set.currentItem != 0 then 1 else 0;
        moduloValue = 100 + moduloValue;
      }
    else
      {
        addResult = if moduloValue == 0 then 1 else 0;
        moduloValue = moduloValue;
      };

  setup =
    newItem:
    let
      convertedNewItem = splitOnIndex newItem 1;
      c = builtins.floor (convertedNewItem / 100);
      modValue = convertedNewItem - c * 100;
      posModValue = if c < 0 then -c else c;
    in
    {
        inherit modValue posModValue;
    };
in
{
  inherit splitOnIndex exactZero zeroOrTurned setup;
}
