{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./config/bat.nix
    ./config/git.nix
    ./config/qutebrowser.nix
    ./config/secrets.nix
    ./config/kitty.nix
    ./config/kanata.nix
  ];

  home.username = "dustinm";
  home.homeDirectory = "/home/dustinm";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
