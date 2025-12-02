let
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
in
{
  inherit
    isSame
    ;
}
