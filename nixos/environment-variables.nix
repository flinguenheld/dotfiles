{ pkgs, ... }:

{
  # Setup Env Variables
  environment = with pkgs; {
    shells = [ bash fish ];
    variables = {
      EDITOR = "helix";
    };
  };
}
