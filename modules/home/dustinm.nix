{ config, lib, pkgs, ... }:

{
  imports = [
    ./config/bat.nix
    ./config/git.nix
  ];

  home.username = "dustinm";
  home.homeDirectory = "/home/dustinm";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
