{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  users.users.dustinm.extraGroups = [ "docker" ];
}
