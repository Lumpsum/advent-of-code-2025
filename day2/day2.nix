{
  pkgs ? import <nixpkgs> { },
}:
let
  lib = pkgs.lib;

  isSame =
    input:
    let
      strValue = builtins.toString input;
      len = builtins.stringLength strValue;
      splitValue = len / 2;
      right = builtins.substring splitValue len strValue;
      left = builtins.substring 0 splitValue strValue;
      result = if right == left then input else 0;
    in
    result;

  isInvalidId =
    id:
    let
      len = builtins.stringLength id;
      half = builtins.floor (len / 2);
      nGramOptions = lib.range 1 half;
      isInvalid = builtins.any (x: x == true) (map (n: allSame (nGrams id n)) nGramOptions);
    in
    isInvalid;

  nGrams =
    s: n:
    let
      len = builtins.stringLength s;

      splitRec =
        index:
        if index >= len then
          [ ]
        else
          let
            chunk = builtins.substring index n s;
          in
          [ chunk ] ++ splitRec (index + n);
    in
    splitRec 0;

  allSame =
    l:
    let
      first = builtins.elemAt l 0;
    in
    builtins.all (x: x == first) l;
in
{
  inherit
    isSame
    allSame
    nGrams
    isInvalidId 
    ;
}
